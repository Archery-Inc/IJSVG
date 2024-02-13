//
//  IJSVGClipPath.h
//  IJSVG
//
//  Created by Curtis Hard on 29/05/2022.
//  Copyright © 2022 Curtis Hard. All rights reserved.
//

#import "IJSVGGroup.h"

@interface IJSVGClipPath : IJSVGGroup {
}

@property (nonatomic, readonly) IJSVGWindingRule computedClipRule;

@end
