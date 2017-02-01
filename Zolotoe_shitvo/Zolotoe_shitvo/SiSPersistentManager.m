//
//  SiSPersistentManager.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSPersistentManager.h"
#import "SiSServerManager.h"

@implementation SiSPersistentManager

- (id)init {
    
    self = [super init];
    if (self) {
        
    } return self;
}

+ (SiSPersistentManager*) sharedManager {
    
    static SiSPersistentManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        
        manager = [[SiSPersistentManager alloc] init];
        
    });
    
    return manager;
}

- (NSMutableArray*) getOfferProducts {
    
    self.offerProducts = [NSMutableArray array];
    
    NSData* data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/offerProducts.bin"]];
    
    if (!data) {
        
        NSLog(@"Will fetch API!");
        
        [[SiSServerManager sharedManager] getProductsWithOfferParameterAndOffset:self.offerProducts.count
                                                                        andCount:10
                                                                       onSuccess:^(NSArray* productsArray) {
                                                                           
                                                                           NSLog(@"productsArray count is %lu", (unsigned long)productsArray.count);
                                                                           
                                                                           [self.offerProducts addObjectsFromArray:productsArray];
                                                                           
                                                                           [self saveOfferProducts];
                                                                           
                                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"offerProductsReady" object:nil userInfo:nil];
                                                                           
                                                                       } onFailure:^(NSError *error) {
                                                                           
                                                                           NSLog(@"error = %@", [error localizedDescription]);
                                                                           
                                                                       }];
    } else {
        
        NSLog(@"Will NOT fetch API!");
        
        self.offerProducts = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return self.offerProducts;
}

- (void) saveOfferProducts {
    
    NSString* filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/offerProducts.bin"];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.offerProducts];
    [data writeToFile:filename atomically:YES];
}

@end
