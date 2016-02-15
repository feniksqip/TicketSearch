//
//  TSFindTicketsViewController.h
//  TicketSearch
//
//  Created by Andrey on 13.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSFindTicketsViewController : UIViewController <NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *findTicketsLabel;
@end
