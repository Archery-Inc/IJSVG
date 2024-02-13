//
//  IJSVGRootNode.h
//  IJSVG
//
//  Created by Curtis Hard on 28/03/2022.
//  Copyright © 2022 Curtis Hard. All rights reserved.
//

#import "IJSVG.h"
#import "IJSVGGroup.h"
#import "IJSVGUnitSize.h"

@interface IJSVGRootNode : IJSVGGroup

@property (nonatomic, assign) IJSVGIntrinsicDimensions intrinsicDimensions;
@property (nonatomic, strong) IJSVGUnitSize* intrinsicSize;
@property (nonatomic, readonly) CGRect bounds;

@end
