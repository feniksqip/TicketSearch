//
//  TSFaresTableViewController.m
//  TicketSearch
//
//  Created by Andrey on 15.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSFaresTableViewController.h"

#import "TSTicket.h"

#import "TSFaresDetailTableViewController.h"

@interface TSFaresTableViewController () {

    NSMutableData *aResponseData;
    NSURLConnection *connectionFares;
    
    NSMutableArray *aCompaniesArray;
    
    NSMutableArray *aCompanyFares;
    
    NSMutableArray *aFinalCompaniesArray;
    
    NSURLConnection *connectionCodeIATA;
    NSMutableArray *aCodeIATArray;
    
//    int firstRequestDoneFlag;
    
    NSMutableArray *aFinalCompaniesArrayWithCodeName; // bonus
}

@end

@implementation TSFaresTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    firstRequestDoneFlag = 0;
    [self sendRequestFares];
    
//    while (firstRequestDoneFlag == 0) {
//        [self sendRequestGetIATA];
//        firstRequestDoneFlag = 0;
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(firstRequestDone)
                                        name:@"NSURLConnectionDidFinishLoading_sendRequestFares"
                                               object:nil];
    
}

-(void)firstRequestDone {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"First request Done !!!" message:@"Text received ..." delegate:self cancelButtonTitle:@"Done!" otherButtonTitles:nil, nil];
    //    [alertView show];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"First request Done !!!"
//                                                           message:@"Text received ..."
//                                                          delegate:self
//                                                 cancelButtonTitle:@"OK"
//                                                 otherButtonTitles:nil];
//        [theAlert show];
//    });
    
    // get IATA
    [self sendRequestGetIATA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (aFinalCompaniesArray != nil) {
        return [aFinalCompaniesArray count];
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"FaresCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    
//    if ( [aFinalCompaniesArray count] != 0) {
//        //Sort Array
////        for (id obj in [aCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"Fares"]) {
////            
////        }
////        NSArray *numbers = [[aFinalCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"TotalAmount"];
////        float xmax = -MAXFLOAT;
////        float xmin = MAXFLOAT;
////        for (NSNumber *num in numbers) {
////            float x = num.floatValue;
////            if (x < xmin) xmin = x;
////            if (x > xmax) xmax = x;
////        }
////        // Quick sort
////
//        
//        NSString *finalLabelString = [NSString stringWithFormat:@"CompName=%@, minFare=%@",[[aCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"Code"], [[[aFinalCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"TotalAmount"] firstObject]];
//        cell.textLabel.text = finalLabelString;
//    } else {
//    }
    
    
    if ( [aFinalCompaniesArrayWithCodeName count] != 0) {
        //Sort Array
        //        for (id obj in [aCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"Fares"]) {
        //
        //        }
        //        NSArray *numbers = [[aFinalCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"TotalAmount"];
        //        float xmax = -MAXFLOAT;
        //        float xmin = MAXFLOAT;
        //        for (NSNumber *num in numbers) {
        //            float x = num.floatValue;
        //            if (x < xmin) xmin = x;
        //            if (x > xmax) xmax = x;
        //        }
        //        // Quick sort
        //
        
        // min tarif
        NSString *finalLabelString = [NSString stringWithFormat:@"%@ : %@",
                                      [[aFinalCompaniesArrayWithCodeName objectAtIndex:indexPath.row] objectForKey:@"Name"],
                                      [[[aFinalCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"TotalAmount"] firstObject]];
        cell.textLabel.text = finalLabelString;
    } else {
    }
    
    return cell;
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
    
    TSTicket *aTicket = [TSTicket sharedInstance];
    
    NSMutableString *aFinalRequestString = [NSMutableString stringWithString:@"https://www.anywayanyday.com/api2/Fares2/?"];
    [aFinalRequestString appendString:@"L="];
    [aFinalRequestString appendString:@"RU"];
    [aFinalRequestString appendString:@"&C="];
    [aFinalRequestString appendString:@"RUB"];
    [aFinalRequestString appendString:@"&DebugFullNames="];
    [aFinalRequestString appendString:@"true"];
    [aFinalRequestString appendString:@"&_Serialize="];
    [aFinalRequestString appendString:@"JSON"];
    [aFinalRequestString appendString:@"&R="];
    [aFinalRequestString appendString:[aTicket responseIdSynonym]];
    
    NSURL *url = [NSURL URLWithString:aFinalRequestString];
    
    //        NSString *escapedURL = [finalStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connectionFares = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connectionFares) {
        aResponseData = [NSMutableData new];
        NSLog(@"Connection RequestFares START !");
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
    NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:aResponseData options:0 error: &error];
    // key = Array, 10 objects (Array)
    // key = Count, value = 10 (int)
    // Each array has: 6 key/value pairs
    
    NSString *aKeyAirlines = @"Airlines";
    NSString *aKeyAirlineCode = @"Code";
    NSString *aKeyFares = @"Fares";    //Array , Show min fare
    
//    NSArray *allKeys = [aDic allKeys];
    /* //15
     CurrentTime,
     CrossSale,
     Request,
     References,
     Currency,
     Airlines,
     FutureCrossSale,
     PriceWithCommission,
     TotalAirlinesCount,
     AtcInfo,
     HistoryTags,
     Error,
     TotalFaresCount,
     AllGDSDone,
     Language
    */
    // Airlines (array) : (Code-String, Fares-Array)
    // Fares (array) : (Key = TotalAmount, ...)
    
//    NSArray *allValues = [aDic allValues];
    
    if (connectionFares == connection) {
    aCompaniesArray = [aDic objectForKey:aKeyAirlines]; // array
    NSString *aKeyTotalPrice = @"TotalAmount";
    aFinalCompaniesArray = [NSMutableArray new];
    
    for (NSDictionary *tempDic in aCompaniesArray) {
        
        NSString *anAirlineCode = [tempDic objectForKey:aKeyAirlineCode];
        NSArray *aFaresArray = [tempDic objectForKey:aKeyFares];
        
        NSMutableArray *aFaresPriceArray = [NSMutableArray new];
        for (NSDictionary *tempDic2 in aFaresArray) {
            [aFaresPriceArray addObject:[tempDic2 objectForKey:aKeyTotalPrice]];
        }
        
        // Sort Array
        NSArray *aSortedArray = [aFaresPriceArray sortedArrayUsingComparator:
                                ^NSComparisonResult(id obj1, id obj2) {
                                    if ([obj1 integerValue] < [obj2 integerValue]) {
                                        return NSOrderedAscending;
                                    } else if ([obj1 integerValue] > [obj2 integerValue]) {
                                        return NSOrderedDescending;
                                    } else {
                                        return NSOrderedSame;
                                    }
                                }];
        
        NSLog(@"%@", aSortedArray);
        
        NSDictionary *aCompanyDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     anAirlineCode, aKeyAirlineCode,
                                     aSortedArray, aKeyTotalPrice,
                                     nil];
        [aFinalCompaniesArray addObject:aCompanyDic];
    }

    
    
    }
    
    /*
     {"Id":"d38b689a-bdc5-4e7e-9ce5-5dc592d0476c","IdSynonym":"Tfge4u103Sj1d4","Error":null,"PrivateAirlines":[]}
     */
    // RequestState - R - sininim = IdSynonym
    // _Serialize=JSON
    // https://www.anywayanyday.com/api2/RequestState/?R=2U9u8w8OJ0365c&_Serialize=JSON
    // Response:
    // Completed - процент выполнения поиска
    // Error – ошибка (null - ошибки нет)
    
//    aResponseIdSynonym = [aDic objectForKey:@"IdSynonym"];
//    aResponseError = [aDic objectForKey:@"Error"];
//    
//    if (connectionStart == connection) {
//        if (aResponseError != nil && aResponseIdSynonym ) {
//            aProgressTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkEndCompletion) userInfo:nil repeats:YES];
//            
//        }
//    } else if (connectionStatus == connection) {
//        //[self updateProgressView];
//        aCompleted = [[aDic objectForKey:@"Completed"] intValue];
//        [self updateProgressView];
//    }
    
    /*
     1.	Список авиакомпаний, в поле таблицы отображать
     a.	код компании
     b.	наименьший тариф из тарифов (Fares), найденных для данной компании
     2.	Список тарифов для выбранной в (1) авиакомпании, отсортированный по стоимости тарифов, от самого дешевого к самому дорогому
     
     Airlines – массив авиакомпаний (в фрагменте показаны две а/к, с кодами S7 и PS, с каждой из авиакомпаний связана структура данных, в составе которых для вас важнее всего массив Fares – это тарифы (т.е., рейсы по заданному маршруту от данной авиакомпании), стоимость тарифа указывается в поле TotalAmount.

     */

    
    else if (connectionCodeIATA == connection) {
        // aDic = 965 objects
        // 0 = Code, 1 = Name
        // Code = 2N; Name = NextJet;
        
//        aFinalCompaniesArray - used for get Code-Name
        
        
        NSMutableArray *anIATACodeArray = [NSMutableArray new];
        NSMutableArray *anIATANameArray = [NSMutableArray new];
        for (NSDictionary *tempDic in aDic) {
            [anIATACodeArray addObject:[tempDic objectForKey:@"Code"]];
            [anIATANameArray addObject:[tempDic objectForKey:@"Name"]];
        }
        
        //        int anIndex = [anIATACodeArray indexOfObjectPassingTest:
        //         ^(id obj, NSUInteger idx, BOOL *stop) {
        //             return [obj isEqualToString: @"2N"];
        //         }];
        //        NSString *findName = [anIATANameArray objectAtIndex:anIndex];
        
        aFinalCompaniesArrayWithCodeName = [NSMutableArray new];
        
        for (NSDictionary *tempDic in aFinalCompaniesArray) {
            NSInteger indexOfTheObject = -1000;
            indexOfTheObject = [anIATACodeArray indexOfObject:[tempDic objectForKey:@"Code"]];
            if (indexOfTheObject != -1000) {
            
            NSDictionary *aDicWithCodeName = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [tempDic objectForKey:@"Code"], @"Code",
                                    [anIATANameArray objectAtIndex:indexOfTheObject], @"Name",
                                    [tempDic objectForKey:@"TotalAmount"], @"TotalAmount",
                                    nil];
         
            
            [aFinalCompaniesArrayWithCodeName addObject:aDicWithCodeName];
            }
        }
        
        [self.tableView reloadData];
    }
    
//    firstRequestDoneFlag = 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSURLConnectionDidFinishLoading_sendRequestFares" object:nil];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR Connection : %@", [error description]);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"faresDetailTableViewController"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TSFaresDetailTableViewController *detailViewController = [segue destinationViewController];
//        detailViewController.aCompanyName = [[aFinalCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"Code"]; // CodeName
        detailViewController.aCompanyName = [[aFinalCompaniesArrayWithCodeName objectAtIndex:indexPath.row] objectForKey:@"Name"]; // CodeName
        detailViewController.aCompanyFaresArray = [[aFinalCompaniesArray objectAtIndex:indexPath.row] objectForKey:@"TotalAmount"];
    }
}

-(void)sendRequestGetIATA {
    // https://www.anywayanyday.com/Controller/UserFuncs/BackOffice/GetAirlines/
    NSString *str = @"https://www.anywayanyday.com/Controller/UserFuncs/BackOffice/GetAirlines/";
    TSTicket *aTicket = [TSTicket sharedInstance];
    
    NSURL *url = [NSURL URLWithString:str];
    
    //        NSString *escapedURL = [finalStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connectionCodeIATA = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connectionCodeIATA) {
        aResponseData = [NSMutableData new];
        NSLog(@"Connection RequestGetIATA START !");
    }
    
    
}


@end
