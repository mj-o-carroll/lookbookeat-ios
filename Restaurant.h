//
//  Restaurant.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/02/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject{
    NSString *name;
    NSString *address;
    NSString *phoneNo;
    NSString *picture;
    NSString *description;
    NSString *location;
    NSString *foodType;
    NSString *priceRange;
    NSString *vegFriendly;
    NSString *veganFriendly;
    NSString *coeliacFriendly;
    NSString *rating;
    
}

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *phoneNo;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *foodType;
@property (strong, nonatomic) NSString *priceRange;
@property (strong, nonatomic) NSString *vegFriendly;
@property (strong, nonatomic) NSString *veganFriendly;
@property (strong, nonatomic) NSString *coeliacFriendly;
@property (strong, nonatomic) NSString *rating;

- (id)initWithContentsOfDictionary:(NSMutableDictionary*)newRestaurant;

@end
