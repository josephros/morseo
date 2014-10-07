//
//  TestView.m
//  Morseo
//
//  Created by Joseph Ros on 07/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import "TestView.h"

@implementation TestView

CALayer *_testLayer;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *layer = [CALayer layer];
        [layer setFrame:frame];
        [layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
        [layer setNeedsDisplay];
        
        [self setLayer:layer];
        [self setWantsLayer:YES];
    
    }
    return self;
}

- (void)doSomething {
    if (_testLayer) [_testLayer removeFromSuperlayer];
    
    _testLayer = [CALayer layer];
    [_testLayer setFrame:CGRectMake(0, 0, 302956.218750, self.frame.size.height)];
    [_testLayer setDelegate:self];
    [_testLayer setBackgroundColor:[[NSColor whiteColor] CGColor]];
    [_testLayer setNeedsDisplay];
    
    [self.layer addSublayer:_testLayer];
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    [self doSomething];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    // deal with drawing _testLayer
    NSLog(@"draw");
}

@end
