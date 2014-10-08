//
//  BIDWODTimerView.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/7/12.
//
//

#import <UIKit/UIKit.h>

@interface BIDWODTimerView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wodNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *wodDetailsTextView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (copy, nonatomic) NSString *chosenWOD;
@property (strong, nonatomic) NSDictionary *chosenDetails;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;


@end
