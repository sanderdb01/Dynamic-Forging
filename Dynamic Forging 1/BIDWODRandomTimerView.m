//
//  BIDWODRandomTimerView.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/9/12.
//
//

#import "BIDWODRandomTimerView.h"

@interface BIDWODRandomTimerView ()

@end

@implementation BIDWODRandomTimerView
@synthesize wodNameLabel;
@synthesize wodDetailsTextView;
@synthesize timerLabel;
@synthesize startButton;
@synthesize stopButton;
@synthesize restartButton;
@synthesize chosenDetails;
@synthesize countdownLabel;
@synthesize chosenWOD;

//rename NSTimer, NSDate, and NSTimeInterval var so they dont match with other view controllers
NSTimer *stopWatchTimerWODRandom;
NSDate *startDateWODRandom;
NSDate *saveDateWODRandom;
NSTimeInterval pauseTimerIntWODRandom = 0;
NSTimeInterval pauseTimerIntTempWODRandom = 0;
NSTimer *countdownTimerWODRandom;
int countdownIntWODRandom = 4;   //one digit higher to allow for "GO" message to appear

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
    wodNameLabel.text = chosenWOD;
    wodDetailsTextView.text = wodDetailsString;
    
    NSRange result = [[chosenDetails objectForKey:@"Timer"] rangeOfString:@"AMRAP"];
    if (result.location == NSNotFound) {
        timerLabel.text = @"00:00:00.0";
    }else{
        NSString *timeAMRAPString = [[chosenDetails objectForKey:@"Timer"] substringFromIndex:[[chosenDetails objectForKey:@"Timer"] length] - 2];
        NSString *timerLabelString = [[NSString alloc] initWithFormat:@"00:%@:00.00",timeAMRAPString];
        timerLabel.text = timerLabelString;
    }
}

- (void)viewDidUnload
{
    [self setWodDetailsTextView:nil];
    [self setTimerLabel:nil];
    [self setWodNameLabel:nil];
    [self setChosenDetails:nil];
    [self setStartButton:nil];
    [self setStopButton:nil];
    [self setRestartButton:nil];
    [self setCountdownLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateTimer{
    NSRange result = [[chosenDetails objectForKey:@"Timer"] rangeOfString:@"AMRAP"];
    if (result.location == NSNotFound) {
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDateWODRandom];
        NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:(timeInterval+pauseTimerIntWODRandom)];
        pauseTimerIntTempWODRandom = timeInterval + pauseTimerIntWODRandom;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.S"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        timerLabel.text = timeString;
    }else{
        NSString *timeAMRAPString = [[chosenDetails objectForKey:@"Timer"] substringFromIndex:[[chosenDetails objectForKey:@"Timer"] length] - 2];
        float timeAMRAP = [timeAMRAPString floatValue];
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDateWODRandom];
        NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:(timeAMRAP*60.0)-(timeInterval+pauseTimerIntWODRandom)];
        pauseTimerIntTempWODRandom = timeInterval + pauseTimerIntWODRandom;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.S"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        timerLabel.text = timeString;
    }
    
}

- (void)updateTimerCountdown{   //tiemr for the countdown in the background
    NSString *countdownString = [NSString stringWithFormat:@"%d",countdownIntWODRandom - 1];
    self.countdownLabel.text = countdownString;
    
    if (countdownIntWODRandom == 1) {
        //Creates the stop watch timer that fires every 10 ms
        startDateWODRandom = [NSDate date];
        
        self.countdownLabel.text = @"GO!";
        self.startButton.hidden = TRUE;
        self.stopButton.hidden = FALSE;
    }
    if (countdownIntWODRandom == 0) {
        [countdownTimerWODRandom invalidate];
        countdownTimerWODRandom = nil;
        self.countdownLabel.hidden = TRUE;
        stopWatchTimerWODRandom = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    
        countdownIntWODRandom = countdownIntWODRandom - 1;
    
}

- (IBAction)startButtonPressed:(id)sender {
    if ( countdownIntWODRandom > 0){
        self.countdownLabel.text = @"READY?";
        countdownTimerWODRandom = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimerCountdown) userInfo:nil repeats:YES];
        self.countdownLabel.hidden = FALSE;
    }
    if (countdownIntWODRandom == 0) {
        
        //Creates the stop watch timer that fires every 10 ms
        startDateWODRandom = [NSDate date];
        stopWatchTimerWODRandom = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        self.startButton.hidden = TRUE;
        self.stopButton.hidden = FALSE;
    }
}

- (IBAction)stopButtonPressed:(id)sender {
    pauseTimerIntWODRandom = pauseTimerIntTempWODRandom;
    [stopWatchTimerWODRandom invalidate];
    stopWatchTimerWODRandom = nil;
    self.stopButton.hidden = TRUE;
    self.startButton.hidden = FALSE;
}

- (IBAction)resetButtonPressed:(id)sender {
    pauseTimerIntWODRandom = 0;
    pauseTimerIntTempWODRandom = 0;
    [stopWatchTimerWODRandom invalidate];
    stopWatchTimerWODRandom = nil;
    [self updateTimer];
    timerLabel.text = @"00:00:00.0";
    self.startButton.hidden = FALSE;
    self.stopButton.hidden = TRUE;
    countdownIntWODRandom = 4;
}

@end
