//
//  BIDRandomWOD.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 9/7/12.
//
//

#import <UIKit/UIKit.h>

@interface BIDRandomWOD : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wodNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *wodDetailsTextView;
@property (strong, nonatomic) NSDictionary *wodExercises;
@property (copy, nonatomic) NSString *chosenWOD;
@property (strong, nonatomic) NSDictionary *chosenDetails;
@property (strong, nonatomic) NSArray *wodList; 
- (IBAction)randomButtonPress:(id)sender;

@end
