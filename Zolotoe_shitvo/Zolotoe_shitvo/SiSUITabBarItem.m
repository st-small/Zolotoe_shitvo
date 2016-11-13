//
//  SiSUITabBarItem.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 12.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSUITabBarItem.h"

@implementation SiSUITabBarItem

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Izhitsa" size:16.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];

}

@end
