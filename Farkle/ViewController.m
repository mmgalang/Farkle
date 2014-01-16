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
    __weak IBOutlet UILabel *instructionLabel;
    __weak IBOutlet UIButton *bankButton;
    NSMutableArray *dice;
    BOOL firstRoll;
    BOOL isRollButtonPressed;
    
    __weak IBOutlet UILabel *userScore;
    __weak IBOutlet UILabel *turnScore;
    int userScoreInt;
    int turnScoreInt;
    int targetScore;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dice = [NSMutableArray array];
    dieLabel1.delegate = self;
    dieLabel2.delegate = self;
    dieLabel3.delegate = self;
    dieLabel4.delegate = self;
    dieLabel5.delegate = self;
    dieLabel6.delegate = self;
    dieLabel1.backgroundColor = [UIColor redColor];
    dieLabel2.backgroundColor = [UIColor redColor];
    dieLabel3.backgroundColor = [UIColor redColor];
    dieLabel4.backgroundColor = [UIColor redColor];
    dieLabel5.backgroundColor = [UIColor redColor];
    dieLabel6.backgroundColor = [UIColor redColor];
    firstRoll = YES;
    isRollButtonPressed = NO;
    userScoreInt = 0;
    turnScoreInt = 0;
    targetScore = 10000;
    instructionLabel.text = @"Click Roll Dice to begin your turn";
}

- (IBAction)onRollButtonPressed:(id)sender
{
    bankButton.hidden = YES;
    if (isRollButtonPressed == NO) {
        if (([dice containsObject:dieLabel1] == NO) || (firstRoll)) {
            [dieLabel1 roll];
            dieLabel1.backgroundColor = [UIColor redColor];
        }
        
        if (([dice containsObject:dieLabel2] == NO) || (firstRoll)) {
            [dieLabel2 roll];
            dieLabel2.backgroundColor = [UIColor redColor];
        }
        
        if (([dice containsObject:dieLabel3] == NO) || (firstRoll)) {
            [dieLabel3 roll];
            dieLabel3.backgroundColor = [UIColor redColor];
        }
        
        if (([dice containsObject:dieLabel4] == NO) || (firstRoll)) {
            [dieLabel4 roll];
            dieLabel4.backgroundColor = [UIColor redColor];
        }
        
        if (([dice containsObject:dieLabel5] == NO) || (firstRoll)) {
            [dieLabel5 roll];
            dieLabel5.backgroundColor = [UIColor redColor];
        }
        
        if (([dice containsObject:dieLabel6] == NO) || (firstRoll)) {
            [dieLabel6 roll];
            dieLabel6.backgroundColor = [UIColor redColor];
        }
        firstRoll = NO;
        isRollButtonPressed = YES;
        instructionLabel.text = @"Select any Die valid for scoring and click Calculate Score";
    }
}

-(void)didChooseDie:(DieLabel *)dieLabel
{
    if (!firstRoll) {
        if (![dice containsObject:dieLabel]) {
            dieLabel.scored = NO;
            dieLabel.preScored = NO;
            [dice addObject:dieLabel];
            
            dieLabel.backgroundColor = [UIColor yellowColor];
            NSLog(@"Adding Dice to Array");
        }
    }
}

- (IBAction)onCalculateScoreButtonPressed:(id)sender
{
    isRollButtonPressed = NO;
    int oneCounter = 0;
    int twoCounter = 0;
    int threeCounter = 0;
    int fourCounter = 0;
    int fiveCounter = 0;
    int sixCounter = 0;
    int rollScore = 0;
    
    for (int i = 0; i < dice.count; i++) {
        DieLabel *tempDie;
        tempDie = dice[i];
        if (tempDie.scored == NO) {
            tempDie.preScored = YES;
            NSLog(@"turning Green");
            tempDie.backgroundColor = [UIColor greenColor];
            int diceInt = [tempDie.text integerValue];
            
            switch (diceInt) {
                case 1:
                    oneCounter++;
                    break;
                case 2:
                    twoCounter++;
                    break;
                case 3:
                    threeCounter++;
                    break;
                case 4:
                    fourCounter++;
                    break;
                case 5:
                    fiveCounter++;
                    break;
                case 6:
                    sixCounter++;
                    break;
            }
        }
    }
    
    instructionLabel.text = @"Roll eligible dice or click Bank Button to end your turn";
    
    if ((oneCounter == 0) && (twoCounter == 0) && (threeCounter == 0) && (fourCounter == 0) && (fiveCounter == 0) && (sixCounter == 0)) {
        [self farkle];
    }
    
    while (oneCounter > 2) {
        rollScore += 1000;
        oneCounter -= 3;
    }
    while (twoCounter > 2) {
        rollScore += 200;
        twoCounter -= 3;
    }
    while (threeCounter > 2) {
        rollScore += 300;
        threeCounter -= 3;
    }
    while (fourCounter > 2) {
        rollScore += 400;
        fourCounter -= 3;
    }
    while (fiveCounter > 2) {
        rollScore += 500;
        fiveCounter -= 3;
    }
    while (sixCounter > 2) {
        rollScore += 600;
        sixCounter -= 3;
    }
    
    while (oneCounter > 0) {
        rollScore += 100;
        oneCounter -= 1;
    }
    while (fiveCounter > 0) {
        rollScore += 50;
        fiveCounter -= 1;
    }
    
    if ((twoCounter > 0) || (threeCounter > 0) || (fourCounter > 0) || (sixCounter > 0)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Die submitted for scoring" message:@"Select Again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        for (int i = 0; i < dice.count; i++) {
            DieLabel *tempInvalidDie;
            tempInvalidDie = dice[i];
            tempInvalidDie.preScored = NO;
        }
        for (int i = (dice.count - 1); i > -1; i--) {
            DieLabel *tempInvalidDie;
            tempInvalidDie = dice[i];
            if (tempInvalidDie.scored == NO) {
                tempInvalidDie.backgroundColor = [UIColor redColor];
                [dice removeObjectAtIndex:i];
            }
        }
        
        [alert show];
    }
    
    for (int i = 0; i < dice.count; i++) {
        DieLabel *tempInvalidDie;
        tempInvalidDie = dice[i];
        if (tempInvalidDie.preScored) {
            tempInvalidDie.scored = YES;
        }
    }
    
    int hotDice = 0;
    for (int i = 0; i < dice.count; i++) {
        DieLabel *tempHotDie;
        tempHotDie = dice[i];
        if (tempHotDie.scored) {
            hotDice++;
        }
    }
    
    if (hotDice == 6) {
        [self hotDice];
    }
    
    bankButton.hidden = NO;
    
    turnScoreInt += rollScore;
    turnScore.text = [NSString stringWithFormat:@"%i", turnScoreInt];
}

- (IBAction)onBankButtonPressed:(id)sender {
    userScoreInt += turnScoreInt;
    userScore.text = [NSString stringWithFormat:@"%i", userScoreInt ];
    turnScoreInt = 0;
    turnScore.text = [NSString stringWithFormat:@"%i", turnScoreInt];
    
    bankButton.hidden = YES;
    
    for (int i = (dice.count - 1); i > -1; i--) {
        [dice removeObjectAtIndex:i];
    }
    dieLabel1.backgroundColor = [UIColor redColor];
    dieLabel2.backgroundColor = [UIColor redColor];
    dieLabel3.backgroundColor = [UIColor redColor];
    dieLabel4.backgroundColor = [UIColor redColor];
    dieLabel5.backgroundColor = [UIColor redColor];
    dieLabel6.backgroundColor = [UIColor redColor];
    firstRoll = YES;
    instructionLabel.text = @"You Banked your points, click Roll Dice to begin your turn";
}

-(void)farkle {
    NSLog(@"farkle");
    turnScoreInt = 0;
    turnScore.text = [NSString stringWithFormat:@"%i", turnScoreInt];
    
    bankButton.hidden = YES;
    
    for (int i = (dice.count - 1); i > -1; i--) {
        [dice removeObjectAtIndex:i];
    }
    dieLabel1.backgroundColor = [UIColor redColor];
    dieLabel2.backgroundColor = [UIColor redColor];
    dieLabel3.backgroundColor = [UIColor redColor];
    dieLabel4.backgroundColor = [UIColor redColor];
    dieLabel5.backgroundColor = [UIColor redColor];
    dieLabel6.backgroundColor = [UIColor redColor];
    firstRoll = YES;
    instructionLabel.text = @"You Farkled, click Roll Dice to begin your turn";
}

-(void) hotDice
{
    NSLog(@"hot dice");
    bankButton.hidden = YES;
    
    for (int i = (dice.count - 1); i > -1; i--) {
        [dice removeObjectAtIndex:i];
    }
    dieLabel1.backgroundColor = [UIColor redColor];
    dieLabel2.backgroundColor = [UIColor redColor];
    dieLabel3.backgroundColor = [UIColor redColor];
    dieLabel4.backgroundColor = [UIColor redColor];
    dieLabel5.backgroundColor = [UIColor redColor];
    dieLabel6.backgroundColor = [UIColor redColor];
    firstRoll = YES;
    instructionLabel.text = @"Your Dice are HOT!, click Roll Dice to countinue your turn";
}

@end
