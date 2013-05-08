//
//  SearchViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 05/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"
#import "ByCountyViewController.h"
#import "FoodTypeViewController.h"
#import "PriceViewController.h"
#import "DietaryRequirementsViewController.h"
#import "ByRatingViewController.h"
#import "SearchResultsViewController.h"




@interface SearchViewController : UITableViewController <ByCountyViewControllerDelegate, FoodTypeViewControllerDelegate, PriceViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *parameters;
@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (strong, nonatomic) NSString *county;
@property (strong, nonatomic) NSString *foodType;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *dietaryRequirement;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSPredicate *p1;
@property (strong, nonatomic) NSPredicate *p2;
@property (strong, nonatomic) NSPredicate *p3;
@property (strong, nonatomic) NSPredicate *p4;
@property (strong, nonatomic) NSPredicate *p5;
@property (strong, nonatomic) NSMutableArray *filteredResults;

@property (strong, nonatomic) NSMutableArray *searchBarResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSString *searchBarText;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)searchResults;
- (void)back;
-(IBAction)refreshParameters;

@end
