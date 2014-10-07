//
//  MorseView.h
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// how many pixels represent one second => speed
#define kOnePixelInSeconds 0.005
#define kMorseHeight 15.0

@interface MorseView : NSView {
    
}

-(void)setSequence:(NSArray *)sequence;
-(float)sequenceLength;
-(float)playSequence;

@end
