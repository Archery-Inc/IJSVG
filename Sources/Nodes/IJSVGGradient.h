//
//  IJSVGGradient.h
//  IJSVGExample
//
//  Created by Curtis Hard on 03/09/2014.
//  Copyright (c) 2014 Curtis Hard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJSVGTraitedColorStorage.h"
#import "IJSVGTransform.h"
#import "IJSVGGroup.h"
#import "IJSVGXEntities.h"

@interface IJSVGGradient : IJSVGGroup

@property (nonatomic, strong) NSArray<XColor*>* colors;
@property (nonatomic, assign) CGFloat* locations;
@property (nonatomic, assign) NSUInteger numberOfStops;
@property (nonatomic, assign) CGGradientRef CGGradient;
@property (nonatomic, strong) IJSVGUnitLength* x1;
@property (nonatomic, strong) IJSVGUnitLength* x2;
@property (nonatomic, strong) IJSVGUnitLength* y1;
@property (nonatomic, strong) IJSVGUnitLength* y2;

+ (CGFloat*)computeColorStops:(IJSVGGradient*)gradient
                       colors:(NSArray**)someColors;

- (CGGradientRef)CGGradient;
- (void)drawInContextRef:(CGContextRef)ctx
                  bounds:(XRect)objectRect
               transform:(CGAffineTransform)absoluteTransform;

@end
