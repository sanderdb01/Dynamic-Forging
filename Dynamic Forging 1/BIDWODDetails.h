//
//  BIDWODDetails.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 8/14/12.
//
//

#import <UIKit/UIKit.h>

@interface BIDWODDetails : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wodLabel;
@property (weak, nonatomic) IBOutlet UITextView *wodTextView;
@property (copy, nonatomic) NSString *chosenWOD;
@property (strong, nonatomic) NSDictionary *chosenDetails;

@end
