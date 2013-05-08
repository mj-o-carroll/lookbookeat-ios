//
//  DietaryRequirementsViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 25/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "DietaryRequirementsViewController.h"
#import "RestaurantsController.h"

@interface DietaryRequirementsViewController ()

@end

@implementation DietaryRequirementsViewController

@synthesize restaurantsController, delegate, dietaryRequirement;

NSUInteger selectedIndex;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //self.dataController = [[RestaurantsController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    NSLog(@"Kablam, data has got to the bycounty controller!");
    NSLog(@"%@", [restaurantsController.listOfRestaurants objectAtIndex:0]);
    
    selectedIndex = [[restaurantsController dietaryRequirements] indexOfObject:self.dietaryRequirement];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.leftBarButtonItem.title = @"Back";
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[restaurantsController  dietaryRequirements] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DietaryRequirementsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
	NSString * possibleDietaryRequirements = [[restaurantsController dietaryRequirements] objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir" size:17.0]];
	cell.textLabel.text = possibleDietaryRequirements;
    if (indexPath.row == selectedIndex)
		cell.accessoryType =
        UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
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

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (selectedIndex != NSNotFound)
	{
		UITableViewCell *cell = [tableView
                                 cellForRowAtIndexPath:[NSIndexPath
                                                        indexPathForRow:selectedIndex inSection:0]];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	selectedIndex = indexPath.row;
	UITableViewCell *cell =
    [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	NSString *theDiet = [[restaurantsController dietaryRequirements] objectAtIndex:indexPath.row];
	[self.delegate dietaryRequirementsViewController:self didSelectDietaryRequirement
                                                    :theDiet];
}



@end
