//
//  BIDDFGeneratedController.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDDFGeneratedController.h"
#import "BIDDFWorkout.h"

#define kFileName   @"SavedDFWorkouts.plist"

@interface BIDDFGeneratedController ()

@end

@implementation BIDDFGeneratedController
@synthesize resultsTextView;
@synthesize saveNameTextView;   //textview that has the name of the saved workout
@synthesize location;           //determines where the person is working out
@synthesize targetArea;         //which body part does the user want to focus on
@synthesize diffLvl;            //the difficulty level (1-4)
@synthesize delegate;
@synthesize results;        //holds the NSString result from the generated workout
@synthesize saveDetails;    //this will hold the NSDictionary details for the saved workout from BIDDFWorkout


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
    BIDDFWorkout *dfWorkout = [[BIDDFWorkout alloc]init];
    results = [dfWorkout generate:self.location :self.targetArea :self.diffLvl];
    if ([results isEqualToString: @""])
    {
        results = @"There is not enough active workouts in settings. \nPlease enable at least 6 non-cardio workouts";
    }
    resultsTextView.text = results;
    self.saveDetails = dfWorkout.detailsGenerated;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidUnload
{
    self.location = nil;
    self.targetArea = nil;
    self.diffLvl = nil;
    self.results = nil;
    self.saveDetails = nil;

    [self setResultsTextView:nil];
    [self setSaveNameTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

- (IBAction)buttonPressed:(id)sender {
    
    if ([saveNameTextView.text length] == 0) //name is not added to the textview for saving
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops =(" message:@"You need to enter a name for the workout" delegate:self cancelButtonTitle:@"OK, I'll add a name" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        //name is added for saving in the textview
        NSString *filePath = [self dataFilePath];
        
        //NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])      //checks to see if the plist already exists
        {
            NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
            if ([savedWorkout objectForKey:saveNameTextView.text]) { //if the name already exists, alert the user to change it
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops =(" message:@"Name is already taken, please choose another" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            else
            {  //save the workout
                [savedWorkout setObject:self.saveDetails forKey:saveNameTextView.text];
                [savedWorkout writeToFile:[self dataFilePath] atomically:YES];
                NSString* saveConfirm = [[NSString alloc] initWithFormat:@"%@ has been saved",saveNameTextView.text];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Complete" message:saveConfirm delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }//end if
        }
        else
        {  //if the plist does not already exist
            NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]init];
            [savedWorkout setObject:self.saveDetails forKey:saveNameTextView.text];
            [savedWorkout writeToFile:[self dataFilePath] atomically:YES];
            NSString* saveConfirm = [[NSString alloc] initWithFormat:@"%@ has been saved",saveNameTextView.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Complete" message:saveConfirm delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }//end if
}

//moves screen back to orignal position when user is done with the keyboard
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

//moves the screen up to make room for the keyboard
- (IBAction) textFieldStartEditing:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = -150;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    NSString *filePath = [self dataFilePath];
    NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    for (int inc = 0; inc<=[savedWorkout count]; inc++){
        //NSString *key =[[NSString alloc] initWithFormat:@"DFGWorkout %d",inc + 1];
        NSString *key = [[NSString alloc] initWithFormat:@"%@", [self nameGenerator]];
        if (![savedWorkout valueForKey:key]){
            saveNameTextView.text = key;
        }//end if
    }//end for
    
    //this code should highlight the text for the user to replace is they want to, but it is not working. play with later 
    //[saveNameTextView selectAll:self];
    //[UIMenuController sharedMenuController].menuVisible = NO;
}

- (NSString *)nameGenerator{
    //open the plist file and place into NSURL
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"DFGNames" withExtension:@"plist"];

    //put the contents of the plist into a NSDictionary, and then into dfExercise instance variable
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    NSArray *adj = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"adj"]];
    NSArray *noun = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"noun"]];
    NSInteger randAdj = arc4random()%[adj count];
    NSInteger randNoun = arc4random()%[noun count];
    NSString *name = [[NSString alloc] initWithFormat:@"%@ %@", [adj objectAtIndex:randAdj], [noun objectAtIndex:randNoun]];
    return name;

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BIDDFGeneratedController *destination = segue.destinationViewController;
    
    destination.results = self.results;
}
@end
