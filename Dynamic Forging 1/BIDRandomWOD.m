//
//  BIDRandomWOD.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/7/12.
//
//

#import "BIDRandomWOD.h"

@interface BIDRandomWOD ()

@end

@implementation BIDRandomWOD
@synthesize wodNameLabel;
@synthesize wodDetailsTextView;
@synthesize wodExercises;
@synthesize wodList;
@synthesize chosenDetails;
@synthesize chosenWOD;


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
    //open the plist file and place into NSURL
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"CrossfitWOD" withExtension:@"plist"];
    
    //put the contents of the plist into a NSDictionary, and then into dfExercise instance variable
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    self.wodExercises = dictionary;
    
    //take all the keys in the dictionary and make an array out of those key names
    self.wodList = [self.wodExercises allKeys];
    //wodDetailsTextView.textAlignment = UITextAlignmentCenter;
    //[wodDetailsTextView setFont:[UIFont systemFontOfSize:60.0]];

}

- (void)viewDidUnload
{
    [self setWodNameLabel:nil];
    [self setWodDetailsTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewDidAppear:(BOOL)animated{
    wodDetailsTextView.textAlignment = UITextAlignmentCenter;
    [wodDetailsTextView setFont:[UIFont systemFontOfSize:200.0]];
    wodDetailsTextView.text = @"?";
    wodNameLabel.textAlignment = UITextAlignmentCenter;
    wodNameLabel.text = @"?";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)randomButtonPress:(id)sender {
    wodDetailsTextView.textAlignment = UITextAlignmentLeft;
    [wodDetailsTextView setFont:[UIFont systemFontOfSize:20.0]];
    int choose = arc4random()%[wodList count];
    NSMutableString *wodDetailsString = [[NSMutableString alloc]init];
    NSMutableString *line = [[NSMutableString alloc] init];
    NSMutableDictionary *chosenDetailsTemp = [[NSMutableDictionary alloc] initWithDictionary:[wodExercises objectForKey:[wodList objectAtIndex:choose]] copyItems:YES];
    for (int inc = 0; inc < [chosenDetailsTemp count] - 3; inc++) {
        line = [NSString stringWithFormat:@"%d",inc + 1];
        [wodDetailsString appendFormat:@"%@ \n",[chosenDetailsTemp valueForKey:line]];
    }
    [wodDetailsString appendFormat:@"\nNotes: %@ \n",[chosenDetailsTemp valueForKey:@"Notes"]];
    wodNameLabel.text = [wodList objectAtIndex:choose];
    wodDetailsTextView.text = wodDetailsString;
    self.chosenDetails = chosenDetailsTemp;
    self.chosenWOD = [wodList objectAtIndex:choose];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BIDRandomWOD *destination = segue.destinationViewController;
    
    destination.chosenWOD = self.chosenWOD;
    destination.chosenDetails = self.chosenDetails;
}

@end
