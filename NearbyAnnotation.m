//
//  NearbyAnnotation.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "NearbyAnnotation.h"

@implementation NearbyAnnotation

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
