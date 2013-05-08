//
//  RestaurantsController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 06/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "RestaurantsController.h"

@implementation RestaurantsController

@synthesize listOfRestaurants;

-(id)initWithArray:(NSMutableArray *)restaurants
{
    self = [super init];
    if (self) {
        self.listOfRestaurants = restaurants;
        
    }
    return self;
}


-(NSMutableArray*)availableCounties{
    
    NSSet* uniqueCounties = [NSSet setWithArray:[listOfRestaurants valueForKey:@"location"]];
    NSLog(@"%@", [uniqueCounties description]);
    NSMutableArray *availableCounties = [NSMutableArray arrayWithArray:[uniqueCounties allObjects]];
    return availableCounties;
};

-(NSMutableArray*)availableFoodTypes{
    
    NSSet *uniqueFoodTypes = [NSSet setWithArray:[listOfRestaurants valueForKey:@"food_type"]];
    NSLog(@"%@", [uniqueFoodTypes description]);
    NSMutableArray *availableFoodTypes = [NSMutableArray arrayWithArray:[uniqueFoodTypes allObjects]];
    return availableFoodTypes;
    
};

-(NSMutableArray*)availablePrices{
    
    NSSet *uniquePrices = [NSSet setWithArray:[listOfRestaurants valueForKey:@"price_range"]];
    NSLog(@"%@", [uniquePrices description]);
    NSMutableArray *availablePrices = [NSMutableArray arrayWithArray:[uniquePrices allObjects]];
    
    return availablePrices;
    
};

-(NSMutableArray*)ratings{

    //NSSet * uniqueRatings = [NSSet setWithArray:[self valueForKey:@"rating"]];
    NSMutableArray * availableRatings = [[NSMutableArray alloc] initWithObjects:@"5 Star", @"4 Star", @"3 Star", @"2 Star", @"1 Star", nil];;
    return availableRatings;
};

-(NSMutableArray*)dietaryRequirements{
    
    NSMutableArray * specRequirements = [[NSMutableArray alloc] initWithObjects:@"Vegetarian Friendly", @"Vegan Friendly", @"Coeliac Friendly", nil];
    return specRequirements;
    
};

-(NSMutableArray*)addressList
{
    NSMutableArray * addresses = [[NSMutableArray alloc]init];
    for (int i = 0; i<[listOfRestaurants count]; i++)
    {
        [addresses addObject:[[listOfRestaurants objectAtIndex:i]valueForKey:@"address"]];
    }
    return addresses;
    
};

-(NSMutableArray*)nameList
{
    NSMutableArray * names = [[NSMutableArray alloc]init];
    for (int i = 0; i<[listOfRestaurants count]; i++)
    {
        [names addObject:[[listOfRestaurants objectAtIndex:i]valueForKey:@"name"]];
    }

    return names;
    
};


@end
