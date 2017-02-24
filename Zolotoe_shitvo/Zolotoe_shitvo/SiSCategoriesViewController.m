//
//  SiSGategoriesViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 10.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSCategoriesViewController.h"
#import "SiSProduct.h"
#import "SiSCollectionViewCell.h"
#import "SiSPersistentManager.h"
#import "SiSOneCategoryViewController.h"

#define targetHeight 170

@interface SiSCategoriesViewController ()

typedef void(^myCompletion)(BOOL);

@property (strong, nonatomic) NSMutableArray* imagesArray;
@property (strong, nonatomic) NSMutableArray* imagesIDs;
@property (weak, nonatomic) IBOutlet UICollectionView *itemsTable;

@property (nonatomic, assign) CGPoint scrollingPoint, endPoint;
@property (nonatomic, strong) NSTimer *scrollingTimer;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray* categoriesButtons;

#pragma mark - Properties of products for subCategories -

@property (strong, nonatomic) NSMutableArray* mitres;

#pragma mark - AlertViews -
@property (strong, nonatomic) UIView* backgroundView;
@property (strong, nonatomic) UIView* alertView;

@end

@implementation SiSCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mitres = [NSMutableArray array];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tappedCell:)];
    doubleTap.numberOfTapsRequired = 1;
    doubleTap.delaysTouchesBegan = YES;
    [self.itemsTable addGestureRecognizer:doubleTap];
    
    self.imagesArray = [NSMutableArray array];
    self.imagesIDs = [NSMutableArray array];
    
    for (SiSProduct* obj in self.offerProducts) {

        [self.imagesArray addObject:[self resizingImage:obj.img]];
        [self.imagesIDs addObject:obj.idProduct];
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        NSArray* temp = [NSArray arrayWithArray:self.imagesArray];
        NSArray* temp2 = [NSArray arrayWithArray:self.imagesIDs];
        for (int i = 0; i < 100; i++) {
            [self.imagesArray addObjectsFromArray:temp];
            [self.imagesIDs addObjectsFromArray:temp2];
            //NSLog(@"%d", self.imagesArray.count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.itemsTable reloadData];
            });
        }
    });
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        self.mitres = [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:6 andName:@"Mitres"];
//
//    });
    
    [self scrollSlowly];

}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.hidesBarsOnSwipe = NO;
    self.navigationController.navigationBarHidden = YES;
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
 
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imagesArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SiSCollectionViewCell* cell = (SiSCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imgView.image = self.imagesArray[indexPath.row];
    cell.idProduct = self.imagesIDs[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage* img = self.imagesArray[indexPath.row];
    CGSize origin = CGSizeMake(img.size.width, img.size.height);
    
    return origin;
}

#pragma mark Private methods

- (UIImage*)resizingImage:(UIImage*)image {
    
    CGFloat scaleFactor = targetHeight / image.size.height;
    CGFloat targetWidth = image.size.width * scaleFactor;
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    UIImage* scaledImage = [SiSCategoriesViewController imageWithImage:image scaledToSize:targetSize];
    
    return scaledImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark Animation methods
// Анимации CollectionView
- (void)scrollSlowly {
    self.endPoint = CGPointMake(0, self.itemsTable.frame.size.width);
    self.scrollingPoint = CGPointMake(0, 0);
    self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(scrollSlowlyToPoint) userInfo:nil repeats:YES];
}

- (void)scrollSlowlyToPoint {
    
    self.itemsTable.contentOffset = self.scrollingPoint;
    if (CGPointEqualToPoint(self.scrollingPoint, self.endPoint)) {
        [self.scrollingTimer invalidate];
    }
    self.scrollingPoint = CGPointMake(self.scrollingPoint.x + 0.3, 0);
}

// Обработка нажатия выбора картинки в CollectionView
- (IBAction)tappedCell:(id)sender {
    
    CGPoint tappedPoint = [sender locationInView:self.itemsTable];
    NSIndexPath *tappedCellPath = [self.itemsTable indexPathForItemAtPoint:tappedPoint];
    
    if (tappedCellPath) {
        
        SiSCollectionViewCell* cell = (SiSCollectionViewCell*)[self.itemsTable cellForItemAtIndexPath:tappedCellPath];
        [self.itemsTable selectItemAtIndexPath:tappedCellPath
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionNone];
        
        NSLog(@"the cell tag is %@", cell.idProduct);
        
    }
}


// Обработка нажатия кнопки выбора раздела
- (IBAction)openCategory:(UIButton*)sender {
        
    if ([sender.currentTitle isEqual: @"Иконы"]) {
        
        NSLog(@"иконы");
        
    } else if ([sender.currentTitle isEqualToString:@"Митры"]) {
        
        if (self.mitres.count > 0) {
            
            [self downloadAndPushNextView:self.mitres title:@"Митры" category: @6];
            
        } else {
            
            [self alertForWhile];
            
            //[self loadEventsForTable];
            
            [self getMitres];
            
            //self.mitres = [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:6 andName:@"Mitres"];
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self dissmissAlertForWhile];
//
//            });
        
            
 
//            [self getMitresAndGocompletion:^(BOOL finished) {
//
//                if (finished) {
//                    [self downloadAndPushNextView:self.mitres title:@"Митры" category: @6];
//                }
//                
//                
//            }];
        }
    
        NSLog(@"митры");
        
    } else if ([sender.currentTitle isEqualToString:@"Облачения"]) {
        
        NSLog(@"Облачения");
        
    } else if ([sender.currentTitle isEqualToString:@"Храмовое убранство"]) {
        
        NSLog(@"Храмовое убранство");
        
    } else if ([sender.currentTitle isEqualToString:@"Геральдика"]) {
        
        NSLog(@"Геральдика");
        
    } else if ([sender.currentTitle isEqualToString:@"Металлонить"]) {
        
        NSLog(@"Металлонить");
        
    } else if ([sender.currentTitle isEqualToString:@"Церковные ткани"]) {
        
        NSLog(@"Церковные ткани");
        
    } else if ([sender.currentTitle isEqualToString:@"Разное"]) {
        
        NSLog(@"Разное");
        
    }
}

- (void) dealloc {
    
}

//  Открытик вью с выбранным разделом
- (void) downloadAndPushNextView: (NSMutableArray*) tempArray title: (NSString*) title category: (NSNumber*) ID {
    
    [self.backgroundView removeFromSuperview];
    [self.alertView removeFromSuperview];
    [self dissmissAlertForWhile];
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SiSOneCategoryViewController* vc = [sb instantiateViewControllerWithIdentifier:@"SiSOneCategoryViewController"];
    vc.productsArray = tempArray;
    vc.selfTitle = title;
    vc.categoryID = ID;
    [self.navigationController pushViewController:vc animated:YES];
}

// Вызов алерта "Ждите..."
- (void) alertForWhile {
    
    self.alertView = [UIView new];
    self.alertView.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 125.f, self.view.frame.size.height + 125.f, 250.f, 150.f);
    self.alertView.backgroundColor = [UIColor colorWithRed:84/255.f green:0.f blue:1/255.f alpha:1];
    self.alertView.layer.cornerRadius = 20.f;
    self.alertView.layer.borderWidth = 1.0;
    self.alertView.layer.borderColor = [UIColor colorWithRed:255/255.f green:219/255.f blue:148/255.f alpha:1].CGColor;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100.f, self.view.frame.size.height + 100.f, 250.f, 150.f)];
    label.center = CGPointMake(self.alertView.frame.size.width/2, self.alertView.frame.size.height);
    label.text = @"Ждите...";
    
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName: @"Trebuchet MS" size: 54.0f]];
    [self.alertView addSubview:label];
    
    
    self.backgroundView = [UIView new];
    self.backgroundView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.f;
    
    [UIView animateWithDuration:0.7 animations:^{
        self.backgroundView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-(CGRectGetWidth(self.backgroundView.bounds)/2), CGRectGetMidY(self.backgroundView.frame));
        self.backgroundView.alpha = 0.7f;
        
        self.alertView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    }];
    
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.alertView];
}

// Закрытие алерта "Ждите..."
- (void) dissmissAlertForWhile {
    
    [UIView animateWithDuration:1 animations:^{
        self.backgroundView.center = CGPointMake(CGRectGetWidth(self.view.bounds)-(CGRectGetWidth(self.backgroundView.bounds)/2), self.view.frame.size.height + self.backgroundView.bounds.size.height);
        
        self.alertView.center = CGPointMake(CGRectGetMidX(self.view.frame), 0 - CGRectGetMidY(self.view.frame));
        
    }];
}


- (void)getMitresAndGocompletion:(void (^)(BOOL finished))completionBlock {
    
    self.mitres = [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:6 andName:@"Mitres"];
    
    completionBlock(YES);
}

// PRESENTER
- (void)loadEventsForTable {
    
    [self getEvents:^(NSArray* products,  BOOL fromServer) {
        
        // if the data is't fresh, let's show to the user an alert about it
        
        // don't forget turn off refresher
        if (!fromServer) {
            
            NSLog(@"нет!");
        }
        
        if (fromServer) {
            [self downloadAndPushNextView:self.mitres title:@"Митры" category: @6];
        }
        
    }];
}


// ITERATOR
- (void)getEvents:(void(^)(NSArray* products, BOOL fromServer))eventsData {
    
    // make request on server
    [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:6
                                                                  andName:@"Mitres"
                                                                onSuccess:^(NSArray *productsArray) {
                                                                    
                                                                    [self.mitres addObjectsFromArray:productsArray];
                                                                    NSLog(@"sdfjhkhkjhdsfsfjhdfjhfdhjg");
                                                                    
                                                                } onFailure:^(NSError *error) {
                                                                    
                                                                }];
}

- (void) getMitres {
    
    [[SiSPersistentManager sharedManager] getCategoriesProductsOfCategory:6
                                                                  andName:@"Mitres"
                                                                onSuccess:^(NSArray *productsArray) {
                                                                    
                                                                    [self.mitres addObjectsFromArray:productsArray];
                                                                    NSLog(@"this line will show after fetching data!");
                                                                    
                                                                    [self downloadAndPushNextView:self.mitres title:@"Митры" category:@6];
                                                                    
                                                                } onFailure:^(NSError *error) {
                                                                    
                                                                }];
}









@end
