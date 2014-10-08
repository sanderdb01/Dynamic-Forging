//
//  BIDWODList.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDWODList.h"
#import "BIDWODDetails.h"

#define kFileName   @"SavedDFWorkouts.plist"

@interface BIDWODList ()

@end

@implementation BIDWODList
@synthesize names;
@synthesize savedNames;
@synthesize keys;
@synthesize details;
@synthesize wodType;
@synthesize benchmarkGirls;
@synthesize theNewGirls;
@synthesize heroes;
@synthesize savedDFGWorkouts;
@synthesize chosenWOD;
@synthesize chosenDetails;

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
    /*
    NSMutableArray *buildBenchmarkGirls = [[NSMutableArray alloc] init];
    NSMutableArray *buildTheNewGirls = [[NSMutableArray alloc] init];
    NSMutableArray *buildHeroes = [[NSMutableArray alloc] init];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"CrossfitWOD" withExtension:@"plist"];
    //put the contents of the plist into a NSDictionary, and then into names instance variable
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    self.names = dictionary;
    //take all the keys in the dictionary and make an array out of those key names
    self.keys = [self.names allKeys];
    
    for (NSString *nameCheck in keys){
        self.details = [names valueForKey:nameCheck];
        if ([[self.details valueForKey:@"Type"] isEqualToString:@"The Benchmark Girls"]) {
            [buildBenchmarkGirls addObject:nameCheck];
        }else if ([[self.details valueForKey:@"Type"] isEqualToString:@"The New Girls"]) {
            [buildTheNewGirls addObject:nameCheck];
        }else {
            [buildHeroes addObject:nameCheck];
        }
    }
    
    NSString *filePath = [self dataFilePath];
    NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    self.savedNames = savedWorkout;
    self.savedDFGWorkouts = [[savedWorkout allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.benchmarkGirls = [buildBenchmarkGirls sortedArrayUsingSelector:@selector(compare:)];
    self.theNewGirls = [buildTheNewGirls sortedArrayUsingSelector:@selector(compare:)];
    self.heroes = [buildHeroes sortedArrayUsingSelector:@selector(compare:)];
     */
    //[[self tableView] reloadData];  //reloads the data in case a DFG workout was saved
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.names = nil;
    self.keys = nil;
    self.benchmarkGirls = nil;
    self.theNewGirls = nil;;
    self.heroes = nil;
    self.details = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *)dataFilePath {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

-(void)viewDidAppear:(BOOL)animated{
    NSMutableArray *buildBenchmarkGirls = [[NSMutableArray alloc] init];
    NSMutableArray *buildTheNewGirls = [[NSMutableArray alloc] init];
    NSMutableArray *buildHeroes = [[NSMutableArray alloc] init];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"CrossfitWOD" withExtension:@"plist"];
    //put the contents of the plist into a NSDictionary, and then into names instance variable
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    self.names = dictionary;
    //take all the keys in the dictionary and make an array out of those key names
    self.keys = [self.names allKeys];
    
    for (NSString *nameCheck in keys){
        self.details = [names valueForKey:nameCheck];
        if ([[self.details valueForKey:@"Type"] isEqualToString:@"The Benchmark Girls"]) {
            [buildBenchmarkGirls addObject:nameCheck];
        }else if ([[self.details valueForKey:@"Type"] isEqualToString:@"The New Girls"]) {
            [buildTheNewGirls addObject:nameCheck];
        }else {
            [buildHeroes addObject:nameCheck];
        }
    }
    
    NSString *filePath = [self dataFilePath];
    NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    self.savedNames = savedWorkout;
    self.savedDFGWorkouts = [[savedWorkout allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.benchmarkGirls = [buildBenchmarkGirls sortedArrayUsingSelector:@selector(compare:)];
    self.theNewGirls = [buildTheNewGirls sortedArrayUsingSelector:@selector(compare:)];
    self.heroes = [buildHeroes sortedArrayUsingSelector:@selector(compare:)];
    [[self tableView] reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [benchmarkGirls count];
    }else if (section == 1){
        return [theNewGirls count];
    }else if (section == 2){
        return [heroes count];
    }else{
        return [savedDFGWorkouts count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier];
    }
    
    if (section == 0) {
        cell.textLabel.text = [benchmarkGirls objectAtIndex:row];
    }else if (section == 1) {
        cell.textLabel.text = [theNewGirls objectAtIndex:row];
    }else if (section == 2) {
        cell.textLabel.text = [heroes objectAtIndex:row];
    }else{
        cell.textLabel.text = [savedDFGWorkouts objectAtIndex:row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @" The Benchmark Girls";
    }else if (section == 1){
        return @"The New Girls";
    }else if (section == 2){
        return @"The Heroes";
    }else{
        return @"Saved DFG Workouts";
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];

    if (editingStyle == UITableViewCellEditingStyleDelete && section == 3) {
        // Delete the row from the data source
        NSString *filePath = [self dataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]){
            
            NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
            [savedWorkout removeObjectForKey:[savedDFGWorkouts objectAtIndex:row]];
            [savedWorkout writeToFile:[self dataFilePath] atomically:YES];
            
            NSString* saveConfirm = [[NSString alloc] initWithFormat:@"%@ has been deleted",[savedDFGWorkouts objectAtIndex:row]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Complete" message:saveConfirm delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            self.savedDFGWorkouts = [[savedWorkout allKeys] sortedArrayUsingSelector:@selector(compare:)];  //have to resave "self.saveDFGWorkouts" so that when the numberOfRows method is called, the correct number will be used. Otherwise an error will pop up
            [alert show];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }else{
        NSString* deleteError = [[NSString alloc] initWithFormat:@"Only DF Generated workouts can be deleted"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Error" message:deleteError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BIDWODDetails *destination = segue.destinationViewController;
    /*
     if ([destination respondsToSelector:@selector(setDelegate:)]){
     [destination setValue:self forKey:@"delegate"];
     }
     if ([destination respondsToSelector:@selector(setSelection:)]){
         test = 2;
     //prepare selection info
         NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
         NSUInteger section = [indexPath section];
         NSUInteger row = [indexPath row];
         if (section == 0) {
             self.chosenWOD = [self.benchmarkGirls objectAtIndex:row];
         }else if (section == 1) {
             self.chosenWOD = [self.theNewGirls objectAtIndex:row];
         }else {
             self.chosenWOD = [self.heroes objectAtIndex:row];
         }  //end if
     }  //end if
     */
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    if (section == 0) {
        self.chosenWOD = [self.benchmarkGirls objectAtIndex:row];
        self.chosenDetails = [names objectForKey:chosenWOD];
    }else if (section == 1) {
        self.chosenWOD = [self.theNewGirls objectAtIndex:row];
        self.chosenDetails = [names objectForKey:chosenWOD];
    }else if (section ==2) {
        self.chosenWOD = [self.heroes objectAtIndex:row];
        self.chosenDetails = [names objectForKey:chosenWOD];
    }else {
        self.chosenWOD = [self.savedDFGWorkouts objectAtIndex:row];
        self.chosenDetails = [savedNames objectForKey:chosenWOD];
    }//end if
    
    //self.chosenDetails = [names objectForKey:chosenWOD];
    //[destination setValue:chosenWOD forKey:@"chosenWOD"];
    //[destination setValue:chosenDetails forKey:@"chosenDetails"];
    destination.chosenWOD = self.chosenWOD;
    destination.chosenDetails = self.chosenDetails;
}

@end
