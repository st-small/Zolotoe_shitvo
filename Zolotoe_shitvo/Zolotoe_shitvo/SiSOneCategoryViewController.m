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
@property (strong, nonatomic) NSMutableArray* tempProducts;
@property (assign, nonatomic) BOOL loadingData;

@end

@implementation SiSOneCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingData = NO;
    self.tempProducts = [NSMutableArray array];

    self.navigationItem.title = self.selfTitle;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"< Назад" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed:)];
    
    self.navigationItem.leftBarButtonItem = btn;
    
    self.navigationController.navigationBarHidden = NO;
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"test"];
    [refresh addTarget:self
                action:@selector(updateUI)
      forControlEvents:UIControlEventValueChanged];
    self.tableViewOutlet.refreshControl = refresh;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"tempProductsReady"
                                               object:nil];
    
}

- (void) updateUI {
    
    [self.productsArray addObjectsFromArray:self.tempProducts];
    
    NSMutableArray* newPaths = [NSMutableArray array];
    for (NSUInteger i = self.productsArray.count - self.tempProducts.count; i < self.productsArray.count; i++) {
        
        [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self.tableViewOutlet beginUpdates];
    [self.tableViewOutlet insertRowsAtIndexPaths:newPaths
                          withRowAnimation:UITableViewRowAnimationTop];
    [self.tableViewOutlet endUpdates];
    
    self.loadingData = NO;
    [self.tableViewOutlet.refreshControl endRefreshing];
}

-(void)backPressed: (id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.hidesBarsOnSwipe = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.productsArray.count;
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
    
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 10.0;
    cell.imgView.layer.borderWidth = 1.0;
    cell.imgView.layer.borderColor = [UIColor colorWithRed:255/255.f green:219/255.f blue:148/255.f alpha:1].CGColor;
    
    cell.shadow.layer.cornerRadius = 10.0f;
    cell.shadow.layer.masksToBounds = NO;
    cell.shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.shadow.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    cell.shadow.layer.shadowOpacity = 1.f;
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData) {
            
            self.loadingData = YES;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                
                self.tempProducts = [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:[self.categoryID integerValue] andName:@"Mitres" withCount:self.productsArray.count];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableViewOutlet reloadData];
                });
            });
            
        }
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    NSLog(@"self.categoryID = %d, indexPath = %ld, array count = %lu", [self.categoryID intValue], (long)indexPath.row, (unsigned long)self.productsArray.count);
//    
//    if (indexPath.row == self.productsArray.count - 1) {
//        self.tempProducts = [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:[self.categoryID intValue] andName:@"Mitres" withCount:self.productsArray.count];
//    }
//    
//}


@end
