//
//  TSTicket.h
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTicket : NSObject


@property (strong, nonatomic) NSString *leavingFrom; // destination
@property (strong, nonatomic) NSString *goingTo; // Set current Location


@property (strong, nonatomic) NSDate *departingDate; // 12 months - 1 day // NSDate
@property (nonatomic) double departingDateDouble; // 12 months - 1 day // NSDate
// returningDate


@property (nonatomic) uint passengers; // 1-6


@property (nonatomic) char ticketClass; // economic or business // E or B

@property (strong, nonatomic) NSString *cityCodeLeavingFrom;
@property (strong, nonatomic) NSString *cityCodeGoingTo;

//@property (strong, nonatomic) NSString *anAirport; // not used

/*
keys = @"leavingFrom"
@"goingTo"
@"departingDate"
@"passengers"
@"ticketClass"
 */

+(TSTicket *)sharedInstance;


@end
