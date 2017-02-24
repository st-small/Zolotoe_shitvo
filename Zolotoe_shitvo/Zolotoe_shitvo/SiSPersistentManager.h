//
//  SiSPersistentManager.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//
//  Этот класс отвечает за выборку данных с сайта, передачу их в контроллеры и архивацию для последующего использования в режиме офллайн

#import <Foundation/Foundation.h>

@interface SiSPersistentManager : NSObject

@property (strong, nonatomic) NSMutableArray* offerProducts;
@property (strong, nonatomic) NSMutableArray* allProducts;
@property (strong, nonatomic) NSMutableArray* tempProducts;

+ (SiSPersistentManager*) sharedManager;

- (NSMutableArray*) getOfferProducts;
- (NSMutableArray*) getCategoriesProductsOfCategory: (NSInteger)category andName: (NSString*) nameOfCategory;
- (NSMutableArray*) getCategoriesProductsOfCategory: (NSInteger) category andName: (NSString*) nameOfCategory withCount: (NSInteger) count;

- (void) getCategoriesProductsOfCategory: (NSInteger)category
                                            andName: (NSString*) nameOfCategory
                                          onSuccess: (void(^)(NSArray* productsArray)) success
                                          onFailure: (void(^)(NSError* error)) failure;
@end
