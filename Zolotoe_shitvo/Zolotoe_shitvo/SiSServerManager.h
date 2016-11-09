//
//  SiSServerManager.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiSServerManager : NSObject

+ (SiSServerManager*) sharedManager;

- (void) getProductsWithOffset: (NSInteger) offset
                      andCount: (NSInteger) count
                     onSuccess: (void(^)(NSArray* productsArray)) success
                     onFailure: (void(^)(NSError* error)) failure;

- (void) getProductsWithOfferParameterAndOffset: (NSInteger) offset
                                       andCount: (NSInteger) count
                                      onSuccess: (void(^)(NSArray* productsArray)) success
                                      onFailure: (void(^)(NSError* error)) failure;

@end
