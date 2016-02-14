//
//  TSTicket.m
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSTicket.h"

@implementation TSTicket

@synthesize leavingFrom, goingTo;
@synthesize departingDate;
@synthesize passengers;
@synthesize ticketClass;

@synthesize cityCodeLeavingFrom, cityCodeGoingTo;
//@synthesize anAirport;

@synthesize departingDateDouble;

+(TSTicket *)sharedInstance {
    
    static TSTicket *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
    
    
}

-(id)init {
    if (self = [super init] ) {
        // init
//        leavingFrom = @"Moscow";
//        goingTo = @"Paris";
        leavingFrom = @"Введите город отправления";
        goingTo = @"Введите город назначения";
        departingDate = [NSDate date]; // [NSDate date]
        passengers = 1;
        ticketClass = 'E';
        
        departingDateDouble = 0;
        
        cityCodeLeavingFrom = @""; //MOW
        cityCodeGoingTo = @""; //MOW
//        anAirport = @""; // not used
        
    }
    
    return self;
}


@end
