//
//  IJSVGFilter.h
//  IJSVG
//
//  Created by Curtis Hard on 18/04/2022.
//  Copyright © 2022 Curtis Hard. All rights reserved.
//

#import "IJSVGGroup.h"
#import "IJSVGLayer.h"

@interface IJSVGFilter : IJSVGGroup

- (CGImageRef)newImageByApplyFilterToLayer:(CALayer<IJSVGDrawableLayer>*)layer
                                     scale:(CGFloat)scale;

@property (nonatomic, readonly) BOOL valid;

@end
