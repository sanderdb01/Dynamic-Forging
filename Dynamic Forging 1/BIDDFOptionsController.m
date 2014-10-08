//
//  BIDDFOptionsController.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDDFOptionsController.h"
#import "BIDDFGeneratedController.h"

@interface BIDDFOptionsController ()

@end

@implementation BIDDFOptionsController
@synthesize locationSwitch;
@synthesize bodySwitch;
@synthesize diffLvlSwitch;
@synthesize location;
@synthesize targetArea;
@synthesize diffLvl;

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
    location = @"gym";
    targetArea = @"total";
    diffLvl = @"1";
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    //self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // This takes all the workouts in the default DF list and places it into a local array
    //open the plist file and place into NSURL
    NSArray *defaultWorkouts;
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"DFexercises" withExtension:@"plist"];
    //put the contents of the plist into a NSDictionary, and then into dfExercise instance variable
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    //take all the keys in the dictionary and make an array out of those key names
    defaultWorkouts = [dictionary allKeys];
    
    // If the workout settings file does not already exist, this creates it and sets all exercises to "on"
    //NSString *filePath = [self dataFilePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])      //checks to see if the plist does not exist
    {
        NSMutableDictionary *savedWorkout = [[NSMutableDictionary alloc]init];
        for (NSString *ex in defaultWorkouts)
        {
            NSDictionary *workout = [dictionary objectForKey : ex];
            NSMutableDictionary *settings = [[NSMutableDictionary alloc]init];
            if ([[workout objectForKey: @"location"]  isEqual: @"home"])
            {
                [settings setObject: @"on" forKey:@"home"];
                [settings setObject: @"on" forKey:@"gym"];
            }
            else
            {
                [settings setObject: @"off" forKey:@"home"];
                [settings setObject: @"on" forKey:@"gym"];
            }
            [settings setObject: [workout objectForKey:@"type"] forKey:@"type"];
            [savedWorkout setObject: settings forKey: ex];
        }
        [savedWorkout writeToFile:[self dataFilePath] atomically:YES];
    }
}

- (NSString *)dataFilePath  //Generates the path for the workout settings plist file
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"WorkoutSettings.plist"];
}

- (void)viewDidUnload
{
    [self setLocationSwitch:nil];
    [self setBodySwitch:nil];
    [self setDiffLvlSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonPressed:(id)sender {
}

- (IBAction)locationChoose:(id)sender {
    //0 == switch index
    //0 = gym, 1 = home
    if ([sender selectedSegmentIndex] == 0) {
        location = @"gym";
    }else {
        location = @"home";
    }
}

- (IBAction)bodyChoose:(id)sender {
    //0 = total, 1 = upper, 2 = lower
    if ([sender selectedSegmentIndex] == 0) {
        targetArea = @"total";
    }else if ([sender selectedSegmentIndex] == 1) {
        targetArea = @"upper";
    }else {
        targetArea = @"lower";
    }
}

- (IBAction)diffLvlChoose:(id)sender {
    //0 = diff 1, 1 = diff 2, 2 = diff 3, 3 = diff 4
    if ([sender selectedSegmentIndex] == 0) {
        diffLvl = @"1";
    }else if ([sender selectedSegmentIndex] == 1) {
        diffLvl = @"2";
    }else if ([sender selectedSegmentIndex] == 2) {
        diffLvl = @"3";
    }else {
        diffLvl = @"4";
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BIDDFGeneratedController *destination = segue.destinationViewController;
    /*
    if ([destination respondsToSelector:@selector(setDelegate:)]){
        [destination setValue:self forKey:@"delegate"];
    }
    if ([destination respondsToSelector:@selector(setSelection:)]){
        //prepare selection info
        [destination setValue:location forKey:@"location"];
        [destination setValue:targetArea forKey:@"targetArea"];
        [destination setValue:diffLvl forKey:@"diffLvl"];
    }
     */
    
    destination.location = self.location;
    destination.targetArea = self.targetArea;
    destination.diffLvl = self.diffLvl;
}
@end
