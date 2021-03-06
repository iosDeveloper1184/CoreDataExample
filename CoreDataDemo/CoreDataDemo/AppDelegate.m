//
//  AppDelegate.m
//  CoreDataDemo
//
//  Created by QMCPL_MAC2 on 22/04/15.
//  Copyright (c) 2015 qmcpl. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "Manager.h"
#import "Employee.h"
@interface AppDelegate ()
{
    Manager  *manager;
    Employee *employee;
}
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *fname =@"Sanjay ";
    NSString *lname = @"Shukla";
    int age =35;
    
    
   NSArray *managerData = [manager.employees allObjects];
    NSLog(@"%@",managerData);
    //employee.manager =manager;
    
    [self createNewManagerWithParamFirstName:fname LastName:lname Age:age];
    
    [self createNewEmployeesWithParamFirstName:@"rajesh" LastName:@"Sinha" Age:28];
     [self createNewEmployeesWithParamFirstName:@"akhilesh " LastName:@"Shah" Age:25];
     [self createNewEmployeesWithParamFirstName:@"Nikita" LastName:@"Rathod" Age:26];
////    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
////    NSSortDescriptor *agesortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES];
////    NSSortDescriptor *fNamesortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"fName" ascending:YES];
////    fetchReq.sortDescriptors = @[fNamesortDescriptor,agesortDescriptor];
////    
////    NSError *FetchError;
////    NSArray *persons  = [self.managedObjectContext executeFetchRequest:fetchReq error:&FetchError];
////    if (persons.count > 0 )
////    {
////        Person *person = [persons firstObject];
////        
////         
//////        [self.managedObjectContext deleteObject:person];
//////      //  NSError *error = nil;
//////        if ([person isDeleted])
//////        {
//////            NSLog(@"Deleted succesfully");
//////            NSError * errorForSaving = nil;
//////            if ([self.managedObjectContext save:&errorForSaving])
//////            {
//////                NSLog(@"Data saved succesfully");
//////            }
//////            else
//////            {
//////                NSLog(@"%@",errorForSaving);
//////            }
//////        }
//////        else{
//////            NSLog( @"Not deleted");
//////        }
////        for(Person *data in persons){
////            NSLog(@"First Name = %@", data.fName);
////            NSLog(@"Last Name = %@", data.lName);
////            NSLog(@"Age = %lu", (unsigned long)[data.age unsignedIntegerValue]);
////            
////        }
//    }
    
                                
    
    
    
       return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
   // [self saveContext];
}

-(BOOL)createNewManagerWithParamFirstName:(NSString *)firstname LastName:(NSString *)lastname Age:(int)age
{
    BOOL result = NO;
    if (firstname.length == 0 || lastname.length == 0 || age == 0) {
        NSLog(@"Entity should not be blank");
        return  result ;
    }
    else
    {
        
      manager   = [ NSEntityDescription insertNewObjectForEntityForName:@"Manager" inManagedObjectContext:self.managedObjectContext];
        manager.firstName = firstname;
        manager.lastName =lastname  ;
        manager.age = [NSNumber numberWithInt:age
                       ];
        NSError *savingError;
        if (manager != nil)
        {
            if([self.managedObjectContext save:&savingError])
            {
                NSLog(@"Data Save Successfully");
                
            }
            else {
                NSLog(@"%@",savingError);
            }
            result = YES;
        }
        else {
            NSLog(@"Entity is nil");
        }
    }
    return result;
}


-(BOOL)createNewEmployeesWithParamFirstName:(NSString *)firstname LastName:(NSString *)lastname Age:(int)age
{
    BOOL result = NO;
    if (firstname.length == 0 || lastname.length == 0 || age == 0) {
        NSLog(@"Entity should not be blank");
        return  result ;
    }
    else
    {
        
   employee      = [ NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.managedObjectContext];
        employee.firstName = firstname;
        employee.lastName =lastname  ;
        employee.age = [NSNumber numberWithInt:age
                       ];
        [manager addEmployeesObject:employee];
        NSArray *array = [manager.employees allObjects];
        NSLog(@"Final Data %@",array);
        NSError *savingError;
        if (employee != nil)
        {
            if([self.managedObjectContext save:&savingError])
            {
                NSLog(@"Data Save Successfully");
                
            }
            else {
                NSLog(@"%@",savingError);
            }
            result = YES;
        }
        else {
            NSLog(@"Entity is nil");
        }
    }
    return result;
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.qmcpl.CoreDataDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}








@end
