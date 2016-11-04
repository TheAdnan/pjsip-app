//
//  CallScreenViewController.m
//  appl
//
//  Created by Reuf Kicin on 10/31/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import "CallScreenViewController.h"


#import "pjsip-include/pjsua.h"
#import "pjsip-include/pjsip.h"
#import "pjsip-include/pjnath.h"
#import "pjsip-include/pjlib.h"
#import "pjsip-include/pjmedia.h"
#import "pjsip-include/pjsip_ua.h"
#import "pjsip-include/pjlib-util.h"



#pragma mark pjsip static functions prototypes

static void on_incoming_call(pjsua_acc_id accountID, pjsua_call_id callID, pjsip_rx_data *rdata);
static void on_call_state(pjsua_call_id callID, pjsip_event *event);
static void on_reg_state2(pjsua_acc_id accountID, pjsua_reg_info *info);
static void on_call_media_state(pjsua_call_id callID);
static void error_exit1(const char *msg, pj_status_t stat);



#pragma PJ interface and implementation

@interface PJ ()
@end

@implementation PJ{
    pjsua_acc_id accountID;
    RegisterCallBack callBack;
    
    
}


//init
+ (PJ *)sharedPJ{
    static PJ *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PJ alloc] init];
    });
    
    return instance;
    
}


//Hang up call
- (void)endCall{
    pjsua_call_hangup_all();
      NSLog(@"radi");
    
}


//Make a call
- (void)makeCall:(char*)uri
{
    
    pj_status_t status;
    pj_str_t uriX = pj_str(uri);
    
    status = pjsua_call_make_call(accountID, &uriX, 0, NULL, NULL, NULL);
    if(status != PJ_SUCCESS) error_exit1("Error occurred while making a call", status);
      NSLog(@"radi");
    
}

//starting pjsip and register on server
- (int)startPjsipAndRegisterOnServer:(char *) domain
                        withUserName:(char *) username andPassword:(char *) pass callback:(RegisterCallBack) callback{
    
    
    pj_status_t status;
    NSLog(@"radi");
    status = pjsua_create();
    if(status != PJ_SUCCESS) error_exit1("Error", status);
    
    {
        pjsua_config cf;
        pjsua_config_default(&cf);
        
        cf.cb.on_incoming_call = &on_incoming_call;
        cf.cb.on_call_state = &on_call_state;
        cf.cb.on_call_media_state = &on_call_media_state;
        cf.cb.on_reg_state2 = &on_reg_state2;
        
        pjsua_logging_config log_cfg;
        pjsua_logging_config_default(&log_cfg);
        log_cfg.console_level = 4;
        
        
        status = pjsua_init(&cf, &log_cfg, NULL);
        
        if(status != PJ_SUCCESS) error_exit1("Error in init", status);
        
    }
    
    
    //UDP and TCP
    {
        
        pjsua_transport_config cfg;
        pjsua_transport_config_default(&cfg);
        cfg.port = [[[NSUserDefaults standardUserDefaults] objectForKey:@"port"] intValue];
        
        status = pjsua_transport_create(PJSIP_TRANSPORT_UDP, &cfg, NULL);
        if(status != PJ_SUCCESS) error_exit1("Error in creating transport", status);
        
        status = pjsua_transport_create(PJSIP_TRANSPORT_TCP, &cfg, NULL);
        if(status != PJ_SUCCESS) error_exit1("Error in creating transport", status);
        
    }
    
    status = pjsua_start();
    if(status != PJ_SUCCESS) error_exit1("Error in startiing pjsua", status);
    
    {
        pjsua_acc_config cfg;
        pjsua_acc_config_default(&cfg);
        
        char sipID[50];
        sprintf(sipID, "sip:%s@%s", username, domain);
        cfg.id = pj_str(sipID);
        
        
        //register uri
        
        char regURI[50];
        sprintf(regURI, "sip:%s", domain);
        cfg.reg_uri = pj_str(regURI);
        
        cfg.cred_count = 1;
        cfg.cred_info[0].scheme = pj_str("digest");
        cfg.cred_info[0].realm = pj_str(domain);
        cfg.cred_info[0].username = pj_str(username);
        cfg.cred_info[0].data_type = PJSIP_CRED_DATA_PLAIN_PASSWD;
        cfg.cred_info[0].data = pj_str("Adnanekiga1");
        
        status = pjsua_acc_add(&cfg, PJ_TRUE, &accountID);
        if(status != PJ_SUCCESS) error_exit1("Error adding account", status);
        else if(status == PJ_SUCCESS) error_exit1("radi", status);
    }
    
    callBack = callback;
    
    return 0;
}


- (void)handleRegistrationStateChangeWithRegInfo: (pjsua_reg_info *) info
{
    switch(info->cbparam->code){
        case 200:
            callBack(YES);
            break;
        case 401:
            callBack(NO);
            break;
        default: break;
    }
    
}

@end

#pragma mark CallScreenViewController interface and implementation

@interface CallScreenViewController ()

@end

@implementation CallScreenViewController

PJ *pjcall;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Loading the user data
    
    NSUserDefaults *userdata = [NSUserDefaults standardUserDefaults];
    NSString *username = [userdata objectForKey:@"username"];
    _CalleeNumber.text = [userdata objectForKey:@"calleeid"];
    NSString *pass = [userdata objectForKey:@"pass"];
    NSString *host = [userdata objectForKey:@"host"];
    NSString *port = [userdata objectForKey:@"port"];
    
    
    //Registration of pjsip
   [pjcall startPjsipAndRegisterOnServer:[host UTF8String] withUserName:[username UTF8String] andPassword:[pass UTF8String] callback:^(BOOL success){
       [self loginComplete:success];
    }];
    
    //Identifying callee name
    if([_CalleeNumber.text isEqualToString:@"500@ekiga.net"]){
        _CalleeName.text = @"Echo";
    }
    else if([_CalleeNumber.text isEqualToString:@"5011121@ekiga.net"]){
        _CalleeName.text = @"Public conference room";
    }
    else{
        _CalleeName.text = @"Unknown";
    }
    
    
    //pjsip make a call
    [pjcall makeCall:[_CalleeNumber.text UTF8String]];
    
    
    
   /*UIAlertController* poruka = [UIAlertController alertControllerWithTitle:@"Greska" message:[NSString stringWithUTF8String:"poruka"] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    
    [self presentViewController:poruka animated:YES completion:nil];
    */

    
    
}

- (void)loginComplete:(BOOL)success{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)HangUp:(id)sender {
    //ending call and segue back to ContactScreen
    [self performSegueWithIdentifier:@"HangUp" sender:self];
    [pjcall endCall];
}


@end





#pragma mark static functions implementation

static void on_incoming_call(pjsua_acc_id accountID, pjsua_call_id callID, pjsip_rx_data *rdata)
{
    pjsua_call_info inf;
    
    PJ_UNUSED_ARG(accountID);
    PJ_UNUSED_ARG(rdata);
    
    pjsua_call_get_info(callID, &inf);
    PJ_LOG(3, ("pj.c", "Incoming call from %.*s", (int)inf.remote_info.slen, inf.remote_info.ptr));
    
    pjsua_call_answer(callID, 200, NULL, NULL);
    
}



static void on_call_state(pjsua_call_id callID, pjsip_event *event)
{
    pjsua_call_info inf;
    PJ_UNUSED_ARG(event);
    pjsua_call_get_info(callID, &inf);
    PJ_LOG(3, ("pj.c", "Call %d state = %.*s", (int)inf.remote_info.slen, inf.remote_info.ptr));
    
    
}


static void on_reg_state2(pjsua_acc_id accountID, pjsua_reg_info *info){
    [[PJ sharedPJ] handleRegistrationStateChangeWithRegInfo: info];
    
}


static void on_call_media_state(pjsua_call_id callID){
    pjsua_call_info info;
    
    pjsua_call_get_info(callID, &info);
    
    if(info.media_status == PJSUA_CALL_MEDIA_ACTIVE){
        pjsua_conf_connect(info.conf_slot, 0);
        pjsua_conf_connect(0, info.conf_slot);
    }
}
static void error_exit1(const char *msg, pj_status_t stat){

    
  UIAlertView *poruka = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithUTF8String:msg] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [poruka show];
   
   
    pjsua_perror("pj.c", msg, stat);
    pjsua_destroy();
    exit(1);
}





