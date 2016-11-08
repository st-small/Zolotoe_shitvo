//
//  SiSFirstViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 08.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSFirstViewController.h"
#import "M13ProgressViewSegmentedBar.h"


@interface SiSFirstViewController ()

@property (weak, nonatomic) IBOutlet M13ProgressViewSegmentedBar* progressView;

@end

@implementation SiSFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure the progress view here.
    self.progressView.progressDirection = M13ProgressViewSegmentedBarProgressDirectionLeftToRight;
    self.progressView.segmentShape = M13ProgressViewSegmentedBarSegmentShapeCircle;
    self.progressView.numberOfSegments = 7;
    self.progressView.primaryColor = [UIColor colorWithRed:54/255.0 green:6/255.0 blue:6/255.0 alpha:1];
    self.progressView.secondaryColor = [UIColor colorWithRed:255/255.0 green:219/255.0 blue:148/255.0 alpha:0.5f];
    self.progressView.indeterminate = YES;
    
    
    // Update the progress as needed
    [self.progressView setProgress: 0.1 animated: YES];
    
    
    if (![self connectedToInternet]) {
        
        [self showAlertWhenNoInternet];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    }

//Проверка интернет соединения
- (BOOL) connectedToInternet {
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.ya.ru"]
                                                   encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@", URLString ? @"YES internet connection": @"NO internet connection");
    
    return (URLString != nil) ? YES : NO;
}

//Вывод алерта, когда нет интернет соединения
- (void) showAlertWhenNoInternet {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"У Вас отсутствует интернет-содинение!"
                                message:@"Вы не можете пользоваться приложением без интернет! Вам следует хотя бы раз запустить приложение при подключенном интернет!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* nopeAction = [UIAlertAction actionWithTitle:@"ОК"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                       }];
    
    [alert addAction:nopeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}




@end
