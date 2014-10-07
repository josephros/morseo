//
//  MyWindow.m
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

@synthesize morseView;

-(void)windowDidResize:(NSNotification *)notification {
    NSLog(@"resize");
}

@end
