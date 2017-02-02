//
//  SiSContactsViewController.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 30.01.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSUITabBarItem.h"

@interface SiSContactsViewController : SiSUITabBarItem

- (IBAction)makeCall:(id)sender;
- (IBAction)sendLetter:(id)sender;
- (IBAction)makeSkypeCall:(id)sender;
- (IBAction)openMap:(id)sender;

@end
