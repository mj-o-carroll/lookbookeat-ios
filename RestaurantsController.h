//
//  RestaurantsController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 06/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantsController : NSObject

@property NSMutableArray * listOfRestaurants;

-(id)initWithArray:(NSMutableArray *)restaurants;

-(NSMutableArray*)availableCounties;
-(NSMutableArray*)availableFoodTypes;
-(NSMutableArray*)availablePrices;
-(NSMutableArray*)ratings;
-(NSMutableArray*)dietaryRequirements;
-(NSMutableArray*)addressList;
-(NSMutableArray*)nameList;


@end
