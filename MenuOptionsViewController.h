//
//  MenuOptionsViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 16/05/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenusViewController.h"

@interface MenuOptionsViewController : UITableViewController
{
    NSMutableData *menuData;
}

@property (strong, nonatomic) NSMutableDictionary *selectedRestaurant;
@property (strong, nonatomic) NSMutableDictionary *selectedMenu;
@property (strong, nonatomic) NSMutableArray *menus;
@property (strong, nonatomic) NSMutableArray *restaurantMenus;
@property (strong, nonatomic) IBOutlet UITableView *menuListTableView;

- (void)back;

@end
