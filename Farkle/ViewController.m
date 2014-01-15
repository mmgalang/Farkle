//
//  ViewController.m
//  Farkle
//
//  Created by Marcial Galang on 1/15/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"
#import "DieLabelDelegate.h"

@interface ViewController () <DieLabelDelegate>
{
    
    __weak IBOutlet DieLabel *dieLabel1;
    __weak IBOutlet DieLabel *dieLabel2;
    __weak IBOutlet DieLabel *dieLabel3;
    __weak IBOutlet DieLabel *dieLabel4;
    __weak IBOutlet DieLabel *dieLabel5;
    __weak IBOutlet DieLabel *dieLabel6;
    NSMutableArray *dice;
    
    __weak IBOutlet UILabel *userScore;
    __weak IBOutlet UILabel *userName;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dice = [NSMutableArray array];
}

- (IBAction)onRollButtonPressed:(id)sender
{
    if ([dice containsObject:dieLabel1] == NO) {
        [dieLabel1 roll];
        dieLabel1.backgroundColor = [UIColor redColor];
    }
    
    if ([dice containsObject:dieLabel2] == NO) {
        [dieLabel2 roll];
        dieLabel2.backgroundColor = [UIColor redColor];
    }
    
    if ([dice containsObject:dieLabel3] == NO) {
        [dieLabel3 roll];
        dieLabel3.backgroundColor = [UIColor redColor];
    }

    if ([dice containsObject:dieLabel4] == NO) {
        [dieLabel4 roll];
        dieLabel4.backgroundColor = [UIColor redColor];
    }
    
    if ([dice containsObject:dieLabel5] == NO) {
        [dieLabel5 roll];
        dieLabel5.backgroundColor = [UIColor redColor];
    }
    
    if ([dice containsObject:dieLabel6] == NO) {
        [dieLabel6 roll];
        dieLabel6.backgroundColor = [UIColor redColor];
    }
}

-(void)didChooseDie:(DieLabel *)dieLabel
{
    dieLabel.delegate = self;
    [dice addObject:dieLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
