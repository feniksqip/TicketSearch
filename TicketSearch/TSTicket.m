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
        leavingFrom = @"Moscow";
        goingTo = @"Paris";
        departingDate = [NSDate date];
        passengers = 1;
        ticketClass = 'E';
        
    }
    
    return self;
}


@end
