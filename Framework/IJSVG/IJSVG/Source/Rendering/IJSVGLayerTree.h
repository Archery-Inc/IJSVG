//
//  IJSVGLayerTree.h
//  IJSVGExample
//
//  Created by Curtis Hard on 29/12/2016.
//  Copyright © 2016 Curtis Hard. All rights reserved.
//

#import <IJSVG/IJSVGNode.h>
#import <IJSVG/IJSVGRenderingStyle.h>
#import <QuartzCore/QuartzCore.h>

@class IJSVGLayer;

@interface IJSVGLayerTree : NSObject {
}

@property (nonatomic, assign) CGRect viewBox;
@property (nonatomic, retain) IJSVGRenderingStyle* style;

- (IJSVGLayer*)layerForNode:(IJSVGNode*)node;

@end
