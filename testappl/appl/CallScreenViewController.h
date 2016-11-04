//
//  CallScreenViewController.h
//  appl
//
//  Created by Reuf Kicin on 10/31/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsScreenViewController.h"
#import <Foundation/Foundation.h>



@interface PJ : NSObject

typedef void (^RegisterCallBack)(BOOL success);

+ (PJ *)sharedPJ;

- (int)startPjsipAndRegisterOnServer:(char *) domain
                        withUserName:(char *) username andPassword:(char *) pass callback:(RegisterCallBack) callback;

-(void)makeCall:(char*)uri;

-(void)endCall;

@end


@interface CallScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *CalleeNumber;



@end
