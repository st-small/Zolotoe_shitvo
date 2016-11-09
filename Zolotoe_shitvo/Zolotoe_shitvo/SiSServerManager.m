//
//  SiSServerManager.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//
//  В этом классе реализуется обращение к серверу и получение массивов товаров. SiSServerManager является синглтоном (вызывается единожды).

#import "SiSServerManager.h"

@implementation SiSServerManager

+ (SiSServerManager*) sharedManager {
    
    static SiSServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        
        manager = [[SiSServerManager alloc] init];
    });
    
    return manager;
}

- (void) getProductsWithOffset: (NSInteger) offset
                      andCount: (NSInteger) count
                     onSuccess: (void(^)(NSArray* productsArray)) success
                     onFailure: (void(^)(NSError* error)) failure;

- (void) getProductsWithOfferParameterAndOffset: (NSInteger) offset
                                       andCount: (NSInteger) count
                                      onSuccess: (void(^)(NSArray* productsArray)) success
                                      onFailure: (void(^)(NSError* error)) failure;


@end
