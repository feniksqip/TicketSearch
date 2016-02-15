//
//  TSFindTicketsViewController.m
//  TicketSearch
//
//  Created by Andrey on 13.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSFindTicketsViewController.h"

#import "TSTicket.h"

#import "TSFaresTableViewController.h"

@interface TSFindTicketsViewController () {

    NSURLConnection *connectionStart;
    NSURLConnection *connectionStatus;
    NSMutableData *aResponseData;
    NSString *aResponseIdSynonym;
//    NSString *aResponseError;
    id aResponseError;
    
    NSString *completed;
    uint aCompleted;
    
    NSTimer *aProgressTimer;
    
    BOOL aCompletionStatusEnd;
    
    

}

@end

@implementation TSFindTicketsViewController
@synthesize progressView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    aCompleted = 0;
    progressView.progress = aCompleted;
    aCompletionStatusEnd = NO;
//    aProgressTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(sendRequestSearchStatus) userInfo:nil repeats:YES];
    
    
    
    [self sendRequestStartSearch];
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

-(void)sendRequestStartSearch {
    
    //    https://www.anywayanyday.com/api2/NewRequest2/?Route=2501MOWIEVAD1CN0IN0SCE&_Serialize=JSON
    /* Zapros
     Route - marshrut Data (4 simvola = 0102 => 1 Fevralya) + Cities (6 simvolov = MOWSFO => From Moscow To San-Francisco)
     AD - chislo vzroslih (1 - 6)
     CN - chislo detey (age 2 - 12)
     IN - chislo mladentsev (age 0.2 - 2)
     SC - klass ( "E" or "B")
     _Serialize=JSON
     
     */
    
    /* Vozvraschaemie
     id - identifikator zaprosa
     idSynonym - sininim identifikatora (continue / stop)
     Error - oshibka, null = OK
     */
    
    // https://www.anywayanyday.com/api2/RequestState/?R=2U9u8w8OJ0365c&_Serialize=JSON
    //    Completed - процент выполнения поиска
    //    Error – ошибка (null - ошибки нет)
    
    
    TSTicket *aTicket = [TSTicket sharedInstance];
    
    NSMutableString *aFinalRequestString = [NSMutableString stringWithString:@"https://www.anywayanyday.com/api2/NewRequest2/?Route="];
    

    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"ddMM"];
    NSString *finalString = [dateFormatter3 stringFromDate:[aTicket departingDate]];
    [aFinalRequestString appendString:finalString];
    
    [aFinalRequestString appendString:[aTicket cityCodeLeavingFrom]];
    [aFinalRequestString appendString:[aTicket cityCodeGoingTo]];
    [aFinalRequestString appendString:@"AD"];
    [aFinalRequestString appendString: [NSString stringWithFormat:@"%d",[aTicket passengers]]];
    [aFinalRequestString appendString:@"CN"];
    [aFinalRequestString appendString:@"0"];
    [aFinalRequestString appendString:@"IN"];
    [aFinalRequestString appendString:@"0"];
    [aFinalRequestString appendString:@"SC"];
    [aFinalRequestString appendString:[NSString stringWithFormat:@"%c", [aTicket ticketClass] ] ];
    [aFinalRequestString appendString:@"&_Serialize=JSON"];
    
    NSURL *url = [NSURL URLWithString:aFinalRequestString];
    
    
    //        NSString *escapedURL = [finalStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connectionStart = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connectionStart) {
        aResponseData = [NSMutableData new];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSLog(@"Connection StartSearch START !");
    }
}

-(void)sendRequestSearchStatus {

    // https://www.anywayanyday.com/api2/RequestState/?R=2U9u8w8OJ0365c&_Serialize=JSON
    //    Completed - процент выполнения поиска
    //    Error – ошибка (null - ошибки нет)
    
    
    // [aDic objectForKey:@"Error"] == [NSNull null]
// [aResponseError isEqualToString:@""]
    if (  aResponseError == [NSNull null] ) {
    
//    TSTicket *aTicket = [TSTicket sharedInstance];
    
    NSMutableString *aFinalRequestString = [NSMutableString stringWithString:@"https://www.anywayanyday.com/api2/RequestState/?R="];

 
        @try {
            [aFinalRequestString appendString:aResponseIdSynonym];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception : %@, aResponseIdSynonym : %@", [exception description], aResponseIdSynonym);
        }
        @finally {
            
        }
        
        [aFinalRequestString appendString:@"&_Serialize=JSON"];
        
        NSURL *url = [NSURL URLWithString:aFinalRequestString];
        
        
        //        NSString *escapedURL = [finalStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        connectionStatus = [NSURLConnection connectionWithRequest:request delegate:self];
        
        if (connectionStatus) {
            aResponseData = [NSMutableData new];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            NSLog(@"Connection SearchStatus START !");
        }
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [aResponseData setLength:0];
    //    [aResponseSearchData initWithCapacity:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [aResponseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
//    NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:aResponseData options:0 error: &error];
    NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:aResponseData options:0 error: &error];
    // key = Array, 10 objects (Array)
    // key = Count, value = 10 (int)
    // Each array has: 6 key/value pairs

    /*
    {"Id":"d38b689a-bdc5-4e7e-9ce5-5dc592d0476c","IdSynonym":"Tfge4u103Sj1d4","Error":null,"PrivateAirlines":[]}
    */
    // RequestState - R - sininim = IdSynonym
    // _Serialize=JSON
    // https://www.anywayanyday.com/api2/RequestState/?R=2U9u8w8OJ0365c&_Serialize=JSON
    // Response:
    // Completed - процент выполнения поиска
    // Error – ошибка (null - ошибки нет)


    
    if (connectionStart == connection) {
        
        aResponseIdSynonym = [aDic objectForKey:@"IdSynonym"];
        aResponseError = [aDic objectForKey:@"Error"];
        
        if (aResponseError != nil && aResponseIdSynonym ) {
            aProgressTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkEndCompletion) userInfo:nil repeats:YES];
            
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } else if (connectionStatus == connection) {
        //[self updateProgressView];
        aCompleted = [[aDic objectForKey:@"Completed"] intValue];
        [self updateProgressView];
        
    }
    
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"ERROR Connection : %@", [error description]);
}

- (void)updateProgressView
{
    
        if ( aCompleted < 100) {
            NSLog(@"aCompleted = %d", aCompleted);
            progressView.progress = (float)(aCompleted/100.0f);
            NSLog(@"progress = %f", progressView.progress);
            
            aCompletionStatusEnd = NO;
        }
        else {
            progressView.progress = 1.0;
            [aProgressTimer invalidate];
            aProgressTimer = nil;
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSLog(@"Search Completed : 100 percent");
            
            
            TSTicket *aTicket = [TSTicket sharedInstance];
            [aTicket setResponseIdSynonym:aResponseIdSynonym];
            
            //[self sendRequestGetIATA];
            
            // To next VC previous
            // Go to next VC
            UIStoryboard *storyboard = self.storyboard;
            TSFaresTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"faresTableViewController"];
            [self.navigationController pushViewController:controller animated:YES];
            
        }

}

-(void)checkEndCompletion
{
    NSLog(@"Completion status = %@", aCompletionStatusEnd ? @"YES" : @"NO" );
//    if (aCompletionStatusEnd == YES) {
//        [self sendRequestSearchStatus];
//        aCompletionStatusEnd = NO;
//        [self updateProgressView];
//    } else {
////        [self updateProgressView];
//    }
    
    if (aCompletionStatusEnd == NO) {
        [self sendRequestSearchStatus];
//        [self updateProgressView];
        aCompletionStatusEnd = YES;
    } else {
        
    }
    
}

-(void)sendRequestFares {
    /*
    R – синоним поискового запроса
    L – сокращение от language, язык выдачи
    C – сокращение от currency, валюта выдачи
    DebugFullNames=true – стиль показа названий полей в выдаче, в тестовом задании должен быть true
    _Serialize=JSON – способ сериализации, должен быть JSON
     */
//    https://www.anywayanyday.com/api2/Fares2/?L=RU&C=RUB&DebugFullNames=true&_Serialize=JSON&R=489w0t34nq7716
    

}
//-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//
//}

-(void) viewWillDisappear:(BOOL)animated
{
    UIViewController *vc = [[self.navigationController viewControllers] firstObject];
    
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    [super viewWillDisappear:animated];
    
//    if([vc isEqual: <viewController to check> ])
//    {
//        // code here
//    }
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
        [self performSegueWithIdentifier:@"searchTickets" sender:self];
    [super viewWillDisappear:animated];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"searchTickets"])
    {
        
//        TSFaresTableViewController *vc = [segue destinationViewController];
        
        
//        [vc setMyObjectHere:object];
    }
//    else if ([segue identifier] isEqualToString:@"searchTickets"]) {
//    
//    }

}

// searchTickets



@end
