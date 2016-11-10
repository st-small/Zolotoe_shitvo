//
//  SiSPersistentManager.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiSPersistentManager : NSObject

@property (strong, nonatomic) NSMutableArray* offerProducts;
@property (strong, nonatomic) NSMutableArray* allProducts;

+ (SiSPersistentManager*) sharedManager;

- (NSMutableArray*) getOfferProducts;


@end
