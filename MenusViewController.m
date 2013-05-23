//
//  MenusViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 30/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "MenusViewController.h"

@interface MenusViewController ()

@end

@implementation MenusViewController

@synthesize selectedMenu, menuTitle, startersHeading, mainsHeading, dessertsHeading, scrollView, selectedRestaurant, starter1, starter2, starter3, main1, main2, main3, dessert1, dessert2, dessert3;

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
	// Do any additional setup after loading the view.
    
    // set title of restaurant
    self.navigationItem.title = [[selectedRestaurant valueForKey:@"name"] uppercaseString];
    
    
    //---set the viewable frame of the scroll view---
    scrollView.frame = CGRectMake(0, 0, 320, 460);
    
    //---set the content size of the scroll view---
    [scrollView setContentSize:CGSizeMake(320, 1000)];

    
    
    
    
    NSLog(@"Here is the menu id: - %@", [selectedMenu valueForKey:@"id"]);
    
    
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
    
    
    [menuTitle setFont:[UIFont fontWithName:@"Avenir-Black" size:19.0]];
    [startersHeading setFont:[UIFont fontWithName:@"Avenir-Black" size:17.0]];
    [mainsHeading setFont:[UIFont fontWithName:@"Avenir-Black" size:17.0]];
    [dessertsHeading setFont:[UIFont fontWithName:@"Avenir-Black" size:17.0]];
    [starter1 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [starter2 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [starter3 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [main1 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [main2 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [main3 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [dessert1 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [dessert2 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [dessert3 setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    
    menuTitle.text = [selectedMenu valueForKey:@"title"];
    starter1.text = [selectedMenu valueForKey:@"starter_1"];
    starter2.text = [selectedMenu valueForKey:@"starter_2"];
    starter3.text = [selectedMenu valueForKey:@"starter_3"];
    main1.text = [selectedMenu valueForKey:@"main_1"];
    main2.text = [selectedMenu valueForKey:@"main_2"];
    main3.text = [selectedMenu valueForKey:@"main_3"];
    dessert1.text = [selectedMenu valueForKey:@"dessert_1"];
    dessert2.text = [selectedMenu valueForKey:@"dessert_2"];
    dessert3.text = [selectedMenu valueForKey:@"dessert_3"];
    

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
