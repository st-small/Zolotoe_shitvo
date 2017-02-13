//
//  SiSCategoriesViewCell.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 03.02.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiSCategoriesViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *shadow;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *idProductLabel;
@property (weak, nonatomic) NSString* idProduct;
@property (weak, nonatomic) NSString* title;

@end
