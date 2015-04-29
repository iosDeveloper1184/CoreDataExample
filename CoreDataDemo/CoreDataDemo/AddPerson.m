//
//  AddPerson.m
//  CoreDataDemo
//
//  Created by QMCPL_MAC2 on 24/04/15.
//  Copyright (c) 2015 qmcpl. All rights reserved.
//

#import "AddPerson.h"
#import "personTableViewController.h"
#import "Person.h"
#import "AppDelegate.h"
@interface AddPerson ()

@end

@implementation AddPerson

-(NSManagedObjectContext
  *)manageObject {
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    return app.managedObjectContext;
    
}

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

- (IBAction)submitAction:(UIButton *)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext =
    appDelegate.managedObjectContext;
    
    Person *newPerson =
    [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                  inManagedObjectContext:[self manageObject]];
    
    if (newPerson != nil)
    {
        
        newPerson.fName = self.txtfName.text;
        newPerson.lName = self.txtlName.text;
        newPerson.age = @([self.txtAge.text integerValue]);
        
        NSError *savingError = nil;
        
        if ([[self manageObject] save:&savingError]){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"Failed to save the managed object context.");
        }
        
    } else {
        NSLog(@"Failed to create the new person object.");
    }
    
}
@end
