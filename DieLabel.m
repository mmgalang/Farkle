//
//  DieLabel.m
//  Farkle
//
//  Created by Marcial Galang on 1/15/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel
@synthesize delegate, scored, preScored;

-(IBAction)labelWasTapped:(id)sender
{
    [delegate didChooseDie:self];
}

-(void)roll
{
    self.text = [NSString stringWithFormat:@"%i",(arc4random()%6+1)];
}

@end
