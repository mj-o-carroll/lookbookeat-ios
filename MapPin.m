//
//  MapPin.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 17/05/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:placeName description:description {
    self = [super init];
    if (self != nil) {
        coordinate = location;
        title = placeName;
        
        subtitle = description;
        
        
    }
    return self;
}

@end
