//
//  RestaurantMapViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 28/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "Restaurant.h"

@interface RestaurantMapViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>
{
    IBOutlet MKMapView* map;
    CLLocationManager* manager;
    MKPointAnnotation *point;
}

@property (strong, nonatomic) NSMutableDictionary * selectedRestaurant;
@property (strong, nonatomic) NSString * restaurantName;
@property (strong, nonatomic) NSString * restaurantAddress;


-(void)geocode:(NSString*)address;
- (void)back;

@end
