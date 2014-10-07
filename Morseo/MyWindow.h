//
//  MyWindow.h
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MorseView.h"


@interface MyWindow : NSWindow <NSWindowDelegate>

@property (weak) IBOutlet MorseView *morseView;

@end
