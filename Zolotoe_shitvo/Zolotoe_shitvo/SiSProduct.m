//
//  SiSProduct.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSProduct.h"

@implementation SiSProduct

- (id) initWithSingleDict:(NSDictionary*)singleProduct {
    
    self = [super init];
    if (self) {
        
        //Достаю название товара
        NSDictionary* titleDict = singleProduct[@"title"];
        self.title = [titleDict objectForKey:@"rendered"];
        
        //Достаю артикул
        NSString* idProduct = [NSString stringWithFormat:@"%@", singleProduct[@"id"]];
        self.idProduct = idProduct;
        
        //Достаю фотку для предпросмотра
        NSDictionary* imageDict = singleProduct[@"better_featured_image"];
        self.imageURL = imageDict[@"source_url"];
        NSLog(@"source url: %@", self.imageURL);
    }
    
    return self;
}

@end
