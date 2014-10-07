//
//  MorseView.m
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import "MorseView.h"
#import <QuartzCore/QuartzCore.h>
#import <Quartz/Quartz.h>
#include <stdlib.h>
#include "CGUtil.h"

@implementation MorseView

NSArray *_sequence;

CALayer *_midlineLayer;
CALayer *_layerContainer;
NSMutableArray *_layers;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** Setup Backing CALayer **/
        
        CALayer *layer = [CALayer layer];
        [layer setFrame:frame];
        [layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
        [layer setNeedsDisplay];
        [layer setAnchorPoint:CGPointMake(0.0, 0.0)];
        
        [self setLayerContentsRedrawPolicy:NSViewLayerContentsRedrawOnSetNeedsDisplay];
        [self setLayer:layer];
        [self setWantsLayer:YES];
        
        /** Setup Container Layer **/
        
        _layerContainer = [CALayer layer];
        [_layerContainer setFrame:frame];
        [_layerContainer setNeedsDisplay];
        [_layerContainer setMasksToBounds:NO];
        [_layerContainer setAnchorPoint:CGPointMake(0.0, 0.0)];
        [_layerContainer setZPosition:0.0]; // this one is at the bottom
        // [_layerContainer setBackgroundColor:[[NSColor purpleColor] CGColor]]; // for debugging
        [self.layer addSublayer:_layerContainer];
        
        /** Setup Layer For Midline **/
        
        _midlineLayer = [CALayer layer];
        [_midlineLayer setFrame:frame];
        [_midlineLayer setNeedsDisplay];
        [_midlineLayer setDelegate:self];
        [_midlineLayer setZPosition:1.0];
        [self.layer addSublayer:_midlineLayer];
    }
    return self;
}

-(void)setSequence:(NSArray *)sequence {
    _sequence = sequence;
    
    /** Remove Old CALayers/Reset _layerContainer **/
    
    if (_layers != nil) {
        for (CALayer *layer in _layers) [layer removeFromSuperlayer];
    }
   
    [_layerContainer removeAnimationForKey:@"position"];
    [_layerContainer setPosition:CGPointMake(CGRectGetMaxX(self.frame), 0.0)];
    
    /** Create New CALayers **/
    
    _layers = [NSMutableArray array];
    CGFloat offset = 0;
    CGFloat rectY = (CGRectGetHeight(self.frame)-kMorseHeight)/2.0;
    
    for (NSUInteger index = 0; index < _sequence.count; index++) {
        // Downs are even or 0
        // Ups are odds
        
        CGFloat previousTime = 0;
        if (index != 0) previousTime = (CGFloat)[(NSNumber *)[_sequence objectAtIndex:index-1] floatValue];
        CGFloat thisTime = (CGFloat)[(NSNumber *)[_sequence objectAtIndex:index] floatValue];
        
        CGFloat duration = thisTime-previousTime;
        
        if (index % 2 != 0) { // => an up => push a rectangle based on duration
            CGRect rect = CGRectMake(offset, rectY, duration/kOnePixelInSeconds, kMorseHeight);
            
            CALayer *layer = [CALayer layer];
            [layer setFrame:rect];
            [layer setBackgroundColor:[[NSColor blackColor] CGColor]];
            [layer setCornerRadius:5.0];
            [layer setZPosition:-1];
            [_layerContainer addSublayer:layer];
            
            [_layers addObject:layer];
        } /*else { // => a down => only increase offset based on duration
           
           }*/
        
        offset += duration/kOnePixelInSeconds; // offset increases either way
    }
}

-(void)updateSequenceRects {
    CGFloat newY = (CGRectGetHeight(self.frame)-kMorseHeight)/2.0;
    
    for (CALayer *layer in _layers) {
        [layer setPosition:CGPointMake(layer.position.x, newY)];
    }
}

-(float)sequenceLength {
    if (!_sequence) return 0;
    
    float length = 0;
    for (NSNumber *num in _sequence) {
        length += [num floatValue];
    }
    
    return length;
}

-(float)sequenceLength_pixels {
    return [self sequenceLength]/kOnePixelInSeconds;
}

CABasicAnimation *_sequenceAnimation;
-(float)playSequence {
    float duration = [self sequenceLength];
    float durationWidth = duration/kOnePixelInSeconds;
    
    CGPoint endPoint = CGPointMake(-durationWidth, _layerContainer.frame.origin.y);
    
    _sequenceAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    _sequenceAnimation.fromValue = [_layerContainer valueForKey:@"position"];
    _sequenceAnimation.toValue = [NSValue valueWithPoint:NSPointFromCGPoint(endPoint)];
    _sequenceAnimation.duration = duration;
    [_layerContainer addAnimation:_sequenceAnimation forKey:@"position"];
    
    return (CGRectGetMaxX(self.frame)/2.0)*kOnePixelInSeconds;
}

// Draws midline
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetStrokeColorWithColor(ctx, [[NSColor purpleColor] CGColor]);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMaxX(self.frame)/2.0+4.0, CGRectGetMaxY(self.frame));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(self.frame)/2.0+4.0, CGRectGetMinY(self.frame));
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMaxX(self.frame)/2.0-4.0, CGRectGetMaxY(self.frame));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(self.frame)/2.0-4.0, CGRectGetMinY(self.frame));
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}

-(void)viewWillMoveToSuperview:(NSView *)newSuperview {
    /** Test Sequence Data **/
    
    float offset = 0;
    NSMutableArray *testSequence = [NSMutableArray array];
    for (NSUInteger i = 0; i <= 100; i++) {
        float time = (float)arc4random_uniform(10)/10;
        if (i % 2 == 0) time = 0.25;
        
        offset += time;
        [testSequence setObject:[NSNumber numberWithFloat:offset] atIndexedSubscript:i];
    }
    
    [self setSequence:testSequence];
}

-(void)viewDidMoveToSuperview {
   [self playSequence];
}


-(void)setFrame:(NSRect)frameRect {
    [super setFrame:frameRect];
    [_midlineLayer setFrame:frameRect];
    
    [self.layer setNeedsDisplay];
    [_midlineLayer setNeedsDisplay];
    
    [_layerContainer setFrame:CGRectMake(_layerContainer.position.x, _layerContainer.position.y, frameRect.size.width, frameRect.size.height)];
    [self updateSequenceRects];
}


@end
