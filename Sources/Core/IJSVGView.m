//
//  IJSVGView.m
//  IconJar
//
//  Created by Curtis Hard on 04/04/2017.
//  Copyright © 2017 Curtis Hard. All rights reserved.
//

#import "IJSVGView.h"

@implementation IJSVGView

@synthesize SVG;

- (void)dealloc
{
    // make sure we call this, or block may get called for a view
    // that doesnt exist
    [SVG prepForDrawingInView:nil];
}

+ (IJSVGView*)viewWithSVGNamed:(NSString*)name
{
    IJSVG* anSVG = [IJSVG SVGNamed:name];
    return [[self alloc] initWithSVG:anSVG];
}

- (id)initWithSVG:(IJSVG*)anSvg
{
    if((self = [super init]) != nil) {
        self.SVG = anSvg;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // image was set via IB
    if(imageName != nil) {
        IJSVG* anSVG = [IJSVG SVGNamed:imageName];
        if(tintColor != nil) {
            anSVG.style.fillColor = tintColor;
        }
        self.SVG = anSVG;
    }
}

- (void)setSVG:(IJSVG*)anSVG
{
    // memory clean
    SVG = anSVG;

    // redisplay ourself!
    [SVG prepForDrawingInView:self];
#if __has_include(<AppKit/AppKit.h>)
    [self setNeedsDisplay:YES];
#endif
#if __has_include(<UIKit/UIKit.h>)
    [self setNeedsDisplay];
#endif
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(XRect)dirtyRect
{
    // only draw if there is actually an SVG
    if(self.SVG == nil) {
        return;
    }

    // draw the svg
    [self.SVG drawInRect:self.bounds];
}

@end
