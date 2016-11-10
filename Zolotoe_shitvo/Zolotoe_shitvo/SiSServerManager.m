//
//  SiSServerManager.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//
//  В этом классе реализуется обращение к серверу и получение массивов товаров. SiSServerManager является синглтоном (вызывается единожды).

#import "SiSServerManager.h"
#import "AFNetworking.h"
#import "SiSProduct.h"

static NSString* originLink = @"http://www.zolotoe-shitvo.kr.ua/wp-json/wp/v2/";

@interface SiSServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) NSURL* tempUrl;

@end

@implementation SiSServerManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@posts", originLink]];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    return self;
}

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
                     onFailure: (void(^)(NSError* error)) failure {
    
    
}

//  Этот метод возвращает массив товаров, размещенных на стартовой странице сайта (у них свойство "offer")
- (void) getProductsWithOfferParameterAndOffset: (NSInteger) offset
                                       andCount: (NSInteger) count
                                      onSuccess: (void(^)(NSArray* productsArray)) success
                                      onFailure: (void(^)(NSError* error)) failure {
    
    NSString* linkWithOffset = [NSString stringWithFormat:@"%@posts?filter[meta_key]=offer&filter[meta_value]=1&offset=%ld", originLink, (long)offset];
    
    [self.sessionManager GET:linkWithOffset
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask * task, id responseObject) {
                         
                         NSMutableArray* objectsArray = [NSMutableArray array];
                         
                         NSMutableArray* array = (NSMutableArray*)responseObject;
                         
                         for (NSUInteger i = 0; i < array.count; i++) {
                             
                             NSDictionary* singleProduct = array[i];
                             
                             //NSLog(@"новый жсон: %@", singleProduct);
                             
                             SiSProduct* product = [[SiSProduct alloc] initWithSingleDict:singleProduct];
                             
                             [objectsArray addObject:product];
                             
                         }
                         
                         if (success) {
                             
                             success(objectsArray);
                         }
                         
                     } failure:^(NSURLSessionTask* operation, NSError* error) {
                         
                         NSLog(@"Error: %@", error);
                         
                         if (failure) {
                             failure(error);
                         }
                     }];
    
    
}


@end
