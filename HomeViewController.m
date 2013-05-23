//
//  HomeViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 05/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize restaurantsController, logo;


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
    
    [logo setImage:[UIImage imageNamed:@"logo.png"]];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:17.0]];
    
    // set background image
    UIImage *patternImage = [UIImage imageNamed:@"light_toast.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    NSLog(@"Testing first view");
    NSLog(@"%@", [restaurantsController.listOfRestaurants objectAtIndex:0]);
    
    //NSNotification test code 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadJSON:)
                                                 name:@"JSONLoaded"
                                               object:nil];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//NSNotification test code
- (void)reloadJSON:(NSNotification *)refreshedJSON {
    restaurantsController = [refreshedJSON userInfo];
    if (restaurantsController != nil) {
        NSLog(@"Reloaded the JSON!");
        NSLog(@"Kablam, here comes the refreshed restaurant controller!");
        NSLog(@"%@", [restaurantsController.listOfRestaurants objectAtIndex:0]);
        
        
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [[self navigationController] setToolbarHidden:YES];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:17.0]];
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //remove default text from back button
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action: nil];
    
    if([segue.identifier isEqualToString:@"ChooseRestaurant"])
    {
        
    SearchViewController * svc = [segue destinationViewController];
    svc.restaurantsController = restaurantsController;
    }

    else if([segue.identifier isEqualToString:@"GoToNearby"])
    {
        
        NearbyViewController * nearbyViewController = [segue destinationViewController];
        nearbyViewController.restaurantsController = restaurantsController;
    }

}

@end
