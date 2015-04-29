//
//  Employee.h
//  CoreDataDemo
//
//  Created by QMCPL_MAC2 on 27/04/15.
//  Copyright (c) 2015 qmcpl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Manager;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSSet *manager;
@end

@interface Employee (CoreDataGeneratedAccessors)

- (void)addManagerObject:(Manager *)value;
- (void)removeManagerObject:(Manager *)value;
- (void)addManager:(NSSet *)values;
- (void)removeManager:(NSSet *)values;

@end
