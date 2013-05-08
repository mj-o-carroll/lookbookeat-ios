//
//  AddCommentsViewController.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 01/05/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "AddCommentsViewController.h"


@implementation AddCommentsViewController

@synthesize delegate, commentText, fiveStar, fourStar, twoStar, threeStar, oneStar;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set background image
    UIImage *patternImage = [UIImage imageNamed:@"light_toast.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    [fiveStar addTarget:self action:@selector(starSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self
    //                                                                              action:@selector(tableClicked)];
    //    [tableView addGestureRecognizer:tapgesture];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)starSelected:(id)sender
{
    if (fiveStar)
    {
        [fiveStar setImage:[UIImage imageNamed:@"test@2x.png"] forState:UIControlStateNormal];
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

