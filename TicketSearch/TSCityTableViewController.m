//
//  TSCityTableViewController.m
//  TicketSearch
//
//  Created by Andrey on 12.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSCityTableViewController.h"

#import "TSResponseData.h"
#import "TSTicket.h"

@interface TSCityTableViewController ()

@end

@implementation TSCityTableViewController {

    NSURLConnection *connection;
//    int connectionEnd;
    BOOL connectionEnd;
    NSMutableData *aResponseSearchData;
    
    NSMutableArray *aCities;
    NSMutableArray *aCountries;
    
    NSArray *tempArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
//    NSArray *anCitiesArrat = [[TSResponseData sharedInstance] aCityArray];
    
    tempArr = @[@"1111111", @"22222", @"3333333", @"444444", @"5", @"66666", @"777777"];
    
    
    
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
    if ( (aCities != nil) && [aCities count]) {
        return [aCities count];
    } else {
        return 0;
    }
    
//    return [tempArr count];

//    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    if ( [aCities count] != 0) {
        NSString *finalLabelString = [NSString stringWithFormat:@"%@,%@",[aCities objectAtIndex:indexPath.row],[aCountries objectAtIndex:indexPath.row]];
        cell.textLabel.text = finalLabelString;
    } else {
//        cell.textLabel.text = [tempArr objectAtIndex:indexPath.row];
//        cell.textLabel.text = @"Введите название города";
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSTicket *aTicket = [TSTicket sharedInstance];
    if ([_sourceSegueId isEqualToString:@"leavingFrom"]) {
        [aTicket setLeavingFrom:[aCities objectAtIndex:indexPath.row]];
    } else if ([_sourceSegueId isEqualToString:@"goingTo"]) {
        [aTicket setGoingTo:[aCities objectAtIndex:indexPath.row]];
    }
//    [aTicket setLeavingFrom:[aCities objectAtIndex:indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismissCityTVCAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] >= 2) {
      //  [self checkEndConnection];
        if (connection) {
            [self stopConnection:connection];
        }
        [self sendRequestWithParameterCity:searchText];
    }
}

-(void)stopConnection:(NSURLConnection *) aConnection {
    [aConnection cancel];
}

-(void)checkEndConnectionWithParameterCity:(NSString *) aCity
{
    NSLog(@"Connection END = %hhd", connectionEnd);
    if (connectionEnd == 1) {
        [self sendRequestWithParameterCity:aCity];
        connectionEnd = 0;
    }
}

-(void)sendRequestWithParameterCity:(NSString *) aCity
{
    // https://www.anywayanyday.com/AirportNames/?language=RU&filter=ше&_Serialize=JSON
    
    NSString *str_1 = @"https://www.anywayanyday.com/AirportNames/?language=RU&filter=";
    NSString *str_3 = @"&_Serialize=JSON";
    
//    NSString *str_2 = @"мо"; // ше
    NSString *str_2 = aCity;
    
    NSString *finalStr = [NSString stringWithFormat:@"%@%@%@", str_1, str_2, str_3];
    
    NSString *escapedURL = [finalStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection) {
        aResponseSearchData = [NSMutableData new];
        NSLog(@"Connection START !");
    }
    
}

- (void)updateProgress
{
//    if ([completed intValue] < 100) {
//        NSLog(@"compl = %@", completed);
//        _progressView.progress = (float)[completed intValue]/100.0f;
//        NSLog(@"prog = %f", _progressView.progress);
//    }
//    else {
//        _progressView.progress = 1.0;
//        [myTimer invalidate];
//        myTimer = nil;
//        NSLog(@"100 percent Completed!");
//        [procAnsw processingAnswer:appDel.synonym];
//    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [aResponseSearchData setLength:0];
//    [aResponseSearchData initWithCapacity:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [aResponseSearchData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:aResponseSearchData options:0 error: &error];
    // key = Array, 10 objects (Array)
    // key = Count, value = 10 (int)
    // Each array has: 6 key/value pairs
    
    NSArray *anArray = [NSArray arrayWithArray: [aDic objectForKey:@"Array"] ];
    
//    NSMutableArray *
    aCities = [NSMutableArray new];
//    NSMutableArray *
    aCountries = [NSMutableArray new];
    
    for (id obj in anArray) {
        [aCities addObject:[obj objectForKey:@"City"]];
        [aCountries addObject:[obj objectForKey:@"Country"]];
    }
    
    
   // [self.tableView beginUpdates];
    // Build the two index paths
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:[aCities count] inSection:0];
    // Add them in an index path array
    NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, indexPath2, nil];
    // Launch reload for the two index path
//    for (int i = 0; i < [aCities count]; i++) {
//    [self.tableView set];
        //[self.tableView reloadRowsAtIndexPaths: indexArray withRowAnimation:UITableViewRowAnimationFade]; //UITableViewRowAnimationNone
//    }
    
    //[self.tableView endUpdates];
    
    [self.tableView reloadData];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR Connection : %@", [error description]);
}

@end
