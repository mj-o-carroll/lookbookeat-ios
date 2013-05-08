//
//  ProfileViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "ProfileViewController.h"
#import <Social/Social.h>
#import "RestaurantMapViewController.h"
#import "MenusViewController.h"
#import "CommentsViewController.h"
#import "BookingViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize selectedRestaurant, restaurantAddress, restaurantPhoneNo, restaurantPic, restaurantDescription, veganFriendly, vegetarianFriendly, coeliacFriendly;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set title of restaurant
    self.navigationItem.title = [[selectedRestaurant valueForKey:@"name"] uppercaseString];
    
    // set background of textview
    restaurantDescription.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"light_toast.png"]];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:13.0]];
    
    // load pic from server
    NSString* baseURL = [[NSString alloc] initWithFormat:@"http://www.lookbookeat.com/images/"];
    NSString* picURL = [[NSString alloc] initWithFormat:@"%@%@", baseURL, [selectedRestaurant valueForKey:@"picture"]];
    [restaurantPic setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
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
    
	// Do any additional setup after loading the view.
    //restaurant = [restaurant initWithContentsOfDictionary:selectedRestaurant];
    //NSLog(@"%@", restaurant);
    //restaurantName.text = [selectedRestaurant valueForKey:@"name"];
    restaurantAddress.text = [selectedRestaurant valueForKey:@"address"];
    restaurantPhoneNo.text = [selectedRestaurant valueForKey:@"phone_no"];
    restaurantDescription.text = [selectedRestaurant valueForKey:@"description"];
    _restaurantRating.image = [self imageForRating:[[selectedRestaurant valueForKey:@"rating"] intValue]];
    [self setDietaryRequirements];
    NSLog(@"%@", selectedRestaurant);
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //remove default text from back button
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action: nil];
    
    if([segue.identifier isEqualToString:@"ToRestaurantMap"])
    {
        RestaurantMapViewController * restaurantMapViewController = [segue destinationViewController];
        restaurantMapViewController.selectedRestaurant = selectedRestaurant;
        
        
    }
    
    else if([segue.identifier isEqualToString:@"ToComments"])
    {
        CommentsViewController * commentsViewController = [segue destinationViewController];
        commentsViewController.selectedRestaurant = selectedRestaurant;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    else if([segue.identifier isEqualToString:@"ToBooking"])
    {
        BookingViewController * bookingViewController = [segue destinationViewController];
        bookingViewController.selectedRestaurant = selectedRestaurant;
    }
}

-(void)setDietaryRequirements
{
    
    NSString *vegValue = [NSString stringWithFormat:@"%@", [selectedRestaurant valueForKey:@"veg_friendly"]];
    NSLog(@"VEGGIE VALUE: - - - -%@", vegValue);
    if ([vegValue isEqual: @"1"])
    {
        [vegetarianFriendly setImage:[UIImage imageNamed:@"veggie.png"]];
    }
    NSString *veganValue = [NSString stringWithFormat:@"%@", [selectedRestaurant valueForKey:@"vegan_friendly"]];
    NSLog(@"VEGGIE VALUE: - - - -%@", veganValue);
    if ([veganValue isEqual: @"1"])
    {
        [veganFriendly setImage:[UIImage imageNamed:@"vegan.png"]];
    }
    NSString *coeliacValue = [NSString stringWithFormat:@"%@", [selectedRestaurant valueForKey:@"coeliac_friendly"]];
    NSLog(@"VEGGIE VALUE: - - - -%@", coeliacValue);
    if ([coeliacValue isEqual: @"1"])
    {
        [coeliacFriendly setImage:[UIImage imageNamed:@"coeliac_friendly.png"]];
    }
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

- (IBAction)shareTapped:(id)sender
    {
        NSString *message = [[NSString alloc] initWithFormat:@"I'm at %@ and really enjoying the food and company! Find them on the LookBookEat iOS app or www.lookbookeat.com", [selectedRestaurant valueForKey:@"name"]];
        //add resturant image here
        //UIImage *imageToShare = [UIImage imageNamed:@"test.jpg"];
        
        NSArray *postItems = @[message];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                                initWithActivityItems:postItems
                                                applicationActivities:nil];
        
        [self presentViewController:activityVC animated:YES completion:nil];
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//        [tweetSheet setInitialText:@"I'm using LookBookEat!"];
//        [self presentViewController:tweetSheet animated:YES completion:nil];
//    }
//    else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure you have a network connection and a Twitter account created!"
//                                  delegate:self
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//        [alertView show];
//    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
