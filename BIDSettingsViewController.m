
//
//  BIDSettingsViewController.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 1/24/14.
//
//

#import "BIDSettingsViewController.h"
#import "BIDSettingDetailsViewController.h"

@interface BIDSettingsViewController ()

@end

@implementation BIDSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Builds the dictionary with all the workout settings
    NSString *filePath = [self dataFilePath];
    self.savedWorkoutsDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    self.defaultWorkouts = [[self.savedWorkoutsDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (NSString *)dataFilePath  //Generates the path for the workout settings plist file
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"WorkoutSettings.plist"];
}

- (void)setEditedSelection:(NSDictionary *)editedSelection
{
    //editedSelection = key:exercise object:name, key:settings object:settings
    [self.savedWorkoutsDictionary setObject:[editedSelection objectForKey:@"settings"] forKey:[editedSelection objectForKey:@"exercise"]];
    [self.savedWorkoutsDictionary writeToFile:[self dataFilePath] atomically:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.defaultWorkouts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.defaultWorkouts[indexPath.row];
    NSString *home = [[self.savedWorkoutsDictionary objectForKey: self.defaultWorkouts[indexPath.row]] objectForKey: @"home"];
    NSString *gym = [[self.savedWorkoutsDictionary objectForKey: self.defaultWorkouts[indexPath.row]] objectForKey:@"gym"];
    NSString *type = [[self.savedWorkoutsDictionary objectForKey: self.defaultWorkouts[indexPath.row]] objectForKey:@"type"];
    NSString *settings = [NSString stringWithFormat:@"Home: %@, Gym: %@, Type: %@", home, gym, type];
    cell.detailTextLabel.text = settings;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    BIDSettingDetailsViewController *destination = [segue destinationViewController];
    [destination setValue:self forKey:@"delegate"];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    destination.exerciseName = self.defaultWorkouts[indexPath.row];
    destination.homeChecked = [[self.savedWorkoutsDictionary objectForKey: self.defaultWorkouts[indexPath.row]] objectForKey: @"home"];
    destination.gymChecked = [[self.savedWorkoutsDictionary objectForKey: self.defaultWorkouts[indexPath.row]] objectForKey:@"gym"];
    
}


@end
