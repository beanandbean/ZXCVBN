//
//  BBViewController.m
//  ZXCVBN
//
//  Created by wangsw on 10/18/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBViewController.h"

#import "BBPasswordStrength.h"

@interface BBViewController ()

@property (strong, nonatomic) UITextField *textfield;
@property (strong, nonatomic) UILabel *label;

@end

@implementation BBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"Welcome to ZXCVBN!";
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [self.view addSubview:label];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
    
    self.textfield = [[UITextField alloc] init];
    self.textfield.placeholder = @"password";
    self.textfield.translatesAutoresizingMaskIntoConstraints = NO;
    self.textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textfield.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [self.textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.textfield];
    
    [self.textfield addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
    
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.text = @"Cracked in no time!\nEntropy: 0.000 (0.000 per char)";
    self.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [self.view addSubview:self.label];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.textfield attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textfield attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange {
    NSString *trimmed = [self.textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([trimmed isEqualToString:@""]) {
        self.label.text = @"Cracked in no time!\nEntropy: 0.000 (0.000 per char)";
        self.view.backgroundColor = [UIColor whiteColor];
    } else {
        BBPasswordStrength *strength = [[BBPasswordStrength alloc] initWithPassword:trimmed];
        double entropyperchar = strength.entropy / trimmed.length;
        entropyperchar = round(entropyperchar * 1000) / 1000;
        self.label.text = [NSString stringWithFormat:@"Cracked in %@!\nEntropy: %.3f (%.3f per char)", strength.crackTimeDisplay, strength.entropy, entropyperchar];

        UIColor *color = [UIColor colorWithHue:0.667 - strength.entropy / 75 saturation:1.0 brightness:1.0 alpha:1.0];
        self.view.backgroundColor = color;
    }
}

@end
