//
//  IJSVGStyleSheetRule.h
//  IJSVGExample
//
//  Created by Curtis Hard on 16/01/2016.
//  Copyright © 2016 Curtis Hard. All rights reserved.
//

#import "IJSVGStyleSheetStyle.h"
#import "IJSVGStyleSheetSelector.h"
#import <Foundation/Foundation.h>

@class IJSVGNode;

@interface IJSVGStyleSheetRule : NSObject {
}

@property (nonatomic, strong) NSArray* selectors;
@property (nonatomic, strong) IJSVGStyleSheetStyle* style;

- (BOOL)matchesNode:(IJSVGNode*)node
           selector:(IJSVGStyleSheetSelector**)matchedSelector;

@end
