//
//  CommentsViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 31/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h"
#import "AddCommentsViewController.h"

@interface CommentsViewController : UITableViewController <AddCommentsViewControllerDelegate>
{
    NSMutableData *data;
    NSMutableArray* restaurantsComments;
}


@property (strong, nonatomic) NSMutableDictionary *selectedRestaurant;
@property (strong, nonatomic) NSMutableArray *comments;
@property (nonatomic, weak) IBOutlet UILabel *restaurantName;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (UIImage *)imageForRating:(int)rating;
- (void)back;

@end
