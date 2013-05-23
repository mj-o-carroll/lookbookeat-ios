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
#import "MapPin.h"

@interface NearbyViewController()
-(void)revGeocode:(CLLocation*)c;
-(void)geocode:(NSString*)address;
@end

@implementation NearbyViewController

@synthesize restaurantsController, mapView, map, selectedRestaurant;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"the comment at this index is: %@", [restaurantsController listOfRestaurants]);

    //mapView.delegate = self;
    map.delegate = self;
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


-(void)geocodeRestaurant:(NSString *)address :(NSString *)name
{
    map.showsUserLocation = YES;
    CLGeocoder*gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:address completionHandler:
     ^(NSArray *placemarks, NSError *error)
     {
         if ([placemarks count]>0)
         {
             CLPlacemark*mark = (CLPlacemark*) [placemarks objectAtIndex:0];
             double lat = mark.location.coordinate.latitude;
             double lng = mark.location.coordinate.longitude;
             CLLocationCoordinate2D coordinate;
             coordinate.latitude = lat;
             coordinate.longitude = lng;
             MapPin *pin = [[MapPin alloc] initWithCoordinates:coordinate placeName:name description:address];
             [map viewForAnnotation:pin];
             [map addAnnotation:pin];
             MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 100000, 100000);
             MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion]; [map setRegion:adjustedRegion animated:YES];
         }}];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    } else {
        annotationView.annotation = annotation;
        [(UIImageView *)annotationView.leftCalloutAccessoryView setImage:nil];
    }
    
    return annotationView;
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control

{
    MapPin *temp = (MapPin*)view.annotation;
    NSLog(@"Name: %@", temp.title);
    
    for(int i=0; i<[[restaurantsController listOfRestaurants] count]; i++)
    {
        if([[[restaurantsController listOfRestaurants] valueForKey:@"name"] objectAtIndex:i] == temp.title)
     selectedRestaurant = [NSDictionary dictionaryWithDictionary:[[restaurantsController listOfRestaurants] objectAtIndex:i]];
    }

    [self performSegueWithIdentifier:@"ToRestaurant" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //remove default text from back button
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action: nil];
    
    if([segue.identifier isEqualToString:@"ToRestaurant"])
    {
        
        
        ProfileViewController * profileViewController = [segue destinationViewController];
        profileViewController.selectedRestaurant = selectedRestaurant;
		
    }
    
}


@end
