//
//  AddCommentsViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 01/05/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "AddCommentsViewController.h"

@implementation AddCommentsViewController

@synthesize delegate, commentText, fiveStar, fourStar, twoStar, threeStar, oneStar, commentRating;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set background image
    UIImage *patternImage = [UIImage imageNamed:@"light_toast.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    [fiveStar addTarget:self action:@selector(starSelected:) forControlEvents:UIControlEventTouchUpInside];
    [fourStar addTarget:self action:@selector(starSelected:) forControlEvents:UIControlEventTouchUpInside];
    [threeStar addTarget:self action:@selector(starSelected:) forControlEvents:UIControlEventTouchUpInside];
    [twoStar addTarget:self action:@selector(starSelected:) forControlEvents:UIControlEventTouchUpInside];
    [oneStar addTarget:self action:@selector(starSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;  // this prevents the gesture recognizers to 'block' touches
}

- (void) viewDidAppear:(BOOL)animated
{
    //set up swipe gesture to previous view
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;  // this prevents the gesture recognizers to 'block' touches
}

- (void)hideKeyboard
{
    [commentText resignFirstResponder];
}

//pop view from stack to return to previous view
- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)starSelected:(id)sender
{
    if ([sender tag] == 5)
    {
        [fiveStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [fourStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [threeStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [twoStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [oneStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        commentRating = @"5";
    }
    else if ([sender tag] == 4)
    {
        [fiveStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [fourStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [threeStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [twoStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [oneStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        commentRating = @"4";
    }
    else if ([sender tag] == 3)
    {
        [fiveStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [fourStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [threeStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [twoStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [oneStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        commentRating = @"3";
    }
    else if ([sender tag] == 2)
    {
        [fiveStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [fourStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [threeStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [twoStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        [oneStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        commentRating = @"2";
    }
    else if ([sender tag] == 1)
    {
        [fiveStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [fourStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [threeStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [twoStar setImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        [oneStar setImage:[UIImage imageNamed:@"1Star@2x.png"] forState:UIControlStateNormal];
        commentRating = @"1";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
	[self.delegate addCommentsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
	[self.delegate addCommentsViewControllerDidSave:self];
}

@end

