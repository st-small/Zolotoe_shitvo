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
#import "SiSProduct.h"

@interface SiSOneCategoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;

@end

@implementation SiSOneCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.selfTitle;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"< Назад" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed:)];
    
    self.navigationItem.leftBarButtonItem = btn;
    
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)backPressed: (id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.hidesBarsOnSwipe = YES;
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
    
    SiSProduct* prd = [self.productsArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = prd.title;
    cell.idProductLabel.text = prd.idProduct;
    cell.imgView.image = prd.img;
    
//    cell.imgView.layer.shadowColor = [UIColor blackColor].CGColor;
//    cell.imgView.layer.shadowOffset = CGSizeMake(5, 2);
//    cell.imgView.layer.shadowOpacity = 1;
//    cell.imgView.layer.shadowRadius = 1.0;
//    
//    cell.imgView.clipsToBounds = YES;
//    cell.imgView.layer.cornerRadius = 8.0;
//    cell.imgView.layer.borderWidth = 2.0;
//    cell.imgView.layer.borderColor = [UIColor colorWithRed:255/255.f green:219/255.f blue:148/255.f alpha:1].CGColor;
    
    CALayer* mask = [CALayer layer];
    mask.frame = cell.imgView.frame;
    cell.imgView.layer.mask = mask;
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //cell.imgView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.imgView.layer.shadowOffset = CGSizeMake(10, 10);
    cell.imgView.layer.shadowRadius = 10;
    cell.imgView.layer.shadowOpacity = 1;
    
    return cell;
}


@end
