//
//  NearbyViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "NearbyViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "NearbyAnnotation.h"
#import "ProfileViewController.h"

@interface NearbyViewController()
-(void)revGeocode:(CLLocation*)c;
-(void)geocode:(NSString*)address;
@end

@implementation NearbyViewController

@synthesize restaurantsController, mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    //set custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    //start updating the location
    manager = [[CLLocationManager alloc] init]; manager.delegate = self;
    [manager startUpdatingLocation];
    [self setUpRestaurantPins];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpRestaurantPins
{
    for (int i=0; i<[[restaurantsController addressList] count]; i++ )
    {
        NSString * address = [[restaurantsController addressList]objectAtIndex:i];
        NSString * name = [[restaurantsController nameList]objectAtIndex:i];
        [self geocodeRestaurant:address :name];
    }
}

-(void)viewDidUnload
{
    [manager stopUpdatingLocation];
}

//- (void)locationManager:
//(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    if (newLocation.coordinate.latitude !=
//        oldLocation.coordinate.latitude) {
//        [self revGeocode: newLocation]; }
//}
//
//-(void)revGeocode:(CLLocation*)c
//{
//    addressLabel.text = @"reverse geocoding coordinate ...";
//    CLGeocoder* gcrev = [[CLGeocoder alloc] init];
//    [gcrev reverseGeocodeLocation:c completionHandler:^(NSArray *placemarks, NSError *error){CLPlacemark* revMark = [placemarks objectAtIndex:0];
//        //turn placemark to address text
//        NSArray* addressLines =
//        [revMark.addressDictionary objectForKey:@"FormattedAddressLines"];
//        NSString* revAddress =
//        [addressLines componentsJoinedByString: @"\n"];
//        addressLabel.text = [NSString stringWithFormat: @"Reverse geocoded address: \n%@", revAddress];
//        //now turn the address to coordinates
//        [self geocode: revAddress];
//    }];
//}
//
//-(void)geocode:(NSString*)address
//{
//    //1
//    locationLabel.text = @"geocoding address...";
//    CLGeocoder*gc = [[CLGeocoder alloc] init];
//    //2
//    [gc geocodeAddressString:address completionHandler:
//     ^(NSArray *placemarks, NSError *error)
//     {
//         //3
//         if ([placemarks count]>0)
//         {
//             //4
//             CLPlacemark*mark = (CLPlacemark*) [placemarks objectAtIndex:0];
//             double lat = mark.location.coordinate.latitude;
//             double lng = mark.location.coordinate.longitude;
//             //5 show the coords text
//             locationLabel.text = [NSString stringWithFormat:@"Coordinate\nlat: %@, long: %@",
//                                   [NSNumber numberWithDouble: lat],[NSNumber numberWithDouble: lng]];
//             //show on the map
//             //1
//             CLLocationCoordinate2D coordinate; coordinate.latitude = lat; coordinate.longitude = lng;
//             //2
//             [map addAnnotation:[[NearbyAnnotation alloc] initWithCoordinate:coordinate]];
//             //3
//             MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 100000, 100000);
//             MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion]; [map setRegion:adjustedRegion animated:YES];
//         }}];
//}

-(void)geocodeRestaurant:(NSString *)address :(NSString *)name
{
    map.showsUserLocation = YES;
    //1
    //locationLabel.text = @"geocoding address...";
    CLGeocoder*gc = [[CLGeocoder alloc] init];
    //2
    [gc geocodeAddressString:address completionHandler:
     ^(NSArray *placemarks, NSError *error)
     {
         //3
         if ([placemarks count]>0)
         {
             //4
             CLPlacemark*mark = (CLPlacemark*) [placemarks objectAtIndex:0];
             double lat = mark.location.coordinate.latitude;
             double lng = mark.location.coordinate.longitude;
             //5 show the coords text
             //locationLabel.text = [NSString stringWithFormat:@"Coordinate\nlat: %@, long: %@",
                                   //[NSNumber numberWithDouble: lat],[NSNumber numberWithDouble: lng]];
             //show on the map
             //1
             CLLocationCoordinate2D coordinate; coordinate.latitude = lat; coordinate.longitude = lng;
             //2
             MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
             NSString * pinName = name;
             NSLog(@"PinName: %@", pinName);
             NSLog(@"Name: %@", name);
             NSString * pinAddress = address;
             point.coordinate = coordinate;
             point.title = pinName;
             point.subtitle = pinAddress;
             
             [map addAnnotation:point];
             
             //[map addAnnotation:[[NearbyAnnotation alloc] initWithCoordinate:coordinate]];
             //3
             MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 100000, 100000);
             MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion]; [map setRegion:adjustedRegion animated:YES];
         }}];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"String"];
    if(!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"String"];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    return annotationView;
}


//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
//
//{
//    // Go to edit view
//    [self performSegueWithIdentifier:@"ToProfile" sender:self];
//}
//
//- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"ToProfile"])
//    {
//        
//        ProfileViewController * profileViewController = [segue destinationViewController];
//        profileViewController.selectedRestaurant = selectedRestaurant;
//		
//    }
//}

@end
