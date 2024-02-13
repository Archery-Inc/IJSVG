//
//  IJSVGGroupLayer.h
//  IJSVGExample
//
//  Created by Curtis Hard on 07/01/2017.
//  Copyright © 2017 Curtis Hard. All rights reserved.
//

#import "IJSVGLayer.h"
#import "IJSVGShapeLayer.h"
#import "IJSVGUnitRect.h"
#import <QuartzCore/QuartzCore.h>

@interface IJSVGGroupLayer : IJSVGLayer <IJSVGMaskingLayer> {
    
}

@property (nonatomic, strong) IJSVGUnitSize* intrinsicSize;
@property (nonatomic, strong) IJSVGUnitRect* viewBox;
@property (nonatomic, assign) IJSVGViewBoxAlignment viewBoxAlignment;
@property (nonatomic, assign) IJSVGViewBoxMeetOrSlice viewBoxMeetOrSlice;

@end
