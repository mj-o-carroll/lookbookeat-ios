//
//  BookingViewController.h
//  LookBookEat
//
//  Created by MJ O'CARROLL on 02/04/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface BookingViewController : UIViewController<UIPickerViewDelegate, MFMailComposeViewControllerDelegate>
{
    UIPickerView *seatPicker;
    NSString *timeDate;
    NSString *noOfSeats;
}

@property (strong, nonatomic) NSMutableDictionary *selectedRestaurant;
@property (strong, nonatomic) IBOutlet UILabel *selectedTimeDate;
@property (strong, nonatomic) IBOutlet UILabel *selectedNoSeats;


- (IBAction)callDatePicker:(id)sender;
- (IBAction)callSeatPicker:(id)sender;

- (IBAction)sendMail:(id)sender;
- (void)back;

@end
