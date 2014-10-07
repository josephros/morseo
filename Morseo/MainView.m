//
//  MainView.m
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import "MainView.h"

#import "MorseView.h"

@implementation MainView

MorseView *_morseView;
NSButton *_startButton;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _morseView = [[MorseView alloc] initWithFrame:frame];
        [self addSubview:_morseView];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [_morseView setFrame:self.frame];
}

- (void)setFrame:(NSRect)frameRect {
    [self setNeedsDisplay:YES];
}

/** Testing Mode **/

-(void)viewWillMoveToSuperview:(NSView *)newSuperview {
    float offset = 0;
    NSMutableArray *testSequence = [NSMutableArray array];
    for (NSUInteger i = 0; i <= 100; i++) {
        float time = (float)arc4random_uniform(10)/10;
        if (i % 2 == 0) time = 0.25;
        
        offset += time;
        [testSequence setObject:[NSNumber numberWithFloat:offset] atIndexedSubscript:i];
    }
    
    [_morseView setSequence:testSequence];
}

-(void)viewDidMoveToSuperview {
    [_morseView playSequence];
}

/*************************/

@end
