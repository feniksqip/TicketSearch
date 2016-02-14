//
//  TSRootViewController.m
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSRootViewController.h"

#import "TSTicket.h"
#import "TSRequest.h"
#import "TSCityTableViewController.h"

@interface TSRootViewController () {

    UIView *backView;
}

@end

@implementation TSRootViewController

@synthesize passengersLabel; // Passengers number
@synthesize passengersOutlet; // Stepper
@synthesize ticketClassOutlet; // SegmentedControl
@synthesize leavingFromLabel, goingToLabel; // Cities
@synthesize findTicketsButton; // Find Button
@synthesize departureDatePicker; // Select Departure Date (1 year - 1 day, max long)
@synthesize departureDateLabel; // Show selected Departure Date

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Init params:
    [passengersLabel setText:@"1"];
//    [departureDateLabel setText:@"Введите дату вылета"];
    
    
    
    
    TSTicket *aTicket = [TSTicket new];
    
    [aTicket setTicketClass:'e'];
    
    // https://www.anywayanyday.com/AirportNames/?language=RU&filter=ше&_Serialize=JSON
    
    
    TSRequest *aRequest = [TSRequest new];
   // [aRequest sendRequestToServer];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(firstRequestDone)
                                                 name:@"NSURLConnectionDidFinishLoading"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    TSTicket *aTicket = [TSTicket sharedInstance];
    leavingFromLabel.text = aTicket.leavingFrom;
    goingToLabel.text = aTicket.goingTo;
    
    /*
    double tempVar = [aTicket departingDateDouble];
    
    NSNumber *time3 = [NSNumber numberWithDouble:([aTicket departingDateDouble] / 1000 )];
//                       + 3*3600]; // -3600 = 1 hour
    NSTimeInterval interval3 = [time3 doubleValue];
    NSDate *online3 = [NSDate date];
    online3 = [NSDate dateWithTimeIntervalSince1970:interval3];
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"dd-MM-yyyy"];
    NSString *finalString = [dateFormatter3 stringFromDate:online3];
    
    
    
    NSLog(@"result: %@", [dateFormatter3 stringFromDate:online3]);

    if ( tempVar == 0 ) {
        departureDateLabel.text = @"Введите дату вылета";
    } else {
        departureDateLabel.text = finalString;
    }

    if ([aTicket.cityCodeLeavingFrom isEqualToString:@""] && [aTicket.cityCodeGoingTo isEqualToString:@""] && (tempVar == 0) ) {
    
        [findTicketsButton setEnabled:NO];
        
    } else {
        [findTicketsButton setEnabled:YES];
    }

     */
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"dd-MM-yyyy"];
    NSString *finalString = [dateFormatter3 stringFromDate:[aTicket departingDate]];
    if ( [aTicket departingDate] ) {
        departureDateLabel.text = finalString;
    } else {
        departureDateLabel.text = @"Введите дату вылета";
    }
    
    if ([aTicket.cityCodeLeavingFrom isEqualToString:@""] || [aTicket.cityCodeGoingTo isEqualToString:@""] ) {
        
        [findTicketsButton setEnabled:NO];
        
    } else {
        [findTicketsButton setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)firstRequestDone {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"First request Done !!!" message:@"Text received ..." delegate:self cancelButtonTitle:@"Done!" otherButtonTitles:nil, nil];
//    [alertView show];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"First request Done !!!"
                                                           message:@"Text received ..."
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    });
    
}


- (IBAction)ticketClassAction:(id)sender {
    
    if (ticketClassOutlet.selectedSegmentIndex == 0) {
        [[TSTicket sharedInstance] setTicketClass:'E'];
        NSLog(@"TicketClass : %@", @"Economy" );
        
    } else if (ticketClassOutlet.selectedSegmentIndex == 1) {
        [[TSTicket sharedInstance] setTicketClass:'B'];
        NSLog(@"TicketClass : %@", @"Business" );
    }
    
    // Or ...
    /*
    int clickedSegment = [sender selectedSegmentIndex];
    NSArray *arr = [ticketClassOutlet valueForKey:@"segments"];
    NSString *str = [[arr objectAtIndex:clickedSegment] valueForKey:@"objectValue"];
    NSLog(@"TicketClass : %@", str);
    */
    
}
- (IBAction)passengersNumberAction:(id)sender {
    [passengersLabel setText: [NSString stringWithFormat:@"%.f", [passengersOutlet value] ]];
    [[TSTicket sharedInstance] setPassengers: (uint) [passengersOutlet value]];
    
//    TSTicket *aTicket = [TSTicket sharedInstance];
    NSLog(@"Passengers : %d",  (int)[passengersOutlet value]);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSArray *anCitiesArray = [[TSResponseData sharedInstance] aCityArray];
//    [segue.destinationViewController setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    if ([segue.identifier isEqualToString:@"leavingFrom"] || [segue.identifier isEqualToString:@"goingTo"]) {
            [segue.destinationViewController setSourceSegueId:segue.identifier];
    }
    
}



- (IBAction)setDepartureDateAction:(id)sender {
    
    
//    [departureDatePicker ];
//    [self setDatePicker];
    
    
//    [self setDatePicker2];
}

-(void)setDatePicker2 {
    [self.view setBackgroundColor:[UIColor clearColor]];
//    UIView *backView
    backView = [[UIView alloc] initWithFrame:self.view.frame];
    
//    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        backView.backgroundColor = [UIColor blackColor];
    
    ///
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor yellowColor]]; // grayColor
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(hideDatePicker)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    /////////
    
    
    
    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250)];
    [wrapperView setBackgroundColor:[UIColor whiteColor]];
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    
//    [picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    [wrapperView addSubview:picker];
    [wrapperView addSubview:toolBar];
    [backView addSubview:wrapperView];
    
    [self.view addSubview:backView];
    //[wrapper addSubview:picker];
    //[self.view addSubview:wrapper];
}

-(void)hideDatePicker {
//    backView.hidden = YES;//
    backView.backgroundColor = [UIColor clearColor];
    backView.frame = CGRectMake(0, 0, 0, 0);
    [backView removeFromSuperview];
    [self.view reloadInputViews];
//    [backView removeFromSuperview];
//    [self.view resignFirstResponder];
}

- (IBAction)departureDatePickerAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.departureDatePicker.date];
    
    self.departureDateLabel.text = formatedDate;
}


-(void)setDatePicker {
//    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    [self.departureDateLabel setInputView:datePicker];
    
//    -(IBAction)showDatePicker:(id)sender
//    {
    
        UIDatePicker* picker = [[UIDatePicker alloc] init];
        picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        picker.datePickerMode = UIDatePickerModeDate;
        
        [picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
        CGSize pickerSize = [picker sizeThatFits:CGSizeZero];
        picker.frame = CGRectMake(0.0, 250, pickerSize.width, 460);
        //picker.backgroundColor = [UIColor grayColor];
    
        [self.view addSubview:picker];
       // [picker release];
        
        
//    }
    
    
    
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
}

@end
