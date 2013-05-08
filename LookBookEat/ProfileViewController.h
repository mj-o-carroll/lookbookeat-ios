//
//  ProfileViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 26/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Restaurant.h"
#import "RestaurantMapViewController.h"

@interface ProfileViewController : UIViewController<UITabBarDelegate>


//@property (strong, nonatomic) Restaurant *restaurant;
@property (strong, nonatomic) NSMutableDictionary *selectedRestaurant;
@property (strong, nonatomic) IBOutlet UILabel * restaurantAddress;
@property (strong, nonatomic) IBOutlet UILabel * restaurantPhoneNo;
@property (strong, nonatomic) IBOutlet UITextView * restaurantDescription;
@property (strong, nonatomic) IBOutlet UIImageView * restaurantPic;
@property (strong, nonatomic) IBOutlet UIImageView * restaurantRating;
@property (strong, nonatomic) IBOutlet UIImageView * vegetarianFriendly;
@property (strong, nonatomic) IBOutlet UIImageView * veganFriendly;
@property (strong, nonatomic) IBOutlet UIImageView * coeliacFriendly;





- (IBAction)shareTapped:(id)sender;
- (UIImage *)imageForRating:(int)rating;
-(void)setDietaryRequirements;

- (void)back;


@end
