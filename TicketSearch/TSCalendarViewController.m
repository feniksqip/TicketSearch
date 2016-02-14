//
//  TSCalendarViewController.m
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSCalendarViewController.h"

#import "TSTicket.h"

@interface TSCalendarViewController () {


    UIView *backView;
}

@end

@implementation TSCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Выберите дату перелета";
    
    [self setDatePicker2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)dismissButtonAction:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:^{
//        //
//    }];
//}


-(void)setDatePicker2 {
    [self.view setBackgroundColor:[UIColor clearColor]];
    backView = [[UIView alloc] initWithFrame:self.view.frame];
//    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 100)];
    //    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    backView.backgroundColor = [UIColor whiteColor];


    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300)]; // 250 height
    [wrapperView setBackgroundColor:[UIColor grayColor]];
//    CGSize wrapperSize =  wrapperView.frame.size; //320, 300
//    CGPoint wrapperOrigin = wrapperView.frame.origin; // 0, 180

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 40)];
    [label setText:@"Выберите дату вылета"];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    
//    CGSize labelSize =  label.frame.size;
//    CGPoint labelOrigin = label.frame.origin;
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, label.frame.size.height, self.view.frame.size.width, 44)]; // 320, 44
    [toolBar setTintColor:[UIColor grayColor]]; // grayColor

    
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Готово" style:UIBarButtonItemStyleBordered target:self action:@selector(hideDatePicker)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil]];
    
    /////////
//    CGSize toolbarSize =  toolBar.frame.size;
//    CGPoint toolbarOrigin = toolBar.frame.origin;
    
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(
                            0,
                            label.frame.size.height + toolBar.frame.size.height,
                            self.view.frame.size.width,
                            wrapperView.frame.size.height - label.frame.size.height - toolBar.frame.size.height)]; // 216 height size
//    CGSize pickerSize =  picker.frame.size;
//    CGPoint pickerOrigin = picker.frame.origin;
    
//    [picker setBackgroundColor:[UIColor yellowColor]];
    [picker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:1];
//    NSDate *maxDate = [calendar dateByAddingComponents:components toDate:currentDate options:0];
//    [components setYear:0];
//    NSDate *minDate = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    
//    [picker setMaximumDate:maxDate];
//    [picker setMinimumDate:minDate];
    [picker setDatePickerMode:UIDatePickerModeDate];
    
    
    [picker setMinimumDate: [NSDate date]];
    NSDate *nowDate = [NSDate date];
    
    ///
    /*
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:28]; //if set 29-02-2017 feb, will 01-03-2017
    [comps setMonth:02];
    //    [comps setYear:2016];
    [comps setYear:[self yearFromDate:nowDate]];
    [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"] ];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *nowDate1 = [cal dateFromComponents:comps];
     */
    ///
    
    BOOL leapYear = [self isYearLeapYear:nowDate];
    int daysToAdd = 0;
    if (leapYear) {
//        daysToAdd = 364 + 1;
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:28]; //if set 29-02-2017 feb, will 01-03-2017
        [comps setMonth:02];
        //    [comps setYear:2016];
        [comps setYear:[self yearFromDate:nowDate]];
        [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"] ];
        
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *tDate = [cal dateFromComponents:comps];
        
        
        if ([nowDate compare:tDate] == NSOrderedDescending) {
            NSLog(@"Date1 is later than Date2");
            daysToAdd = 364;
        } else if ([nowDate compare:tDate] == NSOrderedAscending) {
            NSLog(@"Date1 is earlier than Date2");
            //if (leapYear) {
                daysToAdd = 365;
            //}
        } else {
            NSLog(@"Dates are the same");
            daysToAdd = 364;
        }
        
    } else {
        daysToAdd = 364 ;
    }
    
    NSDate *maxDate = [nowDate dateByAddingTimeInterval:60*60*24*daysToAdd];
    [picker setMaximumDate:maxDate];

    [wrapperView addSubview:label];
    [wrapperView addSubview:toolBar];
    [wrapperView addSubview:picker];
    [backView addSubview:wrapperView];
    
    [self.view addSubview:backView];
}

-(void) dateChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
    
    TSTicket *aTicket = [TSTicket sharedInstance];
    [aTicket setDepartingDate:[sender date]];
    
    double timeSince1970AsDouble = (long long)([[sender date] timeIntervalSince1970] * 1000);
    //double timeSince1970AsDouble = [[sender date] timeIntervalSince1970];
    [aTicket setDepartingDateDouble: timeSince1970AsDouble];

//    NSTimeInterval seconds = [NSDate timeIntervalSinceReferenceDate];
//    double milliseconds = seconds*1000;
    
    
    
    
}

-(void)hideDatePicker {
    
//    TSTicket *aTicket = [TSTicket sharedInstance];
//    [aTicket setDepartingDate:[NSDate date]]; // Better to be here
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    /*
    TSTicket *aTicket = [TSTicket sharedInstance];
//    [aTicket setDepartingDate:[NSDate date]]; // Better to be here
    double timeSince1970AsDouble = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    [aTicket setDepartingDateDouble: timeSince1970AsDouble];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
     */
}

- (BOOL)isYearLeapYear:(NSDate *) aDate {
    NSInteger year = [self yearFromDate:aDate];
    return (( year%100 != 0) && (year%4 == 0)) || year%400 == 0;
}

- (NSInteger)yearFromDate:(NSDate *)aDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy";
    NSInteger year = [[dateFormatter stringFromDate:aDate] integerValue];
    return year;
}

@end

