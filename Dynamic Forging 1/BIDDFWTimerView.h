//
//  BIDDFWTimerView.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/5/12.
//
//

#import <UIKit/UIKit.h>

@interface BIDDFWTimerView : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *workoutDetails;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (copy, nonatomic) NSString *results;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;

@end
