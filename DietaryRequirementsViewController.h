//
//  DietaryRequirementsViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 25/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"

@class RestaurantsController;

@class DietaryRequirementsViewController;

@protocol DietaryRequirementsViewControllerDelegate <NSObject>

- (void)dietaryRequirementsViewController:
(DietaryRequirementsViewController *)controller
               didSelectDietaryRequirement:(NSString *)dietaryRequirement;

@end

@interface DietaryRequirementsViewController : UITableViewController

@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (nonatomic, weak) id <DietaryRequirementsViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *dietaryRequirement;


- (void)back;

@end