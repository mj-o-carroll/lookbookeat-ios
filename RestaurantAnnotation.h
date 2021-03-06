//
//  RestaurantAnnotation.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 28/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface RestaurantAnnotation : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c;

@end