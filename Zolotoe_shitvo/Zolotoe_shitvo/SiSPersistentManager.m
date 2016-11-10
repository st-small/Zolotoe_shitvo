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
    
    [[SiSServerManager sharedManager] getProductsWithOfferParameterAndOffset:self.offerProducts.count
                                                                    andCount:100
                                                                   onSuccess:^(NSArray* productsArray) {
                                                                       
                                                                       [self.offerProducts addObjectsFromArray:productsArray];
                                                                       
                                                                   } onFailure:^(NSError *error) {
                                                                       
                                                                       NSLog(@"error = %@", [error localizedDescription]);
                                                                   
                                                                   }];
    
    return self.offerProducts;
}

@end
