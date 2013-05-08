//
//  SearchViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 05/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize parameters, restaurantsController, county, foodType, price, dietaryRequirement, rating, p1, p2, p3, p4, p5, filteredResults, searchBar, searchBarText, searchBarResults, tableView;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // tap recognition for first responder
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(tableClicked)];
    //[tableView addGestureRecognizer:tapgesture];
    
    
    // set background image
    UIImage *patternImage = [UIImage imageNamed:@"light_toast.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    //set custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    [self.navigationController setToolbarHidden:NO];

    NSLog(@"SearchController has the data!");
    NSLog(@"%@", [restaurantsController.listOfRestaurants objectAtIndex:0]);
    parameters = [NSMutableArray arrayWithObjects:
             @"By county", @"Food type", @"Price", @"By rating", @"Dietary requirements", @"See all", nil];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//  removes view controller once screen is tapped outside keyboard
-(void)tableClicked
{
    [searchBar resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self searchBar].delegate=self;
    [self searchBar].text=@"";
    [self.tableView reloadData];
    [self.navigationController setToolbarHidden:NO];
    
}

-(IBAction)refreshParameters
{
    parameters = [NSMutableArray arrayWithObjects:
                  @"By county", @"Food type", @"Price", @"By rating", @"Dietary requirements", @"See all", nil];
    [self.tableView reloadData];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchBar].text=@"";
    [self.tableView reloadData];
    [self resignFirstResponder];
    [self.view endEditing:YES];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSPredicate* searchBarPred;
    searchBarText = searchBar.text;
    NSString*wildcardText = [[NSString alloc] initWithFormat:@"*%@*",searchBarText];
    NSLog(@"%@",searchBarText);
    [self resignFirstResponder];
    
    if ([searchBarText isEqualToString:@""])
    {
        searchBarPred = [NSPredicate predicateWithValue:YES];
    }
    else
    {
        searchBarPred = [NSPredicate predicateWithFormat:@"SELF.name like[cd] %@", wildcardText];
    }
    searchBarResults = [restaurantsController.listOfRestaurants filteredArrayUsingPredicate:searchBarPred];
    [self performSegueWithIdentifier:@"SearchBarResults" sender:self];
    //[self searchBar].text=@"";
    [self.tableView resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)searchResults
{
    NSMutableArray *compoundPredicateArray;
    
    // by county
    if ([[parameters objectAtIndex:0] isEqualToString:@"By county"])
            {
        p1 = [NSPredicate predicateWithValue:YES];
    }
    else
    {
        p1 = [NSPredicate predicateWithFormat:@"SELF.location = %@", [parameters objectAtIndex:0]];
        [compoundPredicateArray addObject: p1];
    }
    
    // by food type
    if ([[parameters objectAtIndex:1] isEqualToString:@"Food type"])
    {
        p2 = [NSPredicate predicateWithValue:YES];
    }
        else
        {
            p2 = [NSPredicate predicateWithFormat:@"SELF.food_type = %@", [parameters objectAtIndex:1]];
            [compoundPredicateArray addObject: p2];
        }
    
    // by price
    if ([[parameters objectAtIndex:2] isEqualToString:@"Price"])
    {
        p3 = [NSPredicate predicateWithValue:YES];
    }
    else
    {
        p3 = [NSPredicate predicateWithFormat:@"SELF.price_range = %@", [parameters objectAtIndex:2]];
        [compoundPredicateArray addObject: p3];
    }
    
    // by rating
    if ([[parameters objectAtIndex:3] isEqualToString:@"By rating"])
    {
        p4 = [NSPredicate predicateWithValue:YES];
    }
    else
    {
        if([[parameters objectAtIndex:3] isEqualToString:@"5 Star"])
        {
            p4 = [NSPredicate predicateWithFormat:@"SELF.rating = 5"];
            [compoundPredicateArray addObject: p4];
        }
        else if([[parameters objectAtIndex:3] isEqualToString:@"4 Star"])
        {
            p4 = [NSPredicate predicateWithFormat:@"SELF.rating = 4"];
            [compoundPredicateArray addObject: p4];
        }
        else if([[parameters objectAtIndex:3] isEqualToString:@"3 Star"])
        {
            p4 = [NSPredicate predicateWithFormat:@"SELF.rating = 3"];
            [compoundPredicateArray addObject: p4];
        }
        else if([[parameters objectAtIndex:3] isEqualToString:@"2 Star"])
        {
            p4 = [NSPredicate predicateWithFormat:@"SELF.rating = 2"];
            [compoundPredicateArray addObject: p4];
        }
        else if([[parameters objectAtIndex:3] isEqualToString:@"1 Star"])
        {
            p4 = [NSPredicate predicateWithFormat:@"SELF.rating = 1"];
            [compoundPredicateArray addObject: p4];
        }
    }
    
    // by dietary requirements
    if ([[parameters objectAtIndex:4] isEqualToString:@"Dietary requirements"])
    {
        p5 = [NSPredicate predicateWithValue:YES];
    }
    else
    {   if([[parameters objectAtIndex:4] isEqualToString:@"Vegetarian Friendly"])
        {
            p5 = [NSPredicate predicateWithFormat:@"SELF.veg_friendly = 1"];
            [compoundPredicateArray addObject: p5];
        }
        else if([[parameters objectAtIndex:4] isEqualToString:@"Vegan Friendly"])
        {
            p5 = [NSPredicate predicateWithFormat:@"SELF.vegan_friendly = 1"];
            [compoundPredicateArray addObject: p5];
        }
        else if([[parameters objectAtIndex:4] isEqualToString:@"Coeliac Friendly"])
        {
            p5 = [NSPredicate predicateWithFormat:@"SELF.coeliac_friendly = 1"];
            [compoundPredicateArray addObject: p5];
        }
    }
   
    NSPredicate *pred = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:p1, p2, p3, p4, p5, nil]];
    filteredResults = [restaurantsController.listOfRestaurants filteredArrayUsingPredicate:pred];
    NSLog(@"Array: %@", filteredResults);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchParameters";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *parameter = [parameters objectAtIndex:indexPath.row];
    cell.textLabel.text = parameter;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"SelectCounty"])
    {
        ByCountyViewController * byCountyViewController = [segue destinationViewController];
        byCountyViewController.restaurantsController = restaurantsController;
		byCountyViewController.delegate = self;
        byCountyViewController.county = county;
    }

    else if([segue.identifier isEqualToString:@"SelectFoodType"])
    {
        FoodTypeViewController * foodTypeViewController = [segue destinationViewController];
        foodTypeViewController.restaurantsController = restaurantsController;
		foodTypeViewController.delegate = self;
        foodTypeViewController.foodType = foodType;
    }
    else if([segue.identifier isEqualToString:@"SelectPrice"])
    {
        PriceViewController * priceViewController = [segue destinationViewController];
        priceViewController.restaurantsController = restaurantsController;
		priceViewController.delegate = self;
        priceViewController.price = price;
    }
    
    else if([segue.identifier isEqualToString:@"SelectDietaryRequirement"])
    {
        DietaryRequirementsViewController * dietaryRequirementsViewController = [segue destinationViewController];
        dietaryRequirementsViewController.restaurantsController = restaurantsController;
		dietaryRequirementsViewController.delegate = self;
        dietaryRequirementsViewController.dietaryRequirement = dietaryRequirement;
    }

    else if([segue.identifier isEqualToString:@"SelectRating"])
    {
        ByRatingViewController * byRatingViewController = [segue destinationViewController];
        byRatingViewController.restaurantsController = restaurantsController;
		byRatingViewController.delegate = self;
        byRatingViewController.rating = rating;
    }
    
    else if([segue.identifier isEqualToString:@"SeeAll"])
    {
        SearchResultsViewController * searchResultsViewController = [segue destinationViewController];
        //searchResultsViewController.restaurantsController = restaurantsController;
        //[self searchResults];
        searchResultsViewController.filteredResults = self.restaurantsController.listOfRestaurants;
    }
    
    else if([segue.identifier isEqualToString:@"SearchResults"])
    {
        SearchResultsViewController * searchResultsViewController = [segue destinationViewController];
        //searchResultsViewController.restaurantsController = restaurantsController;
        [self searchResults];
        searchResultsViewController.filteredResults = filteredResults;
    }
    
    else if([segue.identifier isEqualToString:@"SearchBarResults"])
    {
        SearchResultsViewController * searchResultsViewController = [segue destinationViewController];
        //searchResultsViewController.restaurantsController = restaurantsController;
        //[self searchResults];
        searchResultsViewController.filteredResults = searchBarResults;
    }

    
    

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *chosenParameter = [self.tableView indexPathForSelectedRow];
    int row = [chosenParameter row];
    if(row == 0)
    {
        [self performSegueWithIdentifier:@"SelectCounty" sender:self];
    }
    else if(row == 1)
    {
        [self performSegueWithIdentifier:@"SelectFoodType" sender:self];
    }
    else if(row == 2)
    {
        [self performSegueWithIdentifier:@"SelectPrice" sender:self];
    }
    else if(row == 3)
    {
        [self performSegueWithIdentifier:@"SelectRating" sender:self];
    }

    else if(row == 4)
    {
        [self performSegueWithIdentifier:@"SelectDietaryRequirement" sender:self];
    }
    else if(row == 5)
    {
        [self performSegueWithIdentifier:@"SeeAll" sender:self];
    }
}

#pragma mark - ByCountyViewControllerDelegate

- (void)byCountyViewController:
(ByCountyViewController *)controller
                   didSelectCounty:(NSString *)theCounty
{
	
    county = theCounty;
    [parameters replaceObjectAtIndex:0 withObject:county];
	[self.navigationController popViewControllerAnimated:YES];
    
}

- (void)foodTypeViewController:
(FoodTypeViewController *)controller
               didSelectFoodType:(NSString *)theFoodType
{
	
    foodType = theFoodType;
    [parameters replaceObjectAtIndex:1 withObject:foodType];
	[self.navigationController popViewControllerAnimated:YES];
    
}

- (void)priceViewController:
(PriceViewController *)controller
             didSelectPrice:(NSString *)thePrice
{
	
    price = thePrice;
    [parameters replaceObjectAtIndex:2 withObject:price];
	[self.navigationController popViewControllerAnimated:YES];
    
}

- (void)byRatingViewController:
(ByRatingViewController *)controller
               didSelectRating:(NSString *)theRating
{
	
    rating = theRating;
    [parameters replaceObjectAtIndex:3 withObject:rating];
	[self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dietaryRequirementsViewController:
(PriceViewController *)controller
             didSelectDietaryRequirement:(NSString *)theDiet
{
	
    dietaryRequirement = theDiet;
    [parameters replaceObjectAtIndex:4 withObject:dietaryRequirement];
	[self.navigationController popViewControllerAnimated:YES];
    
}




@end
