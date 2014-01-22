//
//  ByCountyViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 05/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"

@class RestaurantsController;
@class ByCountyViewController;

@protocol ByCountyViewControllerDelegate <NSObject>

- (void)byCountyViewController:
(ByCountyViewController *)controller
                   didSelectCounty:(NSString *)county;
                   
@end

@interface ByCountyViewController : UITableViewController

@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (nonatomic, weak) id <ByCountyViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *county;

- (void)back;

@end
