//
//  TSResponseData.h
//  TicketSearch
//
//  Created by Andrey on 12.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSResponseData : NSObject


+(TSResponseData *)sharedInstance;

@property (nonatomic, strong) NSData *aResponseData;

@end
