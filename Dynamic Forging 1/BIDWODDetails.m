//
//  BIDWODDetails.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 8/14/12.
//
//

#import "BIDWODDetails.h"

@interface BIDWODDetails ()

@end

@implementation BIDWODDetails
@synthesize wodLabel;
@synthesize wodTextView;
@synthesize chosenWOD;
@synthesize chosenDetails;

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
    NSMutableString *wodDetailsString = [[NSMutableString alloc]init];
    NSMutableString *line = [[NSMutableString alloc] init];
    for (int inc = 0; inc < [self.chosenDetails count] - 3; inc++) {
        line = [NSString stringWithFormat:@"%d",inc + 1];
        [wodDetailsString appendFormat:@"%@ \n",[self.chosenDetails valueForKey:line]];
    }
    [wodDetailsString appendFormat:@"\nNotes: %@ \n",[self.chosenDetails valueForKey:@"Notes"]];
    wodLabel.text = chosenWOD;
    wodTextView.text = wodDetailsString;
}

- (void)viewDidUnload
{
    [self setWodLabel:nil];
    [self setWodTextView:nil];
    self.chosenDetails = nil;
    self.chosenWOD = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BIDWODDetails *destination = segue.destinationViewController;
    destination.chosenWOD = self.chosenWOD;
    destination.chosenDetails = self.chosenDetails;

}
@end
