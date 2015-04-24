//
//  Person.h
//  CoreDataDemo
//
//  Created by QMCPL_MAC2 on 22/04/15.
//  Copyright (c) 2015 qmcpl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * fName;
@property (nonatomic, retain) NSString * lName;
@property (nonatomic, retain) NSNumber * age;

@end
