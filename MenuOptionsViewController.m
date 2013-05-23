//
//  MenuOptionsViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 16/05/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "MenuOptionsViewController.h"

@interface MenuOptionsViewController ()

@end

@implementation MenuOptionsViewController

@synthesize selectedRestaurant, menus, menuListTableView, restaurantMenus, selectedMenu;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //NSURL *url = [NSURL URLWithString:@"http://localhost:3000/menus.json"];
    NSURL *url = [NSURL URLWithString:@"http://lookbookeat.herokuapp.com/menus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //set custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"back_button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:13.0]];

}

- (void) viewDidAppear:(BOOL)animated
{
    //set up swipe gesture to previous view
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
}

//pop view from stack to return to previous view
- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [menuData appendData:theData];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    menuData = [[NSMutableData alloc] init];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    menus = [NSJSONSerialization JSONObjectWithData:menuData options:nil error:nil];
    restaurantMenus = [[NSMutableArray alloc] init];
    
    for(int i=0; i<[menus count]; i++)
    {
        if([[menus valueForKey:@"restaurant_id"]objectAtIndex:i] == [selectedRestaurant valueForKey:@"id"])
            [restaurantMenus addObject:[menus objectAtIndex:i]];
    }
    
    if ([restaurantMenus count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Oops, there's a problem."
                              message: @"We're sorry, there are no menus available for this restaurant."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    
    NSLog(@"Here is the menu id: - %@", [menus valueForKey:@"id"]);
    
    [menuListTableView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot display menus - please make sure you're connected to either 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    return [restaurantMenus count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuOptions";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *menu_type = [[restaurantMenus valueForKey:@"menu_type"] objectAtIndex:indexPath.row];
    NSString *menu_title = [[restaurantMenus valueForKey:@"title"] objectAtIndex:indexPath.row];
    cell.textLabel.text = menu_title;
    cell.detailTextLabel.text = menu_type;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //remove default text from back button
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action: nil];
    
    if([segue.identifier isEqualToString:@"ToMenus"])
    {
        MenusViewController * menusViewController = [segue destinationViewController];
        menusViewController.selectedMenu = selectedMenu;
        menusViewController.selectedRestaurant = selectedRestaurant;
		
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSIndexPath *chosenMenu = [self.tableView indexPathForSelectedRow];
    NSLog(@"I am choosing this menu: %@", chosenMenu);
    int row = [chosenMenu row];
    selectedMenu = [NSDictionary dictionaryWithDictionary:[restaurantMenus objectAtIndex:row]];
     NSLog(@"I am choosing this menu: %@", selectedMenu);
    [self performSegueWithIdentifier:@"ToMenus" sender:self];
    
}

@end
