//
//  Restaurant.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/02/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

@synthesize name, address, phoneNo, email, description, location, picture, foodType, priceRange, rating, veganFriendly, vegFriendly, coeliacFriendly;

- (id)initWithContentsOfDictionary:(NSMutableDictionary*)newRestaurant
{
    name = [newRestaurant valueForKey:@"name"];
    address = [newRestaurant valueForKey:@"address"];
    phoneNo = [newRestaurant valueForKey:@"phone_no"];
    email = [newRestaurant valueForKey:@"email"];
    picture = [newRestaurant valueForKey:@"picture"];
    description = [newRestaurant valueForKey:@"description"];
    location = [newRestaurant valueForKey:@"location"];
    rating = [newRestaurant valueForKey:@"rating"];
    foodType = [newRestaurant valueForKey:@"food_type"];
    priceRange = [newRestaurant valueForKey:@"price_range"];
    
    return self;
}

@end
