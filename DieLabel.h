//
//  DieLabel.h
//  Farkle
//
//  Created by Marcial Galang on 1/15/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DieLabelDelegate.h"

@interface DieLabel : UILabel

@property id<DieLabelDelegate> delegate;

-(void)roll;

@end
