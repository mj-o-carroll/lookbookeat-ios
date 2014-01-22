//
//  AppDelegate.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 13/02/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantsController.h"
#import "HomeViewController.h"

@class HomeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableData *data;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RestaurantsController *restaurantsController;
@property (strong, nonatomic) UINavigationController * nvc;
@property (strong, nonatomic) HomeViewController * hvc;
@property (strong, nonatomic) NSMutableArray *restaurants;

- (void)customizeAppearance;

@end
