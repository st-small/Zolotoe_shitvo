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
    
    if (self.offerProducts.count < 1) {
        
        NSLog(@"Will fetch API!");
        
        [[SiSServerManager sharedManager] getProductsWithOfferParameterAndOffset:self.offerProducts.count
                                                                        andCount:10
                                                                       onSuccess:^(NSArray* productsArray) {
                                                                           
                                                                           [self.offerProducts addObjectsFromArray:productsArray];
                                                                           
                                                                           [self saveOfferProducts];
                                                                           
                                                                       } onFailure:^(NSError *error) {
                                                                           
                                                                           NSLog(@"error = %@", [error localizedDescription]);
                                                                           
                                                                       }];
    } else {
        
        NSLog(@"Will NOT fetch API!");
        
            NSData* data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/offerProducts.bin"]];
        
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
