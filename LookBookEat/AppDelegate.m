//
//  AppDelegate.m
//  LookBookEat
//
//  Created by MJ O'CARROLL on 13/02/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate


@synthesize restaurantsController, window, restaurants, hvc, nvc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //connect to restaurants JSON
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //NSURL *url = [NSURL URLWithString:@"http://localhost:3000/restaurants.json"];
    NSURL *url = [NSURL URLWithString:@"http://lookbookeat.com/restaurants.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];

    nvc = (UINavigationController*) self.window.rootViewController;
    hvc = [[nvc viewControllers] objectAtIndex:0];
    restaurantsController = [[RestaurantsController alloc] initWithArray:restaurants];
    hvc.restaurantsController = restaurantsController;
    
    NSLog(@"Root: %@", self.window.rootViewController);
    NSLog(@"Testing");
    NSLog(@"List of current active view controllers:%@", self.window.rootViewController);
    
    [self customizeAppearance];
    
    return YES;
}

- (void)customizeAppearance
{
        // Customize the title text for *all* UINavigationBars
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor],
          UITextAttributeTextColor,
          [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
          UITextAttributeTextShadowOffset,
          [UIFont fontWithName:@"Avenir" size:17.0],
          UITextAttributeFont,
          nil]];
        //adjust vertical position of navigation bar text
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
    //[[UILabel appearance] setFont:[UIFont fontWithName:@"Avenir" size:14.0]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar.png"]forToolbarPosition:1
                                    barMetrics:UIBarMetricsDefault];
    //bar button text
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15], UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    //[[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"toolbar.png"] forBarMetrics:UIBarMetricsDefault];
}

//THE FOLLOWING METHODS CONNECT AND PARSE RESTAURANTS JSON
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];    
}
                   

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
        [data appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    restaurants = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    hvc.restaurantsController.listOfRestaurants = restaurants;

    //NSNotification code
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JSONLoaded" object:self userInfo:restaurantsController];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The download could not complete - please make sure you're connected to either 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
