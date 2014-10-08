//
//  BIDDFWTimerView.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/5/12.
//
//

#import "BIDDFWTimerView.h"

@interface BIDDFWTimerView ()

@end

@implementation BIDDFWTimerView
@synthesize workoutDetails;
@synthesize timerLabel;
@synthesize results;
@synthesize startButton;
@synthesize stopButton;
@synthesize resetButton;
@synthesize countdownLabel;

NSTimer *stopWatchTimer;
NSDate *startDate;
NSDate *saveDate;
NSTimeInterval pauseTimerInt = 0;
NSTimeInterval pauseTimerIntTemp = 0;
int pauseTimer = 0;
NSString *timeLabelString;
NSTimer *countdownTimer;
int countdownInt = 4;   //one digit higher to allow for "GO" message to appear

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
    self.workoutDetails.text = results;
}

- (void)viewDidUnload
{
    [self setWorkoutDetails:nil];
    [self setTimerLabel:nil];
    [self setStartButton:nil];
    [self setStopButton:nil];
    [self setResetButton:nil];
    [self setCountdownLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateTimer{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval+pauseTimerInt];
    pauseTimerIntTemp = timeInterval + pauseTimerInt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    timerLabel.text = timeString;

}

- (void)updateTimerCountdown{   //tiemr for the countdown in the background
    NSString *countdownString = [NSString stringWithFormat:@"%d",countdownInt - 1];
    self.countdownLabel.text = countdownString;
    
    if (countdownInt == 1) {
        //Creates the stop watch timer that fires every 10 ms
        startDate = [NSDate date];
        
        self.countdownLabel.text = @"GO!";
        self.startButton.hidden = TRUE;
        self.stopButton.hidden = FALSE;
    }
    if (countdownInt == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        self.countdownLabel.hidden = TRUE;
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    
    countdownInt = countdownInt - 1;
    
}

- (IBAction)startButtonPressed:(id)sender {
    if ( countdownInt > 0){
        self.countdownLabel.text = @"READY?";
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimerCountdown) userInfo:nil repeats:YES];
        self.countdownLabel.hidden = FALSE;
    }
    if (countdownInt == 0) {
        
        //Creates the stop watch timer that fires every 10 ms
        startDate = [NSDate date];
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        self.startButton.hidden = TRUE;
        self.stopButton.hidden = FALSE;
    }
    
}

- (IBAction)stopButtonPressed:(id)sender {
    pauseTimer = 1;
    pauseTimerInt = pauseTimerIntTemp;
    [stopWatchTimer invalidate];
    stopWatchTimer = nil;
    self.stopButton.hidden = TRUE;
    self.startButton.hidden = FALSE;
}

- (IBAction)resetButtonPressed:(id)sender {
    pauseTimerInt = 0;
    pauseTimerIntTemp = 0;
    [stopWatchTimer invalidate];
    stopWatchTimer = nil;
    pauseTimer = FALSE;
    [self updateTimer];
    timerLabel.text = @"00:00:00.0";
    self.startButton.hidden = FALSE;
    self.stopButton.hidden = TRUE;
    countdownInt = 4;
}


@end
