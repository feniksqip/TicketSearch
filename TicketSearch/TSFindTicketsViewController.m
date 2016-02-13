//
//  TSFindTicketsViewController.m
//  TicketSearch
//
//  Created by Andrey on 13.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "TSFindTicketsViewController.h"

#import "TSTicket.h"

@interface TSFindTicketsViewController ()

@end

@implementation TSFindTicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)sendRequest {
//    https://www.anywayanyday.com/api2/NewRequest2/?Route=2501MOWIEVAD1CN0IN0SCE&_Serialize=JSON
    /* Zapros
     Route - marshrut Data (4 simvola = 0102 => 1 Fevralya) + Cities (6 simvolov = MOWSFO => From Moscow To San-Francisco)
     AD - chislo vzroslih (1 - 6)
     CN - chislo detey (age 2 - 12)
     IN - chislo mladentsev (age 0.2 - 2)
     SC - klass ( "E" or "B")
     _Serialize=JSON
     
    */
    
    /* Vozvraschaemie
     id - identifikator zaprosa
     idSynonym - sininim identifikatora (continue / stop)
     Error - oshibka, null = OK
    */
    
    TSTicket *aTicket = [TSTicket sharedInstance];
    
    NSMutableString *aFinalRequest = [NSMutableString stringWithString:@"https://www.anywayanyday.com/api2/NewRequest2/?Route="];
//    [aFinalRequest appendString:aTic ];
    
}

@end
