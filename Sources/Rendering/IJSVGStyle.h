//
//  IJSVGStyleList.h
//  IconJar
//
//  Created by Curtis Hard on 09/07/2019.
//  Copyright © 2019 Curtis Hard. All rights reserved.
//

#import "IJSVGTraitedColorStorage.h"
#import "IJSVGNode.h"
#import "IJSVGXEntities.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface IJSVGStyle : NSObject

@property (nonatomic, assign) IJSVGLineCapStyle lineCapStyle;
@property (nonatomic, assign) IJSVGLineJoinStyle lineJoinStyle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat miterLimit;
@property (nonatomic, strong) IJSVGTraitedColorStorage* colors;
@property (nonatomic, strong) XColor* fillColor;
@property (nonatomic, strong) XColor* strokeColor;

@end
