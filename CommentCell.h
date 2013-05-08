//
//  CommentCell.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 01/04/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *commentName;
@property (nonatomic, weak) IBOutlet UITextView *commentContent;
@property (nonatomic, weak) IBOutlet UIImageView *commentRating;
@property (nonatomic, weak) IBOutlet UIImageView *commentBubble;

@end
