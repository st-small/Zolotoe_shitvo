//
//  SiSOneCategoryViewController.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 03.02.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SiSCategoriesViewCell.h"

@interface SiSOneCategoryViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* productsArray;
@property (copy, nonatomic) NSString* selfTitle;
@property (assign, nonatomic) NSNumber* categoryID;

@end
