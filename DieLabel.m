//
//  DieLabel.m
//  Farkle
//
//  Created by Marcial Galang on 1/15/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)labelWasTapped:(id)sender
{
    [delegate didChooseDie:self];
}

-(void)roll
{
    self.text = [NSString stringWithFormat:@"%i",(arc4random()%6+1)];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
