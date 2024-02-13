//
//  IJSVGColorList.h
//  IconJar
//
//  Created by Curtis Hard on 07/07/2019.
//  Copyright © 2019 Curtis Hard. All rights reserved.
//

#import "IJSVGColor.h"
#import "IJSVGTraitedColor.h"
#import "IJSVGXEntities.h"
#import <Foundation/Foundation.h>

@interface IJSVGReplacementColor : IJSVGTraitedColor

@property (nonatomic, strong) XColor* replacementColor;

@end

@interface IJSVGTraitedColorStorage : NSObject {

@private
    NSMutableArray<IJSVGReplacementColor*>* _replacementColors;
    NSMutableSet<IJSVGTraitedColor*>* _colors;
    IJSVGColorUsageTraits _traits;
    IJSVGColorUsageTraits _replacementTraits;
}

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) NSSet<IJSVGTraitedColor*>* colors;
@property (nonatomic, readonly) NSUInteger replacedColorCount;

- (void)addTraits:(IJSVGColorUsageTraits)traits;
- (void)addColor:(IJSVGTraitedColor*)color;
- (void)replaceColor:(XColor*)replaceColor
           withColor:(XColor*)withColor
              traits:(IJSVGColorUsageTraits)traits;
- (void)unionColorStorage:(IJSVGTraitedColorStorage*)colorList;
- (XColor*)colorForColor:(XColor*)color
          matchingTraits:(IJSVGColorUsageTraits)traits;
- (BOOL)matchesReplacementTraits:(IJSVGColorUsageTraits)traits;
- (BOOL)matchesTraits:(IJSVGColorUsageTraits)traits;

@end
