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
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidUnload
{
    
    
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
             
             //show on the map
            
             CLLocationCoordinate2D coordinate; coordinate.latitude = lat; coordinate.longitude = lng;
        
             point = [[MKPointAnnotation alloc] init];
             point.coordinate = coordinate;
             point.title = restaurantName;
             point.subtitle = restaurantAddress;
             
             [map addAnnotation:point];
            
             MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
             MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion]; [map setRegion:adjustedRegion animated:YES
                                                                                   ];
             [map selectAnnotation:point animated:YES];
            
             
             
         }}];
    
            }


- (void) viewDidAppear:(BOOL)animated
{
    //set up swipe gesture to previous view
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
}

//pop view from stack to return to previous view
- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
