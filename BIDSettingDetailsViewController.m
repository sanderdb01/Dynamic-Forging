//
//  BIDSettingDetailsViewController.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 1/25/14.
//
//

#import "BIDSettingDetailsViewController.h"

@interface BIDSettingDetailsViewController ()

@end

@implementation BIDSettingDetailsViewController

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
    self.exerciseNameLabel.text = self.exerciseName;
    if ([self.homeChecked isEqualToString:@"on"])
    {
        self.homeSwitch.on = true;
    }
    else
    {
        self.homeSwitch.on = false;
    }
    
    if ([self.gymChecked isEqualToString:@"on"])
    {
        self.gymSwitch.on = true;
    }
    else
    {
        self.gymSwitch.on = false;
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSString *home;
    NSString *gym;
    if (self.gymSwitch.on)
    {
        gym = @"on";
    }
    else
    {
        gym = @"off";
    }
    if (self.homeSwitch.on)
    {
        home = @"on";
    }
    else
    {
        home = @"off";
    }
    
    NSDictionary *editedSelectionSettings = @{ @"home" : home, @"gym" : gym};
    NSDictionary *editedSelection = @{@"exercise": self.exerciseName, @"settings" : editedSelectionSettings};
    [self.delegate setValue:editedSelection forKey:@"editedSelection"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
