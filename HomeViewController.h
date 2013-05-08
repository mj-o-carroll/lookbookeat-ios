//
//  HomeViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 05/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"
#import "NearbyViewController.h"



@interface HomeViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) RestaurantsController * restaurantsController;

- (void)back;


@end
