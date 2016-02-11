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


@property (strong, nonatomic) NSDate *departingDate; // 12 months - 1 day
// returningDate


@property (nonatomic) uint passengers; // 1-6


@property (nonatomic) char ticketClass; // economic or business




@end
