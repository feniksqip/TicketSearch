//
//  RootViewController.m
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "RootViewController.h"

#import "TSTicket.h"
#import "TSRequest.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    TSTicket *aTicket = [TSTicket new];
    
    [aTicket setTicketClass:'e'];
    
    // https://www.anywayanyday.com/AirportNames/?language=RU&filter=ше&_Serialize=JSON
    
    
    TSRequest *aRequest = [TSRequest new];
    [aRequest sendRequestToServer];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(firstRequestDone)
                                                 name:@"NSURLConnectionDidFinishLoading"
                                               object:nil];
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


@end
