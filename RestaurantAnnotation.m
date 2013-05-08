//
//  RestaurantAnnotation.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 28/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "RestaurantAnnotation.h"

@implementation RestaurantAnnotation

@synthesize coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c
{
    if (self = [super init])
    {
        coordinate = c;
    }
    return self;
}

@end

