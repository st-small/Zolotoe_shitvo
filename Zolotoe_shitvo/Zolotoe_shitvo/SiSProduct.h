//
//  SiSProduct.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiSProduct : NSObject

@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* idProduct;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) UIImage* img;

- (instancetype) initWithSingleDict:(NSDictionary*)singleProduct;

@end
