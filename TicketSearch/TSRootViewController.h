//
//  TSRootViewController.h
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSRootViewController : UIViewController

- (IBAction)ticketClassAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
- (IBAction)passengersNumberAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIStepper *passengersOutlet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ticketClassOutlet;
@property (weak, nonatomic) IBOutlet UILabel *leavingFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *goingToLabel;
@property (weak, nonatomic) IBOutlet UIButton *findTicketsButton;
- (IBAction)setDepartureDateAction:(id)sender;
@end

