//
//  CommentCell.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 01/04/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

@synthesize commentContent, commentRating, commentName, commentBubble;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
