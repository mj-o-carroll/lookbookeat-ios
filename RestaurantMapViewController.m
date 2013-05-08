//
//  RestaurantMapViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 28/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "RestaurantMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "RestaurantAnnotation.h"



@implementation RestaurantMapViewController

@synthesize selectedRestaurant, restaurantName, restaurantAddress;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    restaurantName = [selectedRestaurant valueForKey:@"name"];
    restaurantAddress = [selectedRestaurant valueForKey:@"address"];
    [self geocode: (@"%@, %@", restaurantName, restaurantAddress)];
    //map.delegate = self;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidUnload
{
    //[manager stopUpdatingLocation];
    
}

-(void)geocode:(NSString*)address
{
    CLGeocoder*gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:address completionHandler:
     ^(NSArray *placemarks, NSError *error)
     {
         if ([placemarks count]>0)
         {
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
             point = [[MKPointAnnotation alloc] init];
             point.coordinate = coordinate;
             point.title = restaurantName;
             point.subtitle = restaurantAddress;
             
             [map addAnnotation:point];
            
             
             
             //[map addAnnotation:[[RestaurantAnnotation alloc] initWithCoordinate:coordinate]];
             //3
             MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
             MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion]; [map setRegion:adjustedRegion animated:YES
                                                                                   ];
             [map selectAnnotation:point animated:YES];
            
             
             
         }}];
    
            }


@end
