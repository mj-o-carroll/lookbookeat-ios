//
//  AddCommentsViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 01/05/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AddCommentsViewController;

@protocol AddCommentsViewControllerDelegate <NSObject>
- (void)addCommentsViewControllerDidCancel:
(AddCommentsViewController *)controller;
- (void)addCommentsViewControllerDidSave:
(AddCommentsViewController *)controller;
@end

@interface AddCommentsViewController : UIViewController
{
    NSUInteger selectedIndex;
}

@property (nonatomic, weak) id <AddCommentsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextView *commentText;
@property (strong, nonatomic) IBOutlet UIButton *fiveStar;
@property (strong, nonatomic) IBOutlet UIButton *fourStar;
@property (strong, nonatomic) IBOutlet UIButton *threeStar;
@property (strong, nonatomic) IBOutlet UIButton *twoStar;
@property (strong, nonatomic) IBOutlet UIButton *oneStar;





- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (void)starSelected:(id)sender;

@end

