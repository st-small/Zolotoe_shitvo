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

#define targetHeight 170

@interface SiSCategoriesViewController ()

@property (strong, nonatomic) NSMutableArray* imagesArray;
@property (weak, nonatomic) IBOutlet UICollectionView *itemsTable;

@end

@implementation SiSCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesArray = [NSMutableArray array];
    
    for (SiSProduct* obj in self.offerProducts) {
        
        UIImage* img = [self resizingImage:obj.img];
        [self.imagesArray addObject:img];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        NSArray* temp = [NSArray arrayWithArray:self.imagesArray];
        for (int i = 0; i < 100; i++) {
            [self.imagesArray addObjectsFromArray:temp];
            NSLog(@"%d", self.imagesArray.count);
        }
    });
    
    [self.itemsTable reloadData];

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

//- (void)scrollSlowly {
//    self.endPoint = CGPointMake(3000, 0);
//    self.scrollingPoint = CGPointMake(0, 0);
//    self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scrollSlowlyToPoint) userInfo:nil repeats:YES];
//}
//
//- (void)scrollSlowlyToPoint {
//    
//    self.itemsTable.contentOffset = self.scrollingPoint;
//    if (CGPointEqualToPoint(self.scrollingPoint, self.endPoint)) {
//        [self.scrollingTimer invalidate];
//    }
//    self.scrollingPoint = CGPointMake(self.scrollingPoint.x + 0.5, self.scrollingPoint.y);
//}


@end
