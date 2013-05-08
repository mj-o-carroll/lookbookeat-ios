//
//  FoodTypeViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 23/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"

@class RestaurantsController;

@class FoodTypeViewController;

@protocol FoodTypeViewControllerDelegate <NSObject>

- (void)foodTypeViewController:
(FoodTypeViewController *)controller
               didSelectFoodType:(NSString *)foodType;

@end

@interface FoodTypeViewController : UITableViewController

@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (nonatomic, weak) id <FoodTypeViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *foodType;

- (void)back;

@end
