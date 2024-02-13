//
//  IJSVGColorNode.h
//  IJSVG
//
//  Created by Curtis Hard on 29/03/2022.
//  Copyright © 2022 Curtis Hard. All rights reserved.
//

#import "IJSVGNode.h"
#import "IJSVGXEntities.h"

@interface IJSVGColorNode : IJSVGNode {
    
}

@property (nonatomic, strong) XColor* color;
@property (nonatomic, assign) BOOL isNoneOrTransparent;

+ (IJSVGNode*)colorNodeWithColor:(XColor*)color;

- (id)initWithColor:(XColor*)color;

@end
