//
//  PriceViewViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 23/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"

@class RestaurantsController;

@class PriceViewController;

@protocol PriceViewControllerDelegate <NSObject>

- (void)priceViewController:
(PriceViewController *)controller
             didSelectPrice:(NSString *)price;

@end

@interface PriceViewController : UITableViewController

@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (nonatomic, weak) id <PriceViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *price;

- (void)back;


@end
