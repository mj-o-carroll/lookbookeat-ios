//
//  ByRatingViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 25/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RestaurantsController.h"

@class RestaurantsController;

@class ByRatingViewController;

@protocol ByRatingViewControllerDelegate <NSObject>

- (void)byRatingViewController:
(ByRatingViewController *)controller
             didSelectRating:(NSString *)rating;
@end

@interface ByRatingViewController : UITableViewController

@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (nonatomic, weak) id <ByRatingViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *rating;

- (void)back;




@end
