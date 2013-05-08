//
//  CommentsViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 31/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "CommentsViewController.h"


@interface CommentsViewController ()

@end

@implementation CommentsViewController

@synthesize selectedRestaurant, comments, restaurantName, tableView;

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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
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
    
    // set restaurant name label
    restaurantName.text = [NSString stringWithFormat:@"       %@", [selectedRestaurant valueForKey:@"name"]];
    //restaurantName.text = [selectedRestaurant valueForKey:@"name"];
    //restaurantName.frame = CGRectMake(100,100,100,100);
    
    
    //NSURL *url = [NSURL URLWithString:@"http://localhost:3000/comments.json"];
    NSURL *url = [NSURL URLWithString:@"http://lookbookeat.com/comments.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


//THE FOLLOWING METHODS CONNECT AND PARSE RESTAURANTS JSON
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    comments = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    restaurantsComments = [[NSMutableArray alloc] init];
    //NSLog(@"the comment at this index is: %@",[comments objectAtIndex:0]);
    //NSLog(@"the restaurant at this index is: %@", selectedRestaurant);
    for(int i=0; i<[comments count]; i++)
    {
        if([[comments valueForKey:@"id"]objectAtIndex:i] == [selectedRestaurant valueForKey:@"id"])
            [restaurantsComments addObject:[comments objectAtIndex:i]];
    }
    //NSLog(@"Here are the comments pertaining to this restaurant: - %@", restaurantsComments);
    
        [tableView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot display comments - please make sure you're connected to either 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //remove default text from back button
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action: nil];
    
	if ([segue.identifier isEqualToString:@"AddComment"])
	{
		UINavigationController *navigationController =
        segue.destinationViewController;
		AddCommentsViewController
        *addCommentsViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
		addCommentsViewController.delegate = self;
	}
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
    //NSLog(@"Table View's count:%d", [restaurantsComments count]);
    return [restaurantsComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //NSString *restaurantName = [[restaurantsComments valueForKey:@"name"] objectAtIndex:indexPath.row];
    NSString* commentNameDate = [[NSString alloc] initWithFormat:@"%@ - %@",[[restaurantsComments valueForKey:@"name"] objectAtIndex:indexPath.row],[[restaurantsComments valueForKey:@"date"] objectAtIndex:indexPath.row]];
    
    
    cell.commentName.text = commentNameDate;
    //cell.commentDate.text = [[restaurantsComments valueForKey:@"date"] objectAtIndex:indexPath.row];
    cell.commentContent.text = [[restaurantsComments valueForKey:@"content"] objectAtIndex:indexPath.row];
    cell.commentRating.image = [self imageForRating:[[[restaurantsComments valueForKey:@"rating"] objectAtIndex:indexPath.row] intValue]];
    cell.commentBubble.image = [UIImage imageNamed:@"commentBubble.png"];
    //[vegetarianFriendly setImage:[UIImage imageNamed:@"veggie.png"]];
    //cell.commentRating.image = [[restaurantsComments valueForKey:@"name"] objectAtIndex:indexPath.row];
    NSLog(@"Comment name: %@",  [[restaurantsComments  objectAtIndex:indexPath.row] valueForKey:@"name"]);
    
    
    return cell;
}

- (UIImage *)imageForRating:(int)rating
{
	switch (rating)
	{
		case 1: return [UIImage imageNamed:@"1StarSmall.png"];
		case 2: return [UIImage imageNamed:@"2StarsSmall.png"];
		case 3: return [UIImage imageNamed:@"3StarsSmall.png"];
		case 4: return [UIImage imageNamed:@"4StarsSmall.png"];
		case 5: return [UIImage imageNamed:@"5StarsSmall.png"];
	}
	return nil;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)addCommentsViewControllerDidCancel:
(AddCommentsViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCommentsViewControllerDidSave:
(AddCommentsViewController *)controller
{
    NSLocale *gbLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    NSString *gbFormatString = [NSDateFormatter dateFormatFromTemplate:@"dMMMyyyy" options:0 locale:gbLocale];
    NSDate *currentDateTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // Set the dateFormatter format
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or this format to show day of the week Sat,11-12-2011 23:27:09
    [dateFormatter setDateFormat:gbFormatString];
    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    
    NSMutableDictionary* comment = [[NSMutableDictionary alloc] initWithObjectsAndKeys:controller.commentText.text, @"content",  @"arthur", @"name", dateInStringFormated, @"date", @"2", @"rating", [selectedRestaurant valueForKey:@"id"], @"id",  @"1", @"restaurant_id", @"1", @"user_id", nil];
    //@"arthur", @"name",
    [restaurantsComments addObject:comment];
    [tableView reloadData];
	[self dismissViewControllerAnimated:YES completion:nil];
    
    //NSString *post = [NSString stringWithFormat:@"example=test&p=1&test=yourPostMessage&this=isNotReal"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:comment options:NSJSONWritingPrettyPrinted error:nil];    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsonData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://localhost:3000/comments"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    NSURLResponse *response;
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
    NSLog(@"Reply: %@", theReply);
    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:comment options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"JSON Output: %@", jsonString);
//    
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"http://localhost:3000/comments.json"]];
//    NSString *postLength = [NSString stringWithFormat:@"%d", [jsonData length]];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody: jsonData];
}


@end
