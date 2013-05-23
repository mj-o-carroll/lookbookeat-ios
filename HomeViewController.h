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


@property (strong, nonatomic) RestaurantsController * restaurantsController;
@property (strong, nonatomic) IBOutlet UIImageView * logo;

- (void)back;


@end
