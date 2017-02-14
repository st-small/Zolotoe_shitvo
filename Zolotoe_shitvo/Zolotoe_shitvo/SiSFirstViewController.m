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
    
    self.tempArray = [NSMutableArray array];
    
    // Проверка подключения интернет и переход к следующему вью
    if (![self connectedToInternet]) {
        
        [self showAlertWhenNoInternet];
        
    } else {
        
        self.tempArray = [[SiSPersistentManager sharedManager] getOfferProducts];
        
        if (self.tempArray.count > 0) {
            
            [self downloadAndPushNextView];
            
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadAndPushNextView)
                                                     name:@"offerProductsReady"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showAlertWhenSiteIsNotAvaliableError)
                                                     name:@"error"
                                                   object:nil];
        
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

// Вывод алерта, когда от сайта возвращается ошибка (404, 502 и пр.)
- (void) showAlertWhenSiteIsNotAvaliableError {
    
    //NSString* title = [NSString stringWithFormat:@"Ошибка! %@", errorLocalizedDescription];
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Ошибка!"
                                message:@"Источник инфорации временно недоступен! Воспользуйтесь приложением немного позже!"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* nopeAction = [UIAlertAction actionWithTitle:@"ОК"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           exit(0);
                                                           
                                                       }];
    
    [alert addAction:nopeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//  Метод перехода на новый вью контроллер с offerProducts
- (void) downloadAndPushNextView {
        
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SiSTabBarControllerViewController* vc1 = [sb instantiateViewControllerWithIdentifier:@"SiSTabBarControllerViewController"];
    UINavigationController* nav = [vc1.viewControllers objectAtIndex:0];
    SiSCategoriesViewController* vc = [[nav childViewControllers] firstObject];
    vc.offerProducts = self.tempArray;
    [self.navigationController presentViewController:vc1
                                                 animated:YES
                                               completion:nil];
}

- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"offerProductsReady"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"error"];
}


@end
