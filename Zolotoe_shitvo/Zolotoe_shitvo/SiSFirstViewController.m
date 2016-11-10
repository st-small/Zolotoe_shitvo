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


@interface SiSFirstViewController ()

@property (weak, nonatomic) IBOutlet M13ProgressViewSegmentedBar* progressView;

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
    
    NSMutableArray* tmp = [[SiSPersistentManager sharedManager] getOfferProducts];
    
    // Проверка подключения интернет
    if (![self connectedToInternet]) {
        
        [self showAlertWhenNoInternet];
        
    } else {
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (tmp.count > 0) {
                
                NSLog(@"Здесь открываем новый контроллер!");
                
                UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SiSCategoriesViewController* vc = [sb instantiateViewControllerWithIdentifier:@"SiSCategoriesViewController"];
                vc.offerProducts = tmp;
                [self.navigationController presentViewController:vc
                                                        animated:YES
                                                      completion:nil];
            }
        });
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




@end
