//
//  SiSFirstViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 08.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSFirstViewController.h"
#import "M13ProgressViewSegmentedBar.h"
#import "SiSPersistentManager.h"
#import "SiSCategoriesViewController.h"
#import "SiSTabBarControllerViewController.h"


@interface SiSFirstViewController () <UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet M13ProgressViewSegmentedBar* progressView;
@property (strong, nonatomic) NSMutableArray* tempArray;

@end

@implementation SiSFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    // Configure the progress view here.
    self.progressView.progressDirection = M13ProgressViewSegmentedBarProgressDirectionLeftToRight;
    self.progressView.segmentShape = M13ProgressViewSegmentedBarSegmentShapeCircle;
    self.progressView.numberOfSegments = 7;
    self.progressView.primaryColor = [UIColor colorWithRed:54/255.0 green:6/255.0 blue:6/255.0 alpha:1];
    self.progressView.secondaryColor = [UIColor colorWithRed:255/255.0 green:219/255.0 blue:148/255.0 alpha:0.5f];
    self.progressView.indeterminate = YES;
    
    
    // Update the progress as needed
    [self.progressView setProgress: 0.1 animated: YES];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    // Проверка подключения интернет и переход к следующему вью
    if (![self connectedToInternet]) {
        
        [self showAlertWhenNoInternet];
        
    } else {
        
        [self downloadAndPushNextView];
        
//        void (^getOfferProducts) () = ^ {
//            
//            self.tempArray = [[SiSPersistentManager sharedManager] getOfferProducts];
//            
//            if (self.tempArray.count > 0) {
//                
//                NSLog(@"Здесь открываем новый контроллер!");
//                UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                SiSTabBarControllerViewController* vc = [sb instantiateViewControllerWithIdentifier:@"SiSTabBarControllerViewController"];
//                SiSCategoriesViewController* vc2 = [vc.viewControllers objectAtIndex:0];
//                vc2.offerProducts = self.tempArray;
//                [self.navigationController presentViewController:vc
//                                                        animated:YES
//                                                      completion:nil];
//            }
//
//        };
//        
//        getOfferProducts();
        
    }
}

// Проверка интернет соединения
- (BOOL) connectedToInternet {
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.ya.ru"]
                                                   encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@", URLString ? @"YES internet connection": @"NO internet connection");
    
    return (URLString != nil) ? YES : NO;
}

// Вывод алерта, когда нет интернет соединения
- (void) showAlertWhenNoInternet {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"У Вас отсутствует интернет-содинение!"
                                message:@"Вы не можете пользоваться приложением без интернет! Вам следует хотя бы раз запустить приложение при подключенном интернет!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* nopeAction = [UIAlertAction actionWithTitle:@"ОК"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                           [self dismissViewControllerAnimated:YES completion:nil];
                                                           
                                                       }];
    
    [alert addAction:nopeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//  Метод перехода на новый вью контроллер с offerProducts
- (void) downloadAndPushNextView {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.tempArray = [[SiSPersistentManager sharedManager] getOfferProducts];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.tempArray.count > 0) {
                
                NSLog(@"Здесь открываем новый контроллер!");
                UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SiSTabBarControllerViewController* vc = [sb instantiateViewControllerWithIdentifier:@"SiSTabBarControllerViewController"];
                SiSCategoriesViewController* vc2 = [vc.viewControllers objectAtIndex:0];
                vc2.offerProducts = self.tempArray;
                [self.navigationController presentViewController:vc
                                                        animated:YES
                                                      completion:nil];
            }
        });
    });
}


@end
