//
//  TSFaresDetailTableViewController.m
//  TicketSearch
//
//  Created by Andrey on 15.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSFaresDetailTableViewController.h"

@interface TSFaresDetailTableViewController () {

    NSMutableArray *currentCompanyFaresArray;
}

@end

@implementation TSFaresDetailTableViewController

@synthesize aCompanyName, aCompanyFaresArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    @try {
        return aCompanyName;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception : %@", [exception description]);
    }
    @finally {
        //return @"";
    }
    //return aCompanyName;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        return nil;
    } else {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 30)];
        // self.view.center.x
//        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x - 30, 0, self.view.frame.size.width, 30)];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
//        UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 312, 5)];
//        UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 312, 1)];
        
//        [top setBackgroundColor:[UIColor lightGrayColor]];
//        [bottom setBackgroundColor:[UIColor lightGrayColor]];
        
        [title setText:[self.tableView.dataSource tableView:tableView titleForHeaderInSection:section]];
        [title setTextColor:[UIColor darkGrayColor]];
//        UIFont *fontName = [UIFont fontWithName:@"Cochin-Bold" size:15.0];
        [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
//        [title setFont:fontName];
//        [title setTextAlignment:NSTextAlignmentCenter];
        
        [headerView addSubview:title];
//        [headerView addSubview:top];
//        [headerView addSubview:bottom];
        
        return headerView;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [aCompanyFaresArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"FaresDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    if ( [aCompanyFaresArray count] != 0) {
        NSString *finalLabelString = [NSString stringWithFormat:@"Fare = %@", [aCompanyFaresArray objectAtIndex:indexPath.row]];
        cell.textLabel.text = finalLabelString;
    } else {
        
    }
    
    
    
    return cell;
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

@end
