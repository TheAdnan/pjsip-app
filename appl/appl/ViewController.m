//
//  ViewController.m
//  appl
//
//  Created by Reuf Kicin on 10/22/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import "ViewController.h"



@interface user()

@end

@implementation user

@synthesize username;
@synthesize pass;
@synthesize host;
@synthesize port;

- (id)init{
    if(self = [super init]){
        port = 5060;
    }
    return self;
}


@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)zbir:(id)sender {
    
    
}

@synthesize usernamePolje;
@synthesize passPolje;
@synthesize hostPolje;
@synthesize portPolje;

- (IBAction)login:(id)sender {
    
    
}

@end
