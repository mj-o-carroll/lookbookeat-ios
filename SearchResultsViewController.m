//
//  SearchResultsViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 25/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "ProfileViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

@synthesize filteredResults, selectedRestaurant;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set background image
    UIImage *patternImage = [UIImage imageNamed:@"light_toast.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    UIImage *buttonImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    [self.navigationController setToolbarHidden:YES];
    
    // alert if no results
    if ([filteredResults count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Sorry there are no matching restaurants."
                              message: @"Please refine your search and try again."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //remove default text from back button
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action: nil];
    
    if([segue.identifier isEqualToString:@"ToProfile"])
    {
        ProfileViewController * profileViewController = [segue destinationViewController];
        profileViewController.selectedRestaurant = selectedRestaurant;
		
    }
    
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
    return [filteredResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchResults";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    // load pic from server
//    NSString* baseURL = [[NSString alloc] initWithFormat:@"http://www.lookbookeat.com/images/"];
//    NSString* picURL = [[NSString alloc] initWithFormat:@"%@%@", baseURL, [selectedRestaurant valueForKey:@"picture"]];
//    [restaurantPic setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    
    // load pic from server
    NSString* baseURL = [[NSString alloc] initWithFormat:@"http://www.lookbookeat.com/images/"];
    NSString *restaurantThumbPath = [[filteredResults valueForKey:@"picture"] objectAtIndex:indexPath.row];
    NSString* picURL = [[NSString alloc] initWithFormat:@"%@%@", baseURL, restaurantThumbPath];
    NSString *restaurantName = [[filteredResults valueForKey:@"name"] objectAtIndex:indexPath.row];
    NSString *restaurantAddress = [[filteredResults valueForKey:@"address"] objectAtIndex:indexPath.row];
  
    
    
    
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    [nameLabel setFont:[UIFont fontWithName:@"Avenir" size:17.0]];
	nameLabel.text = restaurantName;
	UILabel *addressLabel = (UILabel *)[cell viewWithTag:101];
    [addressLabel setFont:[UIFont fontWithName:@"Avenir" size:13.0]];
	addressLabel.text = restaurantAddress;
	UIImageView * thumbView = (UIImageView *)[cell viewWithTag:102];
    [thumbView setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

	//thumbView.image = [self imageForRating:player.rating];
    
     

    return cell;
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
    NSLog(@"%@", chosenParameter);
    int row = [chosenParameter row];
    selectedRestaurant = [NSDictionary dictionaryWithDictionary:[filteredResults objectAtIndex:row]];
    [self performSegueWithIdentifier:@"ToProfile" sender:self];

}

@end
