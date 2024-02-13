//
//  IJSVGImageLayer.h
//  IJSVGExample
//
//  Created by Curtis Hard on 07/01/2017.
//  Copyright © 2017 Curtis Hard. All rights reserved.
//

#import "IJSVGLayer.h"
#import "IJSVGImage.h"
#import "IJSVGTransformLayer.h"
#import "IJSVGTileLayer.h"
#import "IJSVGBasicLayer.h"
#import <AppKit/AppKit.h>
#import <QuartzCore/QuartzCore.h>

@interface IJSVGImageLayer : IJSVGTileLayer {
}

@property (nonatomic, strong) IJSVGImage* image;

- (id)initWithImage:(IJSVGImage*)image;

@end
