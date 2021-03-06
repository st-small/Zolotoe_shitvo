//
//  SiSContactsViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 30.01.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSContactsViewController.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>

@interface SiSContactsViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation SiSContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(48.505408, 32.270358);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 3000, 3000)];
    [self.map setRegion:adjustedRegion animated:YES];
    
    //Create the pin with the default alloc and init methods.
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    //Set the cordinate with the handy CLLocationCoordinate2DMake: method.
    annotation.coordinate = startCoord;
    
    //Set the title of the pin, this will show above the subtitle in a larger font.
    annotation.title = @"Золотое шитье";
    
    //Set the subtitle of the pin, this will show under the title in a smaller font.
    annotation.subtitle = @"Выставочный зал";
    
    //Now that the pin has been created and configured, add it to the map view so it is visible.
    [self.map addAnnotation:annotation];
}

- (IBAction)makeCall:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://+380505254567"]];
    
    NSLog(@"calling...");
}

#pragma mark - sending mail

- (IBAction)sendLetter:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Прошу связаться со мной для уточнения заказа"];
        [mail setMessageBody:@"Здесь Вы можете указать контактные данные для связи.\n\n\nПисьмо отправлено из приложения \"Золотое шитье\" ver.1.1" isHTML:NO];
        [mail setToRecipients:@[@"info@zolotoe-shitvo.kr.ua"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
        
    } else {
        
        NSLog(@"This device cannot send email");
    }
    
    NSLog(@"letter...");
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)makeSkypeCall:(id)sender {
    
    // viber calling
//    NSString *phoneNumber = @"+380501677352";
//    NSString * const viberScheme = @"viber://";
//    NSString * const tel = @"tel";
//    NSString * const chat = @"chat";
//    NSString *action = @"tel"; // this could be @"chat" or @"tel" depending on the choice of the user
//    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:viberScheme]]) {
//        
//        // viber is installed
//        NSString *myString;
//        if ([action isEqualToString:tel]) {
//            myString = [NSString stringWithFormat:@"%@:%@", tel, phoneNumber];
//        } else if ([action isEqualToString:chat]) {
//            myString = [NSString stringWithFormat:@"%@:%@", chat, phoneNumber];
//        }
//        
//        NSURL *myUrl = [NSURL URLWithString:[viberScheme stringByAppendingString:myString]];
//        
//        if ([[UIApplication sharedApplication] canOpenURL:myUrl]) {
//            [[UIApplication sharedApplication] openURL:myUrl];
//        } else {
//            // wrong parameters
//        }
//        
//    } else {
//        // viber is not installed
//    }
    
    //skype calling
    
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
    
    if(installed) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"skype:gayane2401?call"]];
        
    } else {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/skype-for-iphone/id304878510?mt=8"]];
    }
    
    NSLog(@"skype...");
}

- (IBAction)openMap:(id)sender {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(48.505408, 32.270358);
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coord];
    
    // Create a map item for the geocoded address to pass to Maps app
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:@"Золотое шитье"];
    
    // Set the directions mode to "Driving"
    // Can use MKLaunchOptionsDirectionsModeWalking instead
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    
    // Get the "Current User Location" MKMapItem
    MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
    
    // Pass the current location and destination map items to the Maps app
    // Set the direction mode in the launchOptions dictionary
    [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
    
    NSLog(@"the map will opening...");
}

@end
