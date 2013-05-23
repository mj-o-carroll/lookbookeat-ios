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
#import "MenuOptionsViewController.h"
#import "CommentsViewController.h"
#import "BookingViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize selectedRestaurant, scrollView, restaurantAddress, priceRange, restaurantPhoneNo, restaurantPic, restaurantDescription, veganFriendly, vegetarianFriendly, coeliacFriendly;

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
    
    
    
    //---set the viewable frame of the scroll view---
    scrollView.frame = CGRectMake(0, 0, 320, 460);
    
    // set title of restaurant
    self.navigationItem.title = [[selectedRestaurant valueForKey:@"name"] uppercaseString];
    
    // set background of textview
    restaurantDescription.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"light_toast.png"]];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [restaurantPic setImage:[UIImage imageNamed:[selectedRestaurant valueForKey:@"picture"]]];
    
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

    restaurantAddress.text = [selectedRestaurant valueForKey:@"address"];
    restaurantPhoneNo.text = [selectedRestaurant valueForKey:@"phone_no"];
    priceRange.text = [[NSString alloc] initWithFormat:@"Price Range %@",[selectedRestaurant valueForKey:@"price_range"]];

    restaurantDescription.text = [selectedRestaurant valueForKey:@"description"];
    _restaurantRating.image = [self imageForRating:[[selectedRestaurant valueForKey:@"rating"] intValue]];
    [self setDietaryRequirements];
    NSLog(@"%@", selectedRestaurant);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    
    //---set the content size of the scroll view---
    [self.scrollView setContentSize:CGSizeMake(320, 700)];
    
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
    else if([segue.identifier isEqualToString:@"ToMenus"])
    {
        MenuOptionsViewController * menuOptionsViewController = [segue destinationViewController];
        menuOptionsViewController.selectedRestaurant = selectedRestaurant;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    }
}

-(void)setDietaryRequirements
{
    
    NSString *vegValue = [NSString stringWithFormat:@"%@", [selectedRestaurant valueForKey:@"veg_friendly"]];
    if ([vegValue isEqual: @"1"])
    {
        [vegetarianFriendly setImage:[UIImage imageNamed:@"veggie.png"]];
    }
    NSString *veganValue = [NSString stringWithFormat:@"%@", [selectedRestaurant valueForKey:@"vegan_friendly"]];
    if ([veganValue isEqual: @"1"])
    {
        [veganFriendly setImage:[UIImage imageNamed:@"vegan.png"]];
    }
    NSString *coeliacValue = [NSString stringWithFormat:@"%@", [selectedRestaurant valueForKey:@"coeliac_friendly"]];
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
        
        NSArray *postItems = @[message];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                                initWithActivityItems:postItems
                                                applicationActivities:nil];
        
        [self presentViewController:activityVC animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
