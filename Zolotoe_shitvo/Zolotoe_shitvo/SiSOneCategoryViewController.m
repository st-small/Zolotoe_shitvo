//
//  SiSOneCategoryViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 03.02.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSOneCategoryViewController.h"
#import "SiSTabBarControllerViewController.h"
#import "SiSCategoriesViewController.h"
#import "SiSPersistentManager.h"

@interface SiSOneCategoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;

@end

@implementation SiSOneCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Золотое шитье:";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor grayColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Avenir Next" size:23.0], NSFontAttributeName, nil]];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed:)];
    self.navigationItem.leftBarButtonItem = btn;
    
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)backPressed: (id)sender {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SiSTabBarControllerViewController* vc = [sb instantiateViewControllerWithIdentifier:@"SiSTabBarControllerViewController"];
    SiSCategoriesViewController* vc2 = [vc.viewControllers objectAtIndex:0];
    vc2.offerProducts = [[SiSPersistentManager sharedManager] getOfferProducts];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:vc
                                            animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    SiSCategoriesViewCell* cell = [self.tableViewOutlet dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[SiSCategoriesViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.titleLabel.text = @"123";
    cell.idProductLabel.text = [NSString stringWithFormat:@"Артикул: 123"];
    
    return cell;
}





@end
