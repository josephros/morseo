//
//  AppDelegate.m
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize mainWindow;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSRect frame = NSMakeRect(0, 0, 500, 400);
    self.mainWindow  = [[MorseoWindow alloc] initWithContentRect:frame
                                              styleMask:(NSTitledWindowMask|NSClosableWindowMask|NSResizableWindowMask)
                                              backing:NSBackingStoreBuffered
                                              defer:NO];
    
    [self.mainWindow makeKeyAndOrderFront:NSApp];
    [self.mainWindow center];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
