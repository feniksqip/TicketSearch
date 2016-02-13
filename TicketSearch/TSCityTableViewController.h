//
//  TSCityTableViewController.h
//  TicketSearch
//
//  Created by Andrey on 12.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSCityTableViewController : UITableViewController <UISearchBarDelegate , UITableViewDataSource, UITableViewDelegate> //nsurlconnectiondatadelegate

- (IBAction)dismissCityTVCAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *searchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchCityBar;

@property (nonatomic, readwrite) NSString *sourceSegueId;

@end
