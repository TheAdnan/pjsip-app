//
//  CallScreenViewController.m
//  appl
//
//  Created by Reuf Kicin on 10/31/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import "CallScreenViewController.h"

@interface CallScreenViewController ()

@end

@implementation CallScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CalleeNumber.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"calleeid"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)HangUp:(id)sender {
     [self performSegueWithIdentifier:@"HangUp" sender:self];
}




@end
