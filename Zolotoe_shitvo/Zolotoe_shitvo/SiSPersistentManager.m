//
//  SiSPersistentManager.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSPersistentManager.h"
#import "SiSServerManager.h"
#import "SiSFirstViewController.h"

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

- (NSMutableArray*) getCategoriesProductsOfCategory: (NSInteger) category andName: (NSString*) nameOfCategory {
    
    self.tempProducts = [NSMutableArray array];
    
    NSString* directory = [NSString stringWithFormat:@"/Documents/%@.bin", nameOfCategory];
    NSData* data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:directory]];
    
    if (!data) {
        
        NSLog(@"tempProducts: Will fetch API!");
        
        [[SiSServerManager sharedManager] getProductsOfCategory:category
                                                     WithOffset:self.tempProducts.count
                                                       andCount:10
                                                      onSuccess:^(NSArray *productsArray) {
                                                          
                                                          NSLog(@"MITRASArray count is %lu", (unsigned long)productsArray.count);
                                                          
                                                          [self.tempProducts addObjectsFromArray:productsArray];
                                                          //[self saveTempProducts:directory];
                                                          
                                                      } onFailure:^(NSError *error) {
                                                          
                                                          NSLog(@"SiSPersistent Manager error = %@", [error localizedDescription]);
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"error" object:nil userInfo:nil];
                                                        
                                                          
                                                      }];
        
    } else {
        
        NSLog(@"tempProducts: Will NOT fetch API!");
        
        self.tempProducts = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return self.tempProducts;
}

- (NSMutableArray*) getCategoriesProductsOfCategory: (NSInteger) category andName: (NSString*) nameOfCategory withCount: (NSInteger) count {
    
    NSMutableArray* tempProducts = [NSMutableArray array];
    NSMutableArray* tempProducts2 = [NSMutableArray array];
    NSString* directory = [NSString stringWithFormat:@"/Documents/%@.bin", nameOfCategory];
    NSData* data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:directory]];
    
    tempProducts = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    [[SiSServerManager sharedManager] getProductsOfCategory:category
                                                 WithOffset:tempProducts.count
                                                   andCount:10
                                                  onSuccess:^(NSArray *productsArray) {
                                                      
                                                      NSLog(@"MITRASArray count is %lu", (unsigned long)productsArray.count);
                                                      
                                                      [tempProducts2 addObjectsFromArray:productsArray];
                                                      //[self saveTempProducts:directory];
                                                      
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"tempProductsReady" object:nil userInfo:nil];
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                      NSLog(@"error = %@", [error localizedDescription]);
                                                  }];
    return tempProducts2;
}

- (void) saveOfferProducts {
    
    NSString* filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/offerProducts.bin"];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.offerProducts];
    [data writeToFile:filename atomically:YES];
}

- (void) saveTempProducts: (NSString*) directory {
    
    NSString* filename = [NSHomeDirectory() stringByAppendingString:directory];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.tempProducts];
    [data writeToFile:filename atomically:YES];
}

- (void) getCategoriesProductsOfCategory:(NSInteger)category
                                            andName:(NSString *)nameOfCategory
                                          onSuccess:(void (^)(NSArray *))success
                                          onFailure:(void (^)(NSError *))failure {
    
        
        [[SiSServerManager sharedManager] getProductsOfCategory:category
                                                     WithOffset:self.tempProducts.count
                                                       andCount:10
                                                      onSuccess:^(NSArray *productsArray) {
                                                          
                                                          if (success) {
                                                              
                                                              success(productsArray);
                                                          }
                                                          
                                                      } onFailure:^(NSError *error) {

                                                          
                                                          
                                                      }];
        

    
    
}

@end
