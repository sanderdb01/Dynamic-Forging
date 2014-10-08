//
//  BIDWODRandomTimerView.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/9/12.
//
//

#import <UIKit/UIKit.h>

@interface BIDWODRandomTimerView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wodNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *wodDetailsTextView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (copy, nonatomic) NSString *chosenWOD;
@property (strong, nonatomic) NSDictionary *chosenDetails;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
@end
