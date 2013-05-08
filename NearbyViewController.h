//
//  NearbyViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RestaurantsController.h"

@interface NearbyViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>
{
    IBOutlet MKMapView* map;
//    IBOutlet UILabel* locationLabel;
//    IBOutlet UILabel* addressLabel;
    CLLocationManager* manager;
    
}

@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (strong, nonatomic) MKMapView * mapView;

-(void)geocodeRestaurant:(NSString*)address;
-(void)setUpRestaurantPins;
-(void)back;


@end
