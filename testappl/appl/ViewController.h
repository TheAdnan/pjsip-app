//
//  ViewController.h
//  appl
//
//  Created by Reuf Kicin on 10/22/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernamePolje;
@property (weak, nonatomic) IBOutlet UITextField *passPolje;
@property (weak, nonatomic) IBOutlet UITextField *hostPolje;

@property (weak, nonatomic) IBOutlet UITextField *portPolje;
@property (weak, nonatomic) IBOutlet UILabel *ErrorMsg;

@end

@interface user : NSObject

@property NSString *username;
@property NSString *pass;
@property NSString *host;
@property int port;

@end

