//
//  BIDDFOptionsController.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDDFOptionsController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *locationSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bodySwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *diffLvlSwitch;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *targetArea;
@property (copy, nonatomic) NSString *diffLvl;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)locationChoose:(id)sender;
- (IBAction)bodyChoose:(id)sender;
- (IBAction)diffLvlChoose:(id)sender;

@end
