//
//  CGUtil.h
//  CPA Stats
//
//  Created by Joseph Ros on 21/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

CGMutablePathRef CGRoundedRectPath(CGRect rect, CGFloat radius);

@interface CGUtil : NSObject {

}

#define kDistance 0
#define kDistanceHorizontal 1
#define kDistanceVertical 2

+(CGPoint)CGPointNull;

+(CGFloat)getDistance:(NSUInteger)distanceMode betweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;

+(CGFloat)distanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;
+(CGFloat)horizontalDistanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;
+(CGFloat)verticalDistanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;

@end

#define LogRect(RECT) NSLog(@"(%f, %f) %f x %f", RECT.origin.x, RECT.origin.y, RECT.size.width, RECT.size.height);
#define LogPoint(POINT) NSLog(@"(%f, %f)", POINT.x, POINT.y);
