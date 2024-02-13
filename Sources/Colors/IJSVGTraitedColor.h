//
//  IJSVGColorType.h
//  IJSVG
//
//  Created by Curtis Hard on 20/04/2021.
//  Copyright © 2021 Curtis Hard. All rights reserved.
//

#import "IJSVGXEntities.h"
#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, IJSVGColorUsageTraits) {
    IJSVGColorUsageTraitNone = 0,
    IJSVGColorUsageTraitUnknown = 1 << 0,
    IJSVGColorUsageTraitFill = 1 << 1,
    IJSVGColorUsageTraitStroke = 1 << 2,
    IJSVGColorUsageTraitGradientStop = 1 << 3,
    IJSVGColorUsageTraitAll = IJSVGColorUsageTraitFill | IJSVGColorUsageTraitGradientStop |
        IJSVGColorUsageTraitStroke
};

@interface IJSVGTraitedColor : NSObject {
    
}

@property (nonatomic, strong) XColor* color;
@property (nonatomic, assign) IJSVGColorUsageTraits traits;

+ (IJSVGTraitedColor*)colorWithColor:(XColor*)color
                              traits:(IJSVGColorUsageTraits)mask;

- (void)addTraits:(IJSVGColorUsageTraits)traits;
- (void)removeTraits:(IJSVGColorUsageTraits)traits;
- (BOOL)matchesTraits:(IJSVGColorUsageTraits)traits;

@end
