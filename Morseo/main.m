//
//  main.m
//  Morseo
//
//  Created by Joseph Ros on 06/10/2014.
//  Copyright (c) 2014 Joseph Ros. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AppDelegate.h"

int main(int argc, const char * argv[])
{
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    id delegate = [[AppDelegate alloc] init];
    [[NSApplication sharedApplication] setDelegate:delegate];
    
    [[NSApplication sharedApplication] run];
    
    //[pool release];
    
    return 0;
}
