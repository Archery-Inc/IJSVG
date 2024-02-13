//
//  IJSVGColor.h
//  IconJar
//
//  Created by Curtis Hard on 31/08/2014.
//  Copyright (c) 2014 Curtis Hard. All rights reserved.
//

#import "IJSVGXEntities.h"

typedef NS_OPTIONS(NSInteger, IJSVGColorStringOptions) {
    IJSVGColorStringOptionNone = 1 << 0,
    IJSVGColorStringOptionForceHEX = 1 << 1,
    IJSVGColorStringOptionAllowShortHand = 1 << 2,
    IJSVGColorStringOptionAllowRRGGBBAA = 1 << 3,
    IJSVGColorStringOptionDefault = IJSVGColorStringOptionAllowShortHand
};

typedef NS_ENUM(NSInteger, IJSVGPredefinedColor) {
    IJSVGColorAliceblue,
    IJSVGColorAntiquewhite,
    IJSVGColorAqua,
    IJSVGColorAquamarine,
    IJSVGColorAzure,
    IJSVGColorBeige,
    IJSVGColorBisque,
    IJSVGColorBlack,
    IJSVGColorBlanchedalmond,
    IJSVGColorBlue,
    IJSVGColorBlueviolet,
    IJSVGColorBrown,
    IJSVGColorBurlywood,
    IJSVGColorCadetblue,
    IJSVGColorChartreuse,
    IJSVGColorChocolate,
    IJSVGColorCoral,
    IJSVGColorCornflowerblue,
    IJSVGColorCornsilk,
    IJSVGColorCrimson,
    IJSVGColorCyan,
    IJSVGColorDarkblue,
    IJSVGColorDarkcyan,
    IJSVGColorDarkgoldenrod,
    IJSVGColorDarkgray,
    IJSVGColorDarkgreen,
    IJSVGColorDarkgrey,
    IJSVGColorDarkkhaki,
    IJSVGColorDarkmagenta,
    IJSVGColorDarkolivegreen,
    IJSVGColorDarkorange,
    IJSVGColorDarkorchid,
    IJSVGColorDarkred,
    IJSVGColorDarksalmon,
    IJSVGColorDarkseagreen,
    IJSVGColorDarkslateblue,
    IJSVGColorDarkslategray,
    IJSVGColorDarkslategrey,
    IJSVGColorDarkturquoise,
    IJSVGColorDarkviolet,
    IJSVGColorDeeppink,
    IJSVGColorDeepskyblue,
    IJSVGColorDimgray,
    IJSVGColorDimgrey,
    IJSVGColorDodgerblue,
    IJSVGColorFirebrick,
    IJSVGColorFloralwhite,
    IJSVGColorForestgreen,
    IJSVGColorFuchsia,
    IJSVGColorGainsboro,
    IJSVGColorGhostwhite,
    IJSVGColorGold,
    IJSVGColorGoldenrod,
    IJSVGColorGray,
    IJSVGColorGreen,
    IJSVGColorGreenyellow,
    IJSVGColorGrey,
    IJSVGColorHoneydew,
    IJSVGColorHotpink,
    IJSVGColorIndianred,
    IJSVGColorIndigo,
    IJSVGColorIvory,
    IJSVGColorKhaki,
    IJSVGColorLavender,
    IJSVGColorLavenderblush,
    IJSVGColorLawngreen,
    IJSVGColorLemonchiffon,
    IJSVGColorLightblue,
    IJSVGColorLightcoral,
    IJSVGColorLightcyan,
    IJSVGColorLightgoldenrodyellow,
    IJSVGColorLightgray,
    IJSVGColorLightgreen,
    IJSVGColorLightgrey,
    IJSVGColorLightpink,
    IJSVGColorLightsalmon,
    IJSVGColorLightseagreen,
    IJSVGColorLightskyblue,
    IJSVGColorLightslategray,
    IJSVGColorLightslategrey,
    IJSVGColorLightsteelblue,
    IJSVGColorLightyellow,
    IJSVGColorLime,
    IJSVGColorLimegreen,
    IJSVGColorLinen,
    IJSVGColorMagenta,
    IJSVGColorMaroon,
    IJSVGColorMediumaquamarine,
    IJSVGColorMediumblue,
    IJSVGColorMediumorchid,
    IJSVGColorMediumpurple,
    IJSVGColorMediumseagreen,
    IJSVGColorMediumslateblue,
    IJSVGColorMediumspringgreen,
    IJSVGColorMediumturquoise,
    IJSVGColorMediumvioletred,
    IJSVGColorMidnightblue,
    IJSVGColorMintcream,
    IJSVGColorMistyrose,
    IJSVGColorMoccasin,
    IJSVGColorNavajowhite,
    IJSVGColorNavy,
    IJSVGColorOldlace,
    IJSVGColorOlive,
    IJSVGColorOlivedrab,
    IJSVGColorOrange,
    IJSVGColorOrangered,
    IJSVGColorOrchid,
    IJSVGColorPalegoldenrod,
    IJSVGColorPalegreen,
    IJSVGColorPaleturquoise,
    IJSVGColorPalevioletred,
    IJSVGColorPapayawhip,
    IJSVGColorPeachpuff,
    IJSVGColorPeru,
    IJSVGColorPink,
    IJSVGColorPlum,
    IJSVGColorPowderblue,
    IJSVGColorPurple,
    IJSVGColorRed,
    IJSVGColorRosybrown,
    IJSVGColorRoyalblue,
    IJSVGColorSaddlebrown,
    IJSVGColorSalmon,
    IJSVGColorSandybrown,
    IJSVGColorSeagreen,
    IJSVGColorSeashell,
    IJSVGColorSienna,
    IJSVGColorSilver,
    IJSVGColorSkyblue,
    IJSVGColorSlateblue,
    IJSVGColorSlategray,
    IJSVGColorSlategrey,
    IJSVGColorSnow,
    IJSVGColorSpringgreen,
    IJSVGColorSteelblue,
    IJSVGColorTan,
    IJSVGColorTeal,
    IJSVGColorThistle,
    IJSVGColorTomato,
    IJSVGColorTurquoise,
    IJSVGColorViolet,
    IJSVGColorWheat,
    IJSVGColorWhite,
    IJSVGColorWhitesmoke,
    IJSVGColorYellow,
    IJSVGColorYellowgreen
};

extern NSString* const IJSVGColorCurrentColorName;

@interface IJSVGColor : NSObject

CGFloat* IJSVGColorCSSHSLToHSB(CGFloat hue, CGFloat saturation, CGFloat lightness);

+ (XColor*)computeColorSpace:(XColor*)color;
+ (XColorSpace*)defaultColorSpace;
+ (BOOL)isColor:(NSString*)string;
+ (NSString*)colorStringFromColor:(XColor*)color
                          options:(IJSVGColorStringOptions)options;
+ (NSString*)colorStringFromColor:(XColor*)color;
+ (XColor*)colorFromHEXInteger:(NSInteger)hex;
+ (XColor*)computeColor:(id)colour;
+ (BOOL)isNoneOrTransparent:(NSString*)string;
+ (XColor*)colorFromString:(NSString*)string;
+ (XColor*)colorFromHEXString:(NSString*)string;
+ (XColor*)colorFromHEXString:(NSString*)string
       containsAlphaComponent:(BOOL*)containsAlphaComponent;
+ (BOOL)HEXContainsAlphaComponent:(NSUInteger)hex;
+ (unsigned long)lengthOfHEXInteger:(NSUInteger)hex;
+ (XColor*)colorFromRString:(NSString*)rString
                    gString:(NSString*)gString
                    bString:(NSString*)bString
                    aString:(NSString*)aString;
+ (XColor*)colorFromPredefinedColorName:(NSString*)name;
+ (NSString*)colorNameFromPredefinedColor:(IJSVGPredefinedColor)color;
+ (XColor*)changeAlphaOnColor:(XColor*)color
                           to:(CGFloat)alphaValue;

@end
