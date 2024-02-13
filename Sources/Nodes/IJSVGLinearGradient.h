//
//  IJSVGGradient.h
//  IJSVGExample
//
//  Created by Curtis Hard on 03/09/2014.
//  Copyright (c) 2014 Curtis Hard. All rights reserved.
//

#import "IJSVGGradient.h"
#import "IJSVGXEntities.h"
#import <Foundation/Foundation.h>

@interface IJSVGLinearGradient : IJSVGGradient

+ (void)parseGradient:(CXMLElement*)element
             gradient:(IJSVGLinearGradient*)aGradient;

@end
