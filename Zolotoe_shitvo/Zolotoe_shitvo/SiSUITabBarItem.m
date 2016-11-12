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
    
    [self.tabBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Izhitsa" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.tabBarItem.title = @"fdkjhsf";
}

@end
