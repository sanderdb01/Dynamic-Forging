//
//  BIDSettingDetailsViewController.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 1/25/14.
//
//

#import <UIKit/UIKit.h>

@interface BIDSettingDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *homeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gymSwitch;
@property (weak, nonatomic) NSString *exerciseName;
@property (weak, nonatomic) NSString *homeChecked;
@property (weak, nonatomic) NSString *gymChecked;
@property (weak, nonatomic) id delegate;

@end
