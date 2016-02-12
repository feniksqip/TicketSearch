//
//  TSRequest.m
//  TicketSearch
//
//  Created by Andrey on 11.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSRequest.h"

#import "TSResponseData.h"

@implementation TSRequest


-(void)sendRequestToServer {

    // https://www.anywayanyday.com/AirportNames/?language=RU&filter=ше&_Serialize=JSON
    
    NSString *str_1 = @"https://www.anywayanyday.com/AirportNames/?language=RU&filter=";
    NSString *str_3 = @"&_Serialize=JSON";
    
    NSString *str_2 = @"ше";
    
    NSString *finalStr = [NSString stringWithFormat:@"%@%@%@", str_1, str_2, str_3];
    
    NSString *escapedURL = [finalStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedURL];
    
    
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *anOperationQueue = [[NSOperationQueue alloc] init];
    
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:aRequest queue:anOperationQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            /*
             <NSHTTPURLResponse: 0x7b6e3a80> { URL: https://www.anywayanyday.com/AirportNames/?language=RU&filter=%D1%88%D0%B5&_Serialize=JSON } { status code: 200, headers {
             "Access-Control-Allow-Origin" = "*";
             Connection = "keep-alive";
             "Content-Encoding" = gzip;
             "Content-Length" = 429;
             "Content-Type" = "text/plain; charset=utf-8";
             Date = "Fri, 12 Feb 2016 09:33:57 GMT";
             Server = nginx;
             "Strict-Transport-Security" = "max-age=31536000; includeSubDomains";
             } }
            */
            
            // 1402 bytes  = data
            if (!connectionError) {
                TSResponseData *respDataClass = [TSResponseData sharedInstance];
                [respDataClass setAResponseData:data];
                
                
                NSString *str = [NSString stringWithUTF8String:[data bytes]];
                
                double timeSince1970AsDouble = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
                NSError *error = nil;
                NSDictionary *aDic = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
                // key = Array, 10 objects (Array)
                // key = Count, value = 10 (int)
                // Each array has: 6 key/value pairs
                
                NSArray *anArray = [NSArray arrayWithArray: [aDic objectForKey:@"Array"] ];
                /*
                 Airport = "\U0428\U0435\U0440\U0435\U043c\U0435\U0442\U044c\U0435\U0432\U043e";
                 City = "\U041c\U043e\U0441\U043a\U0432\U0430";
                 CityCode = MOW;
                 Code = SVO;
                 Country = "\U0420\U043e\U0441\U0441\U0438\U044f";
                 Data = "\U041c\U043e\U0441\U043a\U0432\U0430, \U0428\U0435\U0440\U0435\U043c\U0435\U0442\U044c\U0435\U0432\U043e, \U0420\U043e\U0441\U0441\U0438\U044f";
                */
                
                
                
                [self connectionDidFinishLoading]; //post notification - done
                
                
            } else {
                NSLog(@"Error Request CompletionHandler: %@", connectionError);
            }
            
            
            
            
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Send Asynch Request : %@", [exception description]);
    }
    @finally {
        
    }

    
    
}

//-(void)connectionDidFinishLoading:(NSURLConnection*)connection {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSURLConnectionDidFinishLoading" object:nil];
//}
-(void)connectionDidFinishLoading {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSURLConnectionDidFinishLoading" object:nil];
}

@end
