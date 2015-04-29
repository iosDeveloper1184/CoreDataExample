//
//  personTableViewController.m
//  CoreDataDemo
//
//  Created by QMCPL_MAC2 on 23/04/15.
//  Copyright (c) 2015 qmcpl. All rights reserved.
//

#import "personTableViewController.h"
#import "AppDelegate.h"
#import "Employee.h"
static NSString *PersonTableViewCell = @"PersonTableViewCell";

@interface personTableViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)UIBarButtonItem *barButtonAddPerson;
@property(nonatomic,strong)NSFetchedResultsController *frc ;

@end

@implementation personTableViewController






- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Employee";
    
    self.barButtonAddPerson =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
     target:self
     action:@selector(addNewPerson:)];
    
    [self.navigationItem setLeftBarButtonItem:self.editButtonItem
                                     animated:NO];
    [self.navigationItem setRightBarButtonItem:self.barButtonAddPerson
                                      animated:NO];
    
    NSFetchRequest  *fetchReq = [[NSFetchRequest alloc]initWithEntityName:@"Employee"];
    NSSortDescriptor *ageSort = [[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES
                                 ];
//    NSSortDescriptor *firstNameSOrt =[[NSSortDescriptor alloc]initWithKey:@"fName" ascending:YES
//                                      ];
    fetchReq.sortDescriptors =@[ageSort];
    self.frc = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchReq managedObjectContext:[self manageObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate =self;
    NSError *fetchingError =nil;
    if([self.frc performFetch:&fetchingError]){
        NSLog(@"Fetching success");
    }
    else {
        NSLog(@"Fetching unsucess");
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
   // [self.tableView beginUpdates];
}




-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    if(type == NSFetchedResultsChangeDelete){
        [self.tableView deleteRowsAtIndexPaths:@[indexPath  ] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if(type == NSFetchedResultsChangeInsert)   {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonTableViewCell forIndexPath:indexPath];
    Employee *person = [self.frc objectAtIndexPath:indexPath];
    
    cell.textLabel.text =[person.firstName stringByAppendingString:[NSString stringWithFormat:@"%@", person.lastName]];
    
    
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",person.age];
    
   //  Configure the cell...
    
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
   return UITableViewCellEditingStyleDelete;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
    Employee *person = [self.frc objectAtIndexPath:indexPath];
    [[self manageObjectContext] deleteObject:person];
    if([person isDeleted]){
        NSError *error=nil;
        if([[self manageObjectContext]save:&error]){
            NSLog(@"Data deleted succesffully");
        }
        else{
            NSLog(@"Error %@",error);
        }
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) addNewPerson:(id)paramSender{
    
    [self performSegueWithIdentifier:@"addPerson" sender:self];
//    [self insertNewDataWithfirstName:@"Ashvini" lastName:@"Gulve" age:24];
//    [self insertNewDataWithfirstName:@"Priyank" lastName:@"Gulve" age:27];
//    NSError *errorFetch = nil;
//    if ([self.frc performFetch:&errorFetch]) {
//        NSLog(@"Success");
//    }
//    else {
//        NSLog(@"Error");
//    }
//    [self.tableView reloadData];
}

-(void)insertNewDataWithfirstName:(NSString *)fName lastName:(NSString *)lName age:(int )age
{
//    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:[self manageObjectContext]];
//    person.fName = fName;
//    person.lName = lName;
//    person.age=[NSNumber numberWithInt:age];
//    NSError *error;
//    if([[self manageObjectContext]save:&error]){
//        NSLog(@"Succefully inserted");
//    }
//    else {
//        NSLog(@"%@",error);
//    }
}
                      
                      
-(NSManagedObjectContext *)manageObjectContext {
                          
                          AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
                          return appDelegate.managedObjectContext;
}

@end
