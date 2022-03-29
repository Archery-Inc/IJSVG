//
//  IJSVGColorNode.h
//  IJSVG
//
//  Created by Curtis Hard on 29/03/2022.
//  Copyright © 2022 Curtis Hard. All rights reserved.
//

#import <IJSVG/IJSVGNode.h>

@interface IJSVGColorNode : IJSVGNode {
    
}

@property (nonatomic, retain) NSColor* color;

+ (IJSVGNode*)colorNodeWithColor:(NSColor*)color;

- (id)initWithColor:(NSColor*)color;

@end
