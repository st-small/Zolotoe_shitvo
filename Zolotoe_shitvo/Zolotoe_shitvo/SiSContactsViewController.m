//
//  SiSContactsViewController.m
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 30.01.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSContactsViewController.h"
#import <MapKit/MapKit.h>

@interface SiSContactsViewController ()
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
