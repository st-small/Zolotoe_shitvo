//
//  SiSAboutUsViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 12.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSAboutUsViewController.h"

@interface SiSAboutUsViewController ()

@end

@implementation SiSAboutUsViewController


- (IBAction)makeCall:(UIButton *)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://+380505254567"]];
    
    NSLog(@"calling...");
}
@end
