//
//  TipViewController.m
//  tipcalculator
//
//  Created by Jenny Kwan on 12/15/13.
//  Copyright (c) 2013 Jenny Kwan. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *asdx;

- (IBAction)onTap:(id)sender;
- (void) updateValues;
- (void) onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self updateValues];
    
    self.billTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int index = [defaults integerForKey:@"default_tip"];
    [self.tipControl setSelectedSegmentIndex:index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    float tipValue = billAmount*[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalValue = tipValue + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipValue];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalValue];
}

- (void) onSettingsButton {
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];

    [self.navigationController presentViewController:nvc animated:YES completion:nil];
    // pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.billTextField.text = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onTap:)];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.navigationItem.rightBarButtonItem = nil;
    return YES;
}
@end
