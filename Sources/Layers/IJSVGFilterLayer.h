//
//  IJSVGFilterLayer.h
//  IJSVG
//
//  Created by Curtis Hard on 19/04/2022.
//  Copyright © 2022 Curtis Hard. All rights reserved.
//

#import "IJSVGLayer.h"
#import "IJSVGFilter.h"
#import "IJSVGBasicLayer.h"

@interface IJSVGFilterLayer : IJSVGLayer {
    
@private
    IJSVGBasicLayer* _hostingLayer;
    CGImageRef _image;
    
}

@property (nonatomic, strong) CALayer<IJSVGDrawableLayer>* sublayer;

@end
