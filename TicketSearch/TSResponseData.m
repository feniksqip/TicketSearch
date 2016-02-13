//
//  TSResponseData.m
//  TicketSearch
//
//  Created by Andrey on 12.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSResponseData.h"

@implementation TSResponseData

@synthesize aResponseData;
@synthesize aCityArray;

+(TSResponseData *)sharedInstance {

    static TSResponseData *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
    
    
}

-(id)init {
    if (self = [super init] ) {
        // init
//        aResponseData = [NSData new];
//        aCityArray = [NSArray new];
        
    }

    return self;
}

@end
