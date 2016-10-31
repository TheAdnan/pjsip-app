//
//  ContactsScreenViewController.m
//  appl
//
//  Created by Reuf Kicin on 10/30/16.
//  Copyright © 2016 Kicin. All rights reserved.
//

#import "ContactsScreenViewController.h"

@interface ContactsScreenViewController ()

@end

@implementation ContactsScreenViewController

//NSArray *podaci;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // podaci = [NSArray arrayWithObjects:@"Adnan Kicin", @"Esed Alihodzic", nil];
    // Do any additional setup after loading the view.
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [podaci count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kontakti = @"item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kontakti];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kontakti];
    
    }
    
    cell.textLabel.text = [podaci objectAtIndex:indexPath.row];
    return cell;
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ExitApp:(id)sender {
    exit(0);
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
