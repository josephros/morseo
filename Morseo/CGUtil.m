//
//  CGUtil.m
//  CPA Stats
//
//  Created by Joseph Ros on 21/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CGUtil.h"

CGMutablePathRef CGRoundedRectPath(CGRect rect, CGFloat radius) {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;        
}

@implementation CGUtil

+(CGPoint)CGPointNull {
	return CGPointMake(-1, -1);
}

+(CGFloat)getDistance:(NSUInteger)distanceMode betweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2 {
	if (distanceMode == kDistanceHorizontal) {
		return [CGUtil horizontalDistanceBetweenPoint:point1 andPoint:point2];
	} else if (distanceMode == kDistanceVertical) {
		return [CGUtil verticalDistanceBetweenPoint:point1 andPoint:point2];
	}
	
	return [CGUtil distanceBetweenPoint:point1 andPoint:point2];
}

+(CGFloat)distanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2 {
    CGFloat dx = [CGUtil horizontalDistanceBetweenPoint:point1 andPoint:point2];
    CGFloat dy = [CGUtil verticalDistanceBetweenPoint:point1 andPoint:point2];
	
    return sqrt(dx*dx + dy*dy);
}

+(CGFloat)horizontalDistanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2 {
	return point1.x-point2.x;
}

+(CGFloat)verticalDistanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2 {
	return point1.y-point2.y;
}

@end
