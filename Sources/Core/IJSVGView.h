//
//  IJSVGView.h
//  IconJar
//
//  Created by Curtis Hard on 04/04/2017.
//  Copyright © 2017 Curtis Hard. All rights reserved.
//

#import "IJSVGXEntities.h"
#import "IJSVG.h"

IB_DESIGNABLE
@interface IJSVGView : XView {
    IBInspectable NSString* imageName;
    IBInspectable XColor* tintColor;

    IJSVG* SVG;
}

@property (nonatomic, strong) IJSVG* SVG;

+ (IJSVGView*)viewWithSVGNamed:(NSString*)name;
- (id)initWithSVG:(IJSVG*)anSvg;

@end
