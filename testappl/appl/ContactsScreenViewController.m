//
//  ContactsScreenViewController.m
//  appl
//
//  Created by Reuf Kicin on 10/30/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import "ContactsScreenViewController.h"
#import "ViewController.h"

@interface ContactsScreenViewController ()

@end

@implementation ContactsScreenViewController

//NSArray *podaci;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
    - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PassCalleeID:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:_NumberInput.text forKey:@"calleeid"];
}

- (IBAction)ExitApp:(id)sender {
    exit(0);
}




@end
