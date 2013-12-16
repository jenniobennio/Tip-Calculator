//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Jenny Kwan on 12/15/13.
//  Copyright (c) 2013 Jenny Kwan. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPick;
- (IBAction)setDefaultTip:(id)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int index = [defaults integerForKey:@"default_tip"];
    [self.defaultTipPick setSelectedSegmentIndex:index];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Save" style:UIBarButtonItemStylePlain target:self action:@selector(close)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setDefaultTip:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int index = self.defaultTipPick.selectedSegmentIndex;
    [defaults setInteger:index forKey:@"default_tip"];
    [defaults synchronize];
}

- (void) close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
