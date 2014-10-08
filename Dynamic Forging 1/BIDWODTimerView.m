//
//  BIDWODTimerView.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/7/12.
//
//

#import "BIDWODTimerView.h"

@interface BIDWODTimerView ()

@end

@implementation BIDWODTimerView
@synthesize wodNameLabel;
@synthesize wodDetailsTextView;
@synthesize timerLabel;
@synthesize chosenDetails;
@synthesize startButton;
@synthesize stopButton;
@synthesize resetButton;
@synthesize countdownLabel;
@synthesize chosenWOD;

NSTimer *stopWatchTimerWOD;
NSDate *startDateWOD;
NSDate *saveDateWOD;
NSTimeInterval pauseTimerIntWOD = 0;
NSTimeInterval pauseTimerIntTempWOD = 0;
NSString *timeLabelString;
NSTimer *countdownTimerWOD;
int countdownIntWOD = 4;   //one digit higher to allow for "GO" message to appear

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
    NSRange result = [[chosenDetails objectForKey:@"Timer"] rangeOfString:@"AMRAP"];
    if (result.location == NSNotFound) {
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDateWOD];
        NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:(timeInterval+pauseTimerIntWOD)];
        pauseTimerIntTempWOD = timeInterval + pauseTimerIntWOD;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.S"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        timerLabel.text = timeString;
    }else{
        NSString *timeAMRAPString = [[chosenDetails objectForKey:@"Timer"] substringFromIndex:[[chosenDetails objectForKey:@"Timer"] length] - 2];
        float timeAMRAP = [timeAMRAPString floatValue];
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDateWOD];
        NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:(timeAMRAP*60.0)-(timeInterval+pauseTimerIntWOD)];
        pauseTimerIntTempWOD = timeInterval + pauseTimerIntWOD;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.S"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        NSString *timeString = [dateFormatter stringFromDate:timerDate];
        timerLabel.text = timeString;
    }
    
}

- (void)updateTimerCountdown{   //tiemr for the countdown in the background
    NSString *countdownString = [NSString stringWithFormat:@"%d",countdownIntWOD - 1];
    self.countdownLabel.text = countdownString;
    
    if (countdownIntWOD == 1) {
        //Creates the stop watch timer that fires every 10 ms
        startDateWOD = [NSDate date];
        
        self.countdownLabel.text = @"GO!";
        self.startButton.hidden = TRUE;
        self.stopButton.hidden = FALSE;
    }
    if (countdownIntWOD == 0) {
        [countdownTimerWOD invalidate];
        countdownTimerWOD = nil;
        self.countdownLabel.hidden = TRUE;
        stopWatchTimerWOD = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    
    countdownIntWOD = countdownIntWOD - 1;
    
}

- (IBAction)startButtonPressed:(id)sender {
    if ( countdownIntWOD > 0){
        self.countdownLabel.text = @"READY?";
        countdownTimerWOD = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimerCountdown) userInfo:nil repeats:YES];
        self.countdownLabel.hidden = FALSE;
    }
    if (countdownIntWOD == 0) {
        
        //Creates the stop watch timer that fires every 10 ms
        startDateWOD = [NSDate date];
        stopWatchTimerWOD = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        self.startButton.hidden = TRUE;
        self.stopButton.hidden = FALSE;
    }
}

- (IBAction)stopButtonPressed:(id)sender {
    pauseTimerIntWOD = pauseTimerIntTempWOD;
    [stopWatchTimerWOD invalidate];
    stopWatchTimerWOD = nil;
    self.stopButton.hidden = TRUE;
    self.startButton.hidden = FALSE;
}

- (IBAction)resetButtonPressed:(id)sender {
    pauseTimerIntWOD = 0;
    pauseTimerIntTempWOD = 0;
    [stopWatchTimerWOD invalidate];
    stopWatchTimerWOD = nil;
    [self updateTimer];
    timerLabel.text = @"00:00:00.0";
    self.startButton.hidden = FALSE;
    self.stopButton.hidden = TRUE;
    countdownIntWOD = 4;
}
@end
