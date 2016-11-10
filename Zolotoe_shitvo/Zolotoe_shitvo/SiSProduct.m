//
//  SiSProduct.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 09.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
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
        
        //Достаю ссылку на фотку для предпросмотра
        NSDictionary* imageDict = singleProduct[@"better_featured_image"];
        self.imageURL = [NSURL URLWithString:imageDict[@"source_url"]];
        //NSLog(@"source url: %@", self.imageURL);
        
        //Достаю фотку для предпросмотра
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
        self.img = [UIImage imageWithData: imageData];
    
    }
        
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder {
    
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.idProduct forKey:@"id"];
    [aCoder encodeObject:self.imageURL forKey:@"img_url"];
    [aCoder encodeObject:self.img forKey:@"img"];
    
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder {
    
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _idProduct = [aDecoder decodeObjectForKey:@"id"];
        _imageURL = [aDecoder decodeObjectForKey:@"img_url"];
        _img = [aDecoder decodeObjectForKey:@"img"];
    }
    return self;
}

@end
