//
//  SearchResultsViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 25/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"

@interface SearchResultsViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray * filteredResults;
@property (strong,nonatomic) NSMutableDictionary* selectedRestaurant;



-(void)back;

@end
