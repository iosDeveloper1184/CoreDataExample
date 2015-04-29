//
//  AddPerson.h
//  CoreDataDemo
//
//  Created by QMCPL_MAC2 on 24/04/15.
//  Copyright (c) 2015 qmcpl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPerson : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UITextField *txtfName;
@property (weak, nonatomic) IBOutlet UITextField *txtlName;
- (IBAction)submitAction:(UIButton *)sender;

@end
