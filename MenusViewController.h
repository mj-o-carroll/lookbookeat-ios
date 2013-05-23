//
//  MenusViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 30/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenusViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) NSMutableDictionary* selectedMenu;
@property (strong,nonatomic) NSMutableDictionary* selectedRestaurant;
@property (strong,nonatomic) IBOutlet UILabel* menuTitle;
@property (strong,nonatomic) IBOutlet UILabel* startersHeading;
@property (strong,nonatomic) IBOutlet UILabel* mainsHeading;
@property (strong,nonatomic) IBOutlet UILabel* dessertsHeading;
@property (strong,nonatomic) IBOutlet UILabel* starter1;
@property (strong,nonatomic) IBOutlet UILabel* starter2;
@property (strong,nonatomic) IBOutlet UILabel* starter3;
@property (strong,nonatomic) IBOutlet UILabel* main1;
@property (strong,nonatomic) IBOutlet UILabel* main2;
@property (strong,nonatomic) IBOutlet UILabel* main3;
@property (strong,nonatomic) IBOutlet UILabel* dessert1;
@property (strong,nonatomic) IBOutlet UILabel* dessert2;
@property (strong,nonatomic) IBOutlet UILabel* dessert3;



- (void)back;

@end
