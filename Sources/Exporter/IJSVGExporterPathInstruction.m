//
//  IJSVGExporterPathInstruction.m
//  IconJar
//
//  Created by Curtis Hard on 08/01/2017.
//  Copyright © 2017 Curtis Hard. All rights reserved.
//


#import "IJSVGExporter.h"
#import "IJSVGExporterPathInstruction.h"
#import "IJSVGUtils.h"
#import <TargetConditionals.h>
#import <math.h>

#if TARGET_OS_OSX
@implementation IJSVGExporterPathInstructionCommand
@end

@implementation IJSVGExporterPathInstruction

@synthesize instruction = _instruction;

- (void)dealloc
{
    if(_data != NULL) {
        (void)free(_data), _data = NULL;
    }
    if(_base != NULL) {
        (void)free(_base), _base = NULL;
    }
    if(_coords != NULL) {
        (void)free(_coords), _coords = NULL;
    }
}

- (id)initWithInstruction:(char)instruction
                dataCount:(NSInteger)floatCount
{
    if((self = [super init]) != nil) {
        _instruction = instruction;

        // only allocate if not zero
        if(floatCount != 0) {
            _dataCount = floatCount;
            _data = (CGFloat*)calloc(sizeof(CGFloat), floatCount);
        }

        // setup base and coords
        _base = (CGFloat*)malloc(sizeof(CGFloat) * 2);
        _coords = (CGFloat*)malloc(sizeof(CGFloat) * 2);
    }
    return self;
}

- (NSInteger)dataLength
{
    return _dataCount;
}

- (CGFloat*)data
{
    return _data;
}

- (CGFloat*)base
{
    return _base;
}

- (CGFloat*)coords
{
    return _coords;
}

+ (NSString*)pathStringWithInstructionSet:(NSArray<IJSVGExporterPathInstructionCommand*>*)instructionSets
                     floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    IJSVGExporterPathInstructionCommand* lastCommand = NULL;
    NSMutableString* string = [[NSMutableString alloc] init];
    for (IJSVGExporterPathInstructionCommand* command in instructionSets) {
        // read back the bytes

        // add on the instruction character only if there is no current command
        // or the last command is not the same as the current command
        // if they both are the same, we still need to seperate them via a space
        if(lastCommand == nil || (lastCommand != nil && lastCommand.instruction != command.instruction)) {
            [string appendFormat:@"%c", command.instruction];
        } else {
            [string appendString:@" "];
        }

        // compresses the floats
        NSString* compressedFloats = IJSVGCompressFloatParameterArray(command.params);
        [string appendString:compressedFloats];

        // store last command
        lastCommand = command;
    }
    return string;
}

+ (NSString*)pathStringFromInstructions:(NSArray<IJSVGExporterPathInstruction*>*)instructions
                   floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    NSMutableArray* pathInstructions = [[NSMutableArray alloc] init];
    for (IJSVGExporterPathInstruction* instruction in instructions) {
        CGFloat* data = instruction.data;
        const char lowerInstruction = tolower(instruction.instruction);
        NSArray<NSString*>* set = nil;
        switch (lowerInstruction) {
        case 't':
        case 'm':
        case 'l': {
            set = @[
                IJSVGShortFloatStringWithOptions(data[0], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[1], floatingPointOptions)
            ];
            break;
        }

        case 'v':
        case 'h': {
            set = @[
                IJSVGShortFloatStringWithOptions(data[0], floatingPointOptions)
            ];
            break;
        }

        case 'c': {
            set = @[
                IJSVGShortFloatStringWithOptions(data[0], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[1], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[2], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[3], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[4], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[5], floatingPointOptions)
            ];
            break;
        }

        case 's':
        case 'q': {
            set = @[
                IJSVGShortFloatStringWithOptions(data[0], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[1], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[2], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[3], floatingPointOptions)
            ];
            break;
        }

        case 'a': {
            set = @[
                IJSVGShortFloatStringWithOptions(data[0], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[1], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[2], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[3], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[4], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[5], floatingPointOptions),
                IJSVGShortFloatStringWithOptions(data[6], floatingPointOptions),
            ];
            break;
        }

            // close path
        case 'z': {
            set = @[];
        }
        }

        // wrap into the command and give to the array
        IJSVGExporterPathInstructionCommand* wrapperCommand = nil;
        wrapperCommand = [[IJSVGExporterPathInstructionCommand alloc] init];
        wrapperCommand.instruction = instruction.instruction;
        wrapperCommand.params = set ?: @[];
        [pathInstructions addObject:wrapperCommand];
    }
    return [self pathStringWithInstructionSet:pathInstructions
                         floatingPointOptions:floatingPointOptions];
}
#endif


CGFloat IJSVGExporterPathFloatToFixed(CGFloat number, int precision)
{
    return floorf(pow(10, precision) * number) / pow(10, precision);
}

void IJSVGExporterPathInstructionRoundData(CGFloat* data, NSInteger length,
    IJSVGFloatingPointOptions options)
{
    for (NSInteger i = length; i-- > 0;) {
        CGFloat d = data[i];
        CGFloat proposed = IJSVGExporterPathFloatToFixed(d, options.precision);
        if(proposed != d) {
            CGFloat rounded = +IJSVGExporterPathFloatToFixed(d, options.precision - 1);
            data[i] = IJSVGExporterPathFloatToFixed(+fabs(rounded - d), options.precision + 1)
                    >= kIJSVGExporterPathInstructionErrorThreshold
                ? +IJSVGExporterPathFloatToFixed(d, options.precision)
                : rounded;
        }
    }
}

#if TARGET_OS_OSX
+ (void)convertInstructionsToRoundRelativeCoordinates:(NSArray<IJSVGExporterPathInstruction*>*)instructions
                                 floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    CGFloat relSubPoint[2] = { 0.f, 0.f };
    for (IJSVGExporterPathInstruction* instruction in instructions) {
        char instructionChar = instruction.instruction;
        NSInteger length = instruction.dataLength;
        CGFloat* data = instruction.data;
        if(strchr("mltqsc", instructionChar) != NULL) {
            for (NSInteger i = length; i--;) {
                data[i] += instruction.base[i % 2] - relSubPoint[i % 2];
            }
        } else if(instructionChar == 'h') {
            data[0] += instruction.base[0] - relSubPoint[0];
        } else if(instructionChar == 'v') {
            data[0] += instruction.base[1] - relSubPoint[1];
        } else if(instructionChar == 'a') {
            data[5] += instruction.base[0] - relSubPoint[0];
            data[5] += instruction.base[1] - relSubPoint[1];
        }
        IJSVGExporterPathInstructionRoundData(data, length, floatingPointOptions);
        if(instructionChar == 'h') {
            relSubPoint[0] += data[0];
        } else if(instructionChar == 'v') {
            relSubPoint[1] += data[0];
        } else {
            relSubPoint[0] += data[length - 2];
            relSubPoint[1] += data[length - 1];
        }
        IJSVGExporterPathInstructionRoundData(relSubPoint, 2, floatingPointOptions);
    }
}

+ (void)convertInstructionsToMixedAbsoluteRelative:(NSArray<IJSVGExporterPathInstruction*>*)instructions
                              floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    IJSVGExporterPathInstruction* prevInstruction = nil;
    for (IJSVGExporterPathInstruction* instruction in instructions) {
        if(prevInstruction == nil || instruction.dataLength == 0) {
            prevInstruction = instruction;
            continue;
        }

        char instructionChar = instruction.instruction;
        CGFloat* data = instruction.data;
        NSInteger length = instruction.dataLength;
        CGFloat* adata = (CGFloat*)malloc(sizeof(CGFloat) * length);
        memcpy(adata, data, sizeof(CGFloat) * length);

        if(strchr("mltqsc", instructionChar) != NULL) {
            for (NSInteger i = length; i--;) {
                adata[i] += instruction.base[i % 2];
            }
        } else if(instructionChar == 'h') {
            adata[0] += instruction.base[0];
        } else if(instructionChar == 'v') {
            adata[0] += instruction.base[1];
        } else if(instructionChar == 'a') {
            adata[5] += instruction.base[0];
            adata[6] += instruction.base[1];
        }

        IJSVGExporterPathInstructionRoundData(adata, length, floatingPointOptions);

        IJSVGExporterPathInstruction* ainstruction = nil;
        ainstruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:instructionChar
                                                                        dataCount:length];
        memcpy(ainstruction.data, adata, sizeof(CGFloat) * length);

        // run these through our default string runner
        // to compare the outputs
        NSString* orig = [self pathStringFromInstructions:@[ instruction ]
                                     floatingPointOptions:floatingPointOptions];
        NSString* comp = [self pathStringFromInstructions:@[ ainstruction ]
                                     floatingPointOptions:floatingPointOptions];

        if(comp.length < orig.length && !(instructionChar == prevInstruction.instruction &&
                                           prevInstruction.instruction > 96 &&
                                           comp.length == orig.length - 1 &&
                                           data[0] < 0.f &&
                                           fmod(prevInstruction.data[prevInstruction.dataLength - 1], 1) != 0.f)) {
            instruction.instruction = toupper(instructionChar);
            memcpy(data, adata, sizeof(CGFloat) * length);
        }
        (void)free(adata), adata = NULL;
        prevInstruction = instruction;
    }
}

+ (void)convertInstructionsDataToRounded:(NSArray<IJSVGExporterPathInstruction*>*)instructions
                    floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    for (IJSVGExporterPathInstruction* instruction in instructions) {
        CGFloat* data = instruction.data;
        IJSVGExporterPathInstructionRoundData(data, instruction.dataLength,
            floatingPointOptions);
    }
}

+ (NSArray<IJSVGExporterPathInstruction*>*)convertInstructionsCurves:(NSArray<IJSVGExporterPathInstruction*>*)instructions
                                                floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    NSMutableArray<IJSVGExporterPathInstruction*>* nInstructions = nil;
    nInstructions = [[NSMutableArray alloc] initWithCapacity:instructions.count];
    IJSVGExporterPathInstruction* lastInstruction = nil;
    for (IJSVGExporterPathInstruction* instruction in instructions) {
        lastInstruction = nInstructions.lastObject;
        if(lastInstruction == nil) {
            [nInstructions addObject:instruction];
            continue;
        }
        if(instruction.instruction == 'c') {
            if(lastInstruction.instruction == 'c' &&
                instruction.data[0] == -(lastInstruction.data[2] - lastInstruction.data[4]) &&
                instruction.data[1] == -(lastInstruction.data[3] - lastInstruction.data[5])) {
                IJSVGExporterPathInstruction* nInstruction = nil;
                nInstruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'s'
                                                                                dataCount:4];
                nInstruction.data[0] = instruction.data[2];
                nInstruction.data[1] = instruction.data[3];
                nInstruction.data[2] = instruction.data[4];
                nInstruction.data[3] = instruction.data[5];
                [nInstructions addObject:nInstruction];
                continue;
            } else if(lastInstruction.instruction == 's' &&
                       instruction.data[0] == -(lastInstruction.data[0] - lastInstruction.data[2]) &&
                       instruction.data[1] == -(lastInstruction.data[1] - lastInstruction.data[3])) {
                IJSVGExporterPathInstruction* nInstruction = nil;
                nInstruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'s'
                                                                                dataCount:4];
                nInstruction.data[0] = instruction.data[2];
                nInstruction.data[1] = instruction.data[3];
                nInstruction.data[2] = instruction.data[4];
                nInstruction.data[3] = instruction.data[5];
                [nInstructions addObject:nInstruction];
                continue;
            } else if(lastInstruction.instruction != 'c' &&
                       lastInstruction.instruction != 's' &&
                       instruction.data[0] == 0.f && instruction.data[1] == 0.f) {
                IJSVGExporterPathInstruction* nInstruction = nil;
                nInstruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'s'
                                                                                dataCount:4];
                nInstruction.data[0] = instruction.data[2];
                nInstruction.data[1] = instruction.data[3];
                nInstruction.data[2] = instruction.data[4];
                nInstruction.data[3] = instruction.data[5];
                [nInstructions addObject:nInstruction];
                continue;
            }
        } else if(instruction.instruction == 'q') {
            if(lastInstruction.instruction == 'q' &&
                instruction.data[0] == (lastInstruction.data[2] - lastInstruction.data[0]) &&
                instruction.data[1] == (lastInstruction.data[3] - lastInstruction.data[1])) {
                IJSVGExporterPathInstruction* nInstruction = nil;
                nInstruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'t'
                                                                                dataCount:2];
                nInstruction.data[0] = instruction.data[2];
                nInstruction.data[1] = instruction.data[3];
                [nInstructions addObject:nInstruction];
                continue;
            } else if(lastInstruction.instruction == 't' &&
                       instruction.data[2] == lastInstruction.data[0] &&
                       instruction.data[3] == lastInstruction.data[1]) {
                IJSVGExporterPathInstruction* nInstruction = nil;
                nInstruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'t'
                                                                                dataCount:2];
                nInstruction.data[0] = instruction.data[2];
                nInstruction.data[1] = instruction.data[3];
                [nInstructions addObject:nInstruction];
                continue;
            }
        }
        [nInstructions addObject:instruction];
    }
    return nInstructions;
}

+ (void)convertInstructionsToRelativeCoordinates:(NSArray<IJSVGExporterPathInstruction*>*)instructions
                            floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{
    CGFloat start[2] = {0, 0};
    CGFloat cursor[2] = {0, 0};
    CGFloat prevCoords[2] = {0, 0};

    NSInteger index = 0;
    for (IJSVGExporterPathInstruction* anInstruction in instructions) {
        char instruction = anInstruction.instruction;
        CGFloat* data = anInstruction.data;
        CGFloat* base = anInstruction.base;
        CGFloat* coords = anInstruction.coords;
        
        switch(instruction) {
            case 'm': {
                cursor[0] += data[0];
                cursor[1] += data[1];
                start[0] = cursor[0];
                start[1] = cursor[1];
                break;
            }
            case 'M': {
                if(index != 0) {
                    instruction = 'm';
                }
                data[0] -= cursor[0];
                data[1] -= cursor[1];
                cursor[0] += data[0];
                cursor[1] += data[1];
                start[0] = cursor[0];
                start[1] = cursor[1];
                break;
            }
            case 'l': {
                cursor[0] += data[0];
                cursor[1] += data[1];
                break;
            }
            case 'L': {
                instruction = 'l';
                data[0] -= cursor[0];
                data[1] -= cursor[1];
                cursor[0] += data[0];
                cursor[1] += data[1];
                break;
            }
            case 'h': {
                cursor[0] += data[0];
                break;
            }
            case 'H': {
                instruction = 'h';
                data[0] -= cursor[0];
                cursor[0] += data[0];
                break;
            }
            case 'v': {
                cursor[1] += data[0];
                break;
            }
            case 'V': {
                instruction = 'v';
                data[0] -= cursor[1];
                cursor[1] += data[0];
                break;
            }
            case 'c': {
                cursor[0] += data[4];
                cursor[1] += data[5];
                break;
            }
            case 'C': {
                instruction = 'c';
                data[0] -= cursor[0];
                data[1] -= cursor[1];
                data[2] -= cursor[0];
                data[3] -= cursor[1];
                data[4] -= cursor[0];
                data[5] -= cursor[1];
                cursor[0] += data[4];
                cursor[1] += data[5];
                break;
            }
            case 's': {
                cursor[0] += data[2];
                cursor[1] += data[3];
                break;
            }
            case 'S': {
                instruction = 's';
                data[0] -= cursor[0];
                data[1] -= cursor[1];
                data[2] -= cursor[0];
                data[3] -= cursor[1];
                cursor[0] += data[2];
                cursor[1] += data[3];
                break;
            }
            case 'q': {
                cursor[0] += data[2];
                cursor[1] += data[3];
                break;
            }
            case 'Q': {
                instruction = 'q';
                data[0] -= cursor[0];
                data[1] -= cursor[1];
                data[2] -= cursor[0];
                data[3] -= cursor[1];
                cursor[0] += data[2];
                cursor[1] += data[3];
                break;
            }
            case 't': {
                cursor[0] += data[0];
                cursor[1] += data[1];
                break;
            }
            case 'T': {
                instruction = 't';
                data[0] -= cursor[0];
                data[1] -= cursor[1];
                cursor[0] += data[0];
                cursor[1] += data[1];
                break;
            }
            case 'a': {
                cursor[0] += data[5];
                cursor[1] += data[6];
                break;
            }
            case 'A': {
                instruction = 'a';
                data[5] -= cursor[0];
                data[6] -= cursor[1];
                cursor[0] += data[5];
                cursor[1] += data[6];
                break;
            }
            case 'Z':
            case 'z': {
                cursor[0] = start[0];
                cursor[1] = start[1];
                break;
            }
        }

        // set the instruction back
        anInstruction.instruction = instruction;
        base[0] = prevCoords[0];
        base[1] = prevCoords[1];
        coords[0] = cursor[0];
        coords[1] = cursor[1];
        prevCoords[0] = cursor[0];
        prevCoords[1] = cursor[1];
        index++;
    }
}

+ (NSArray<IJSVGExporterPathInstruction*>*)instructionsFromPath:(CGPathRef)path
                                           floatingPointOptions:(IJSVGFloatingPointOptions)floatingPointOptions
{

    // keep track of the current point
    __block CGPoint currentPoint = CGPointZero;
    NSMutableArray* instructions = [[NSMutableArray alloc] init];

    // create the path callback
    IJSVGCGPathHandler callback = ^(const CGPathElement* pathElement) {
        IJSVGExporterPathInstruction* instruction = nil;
        // work out what to do
        switch (pathElement->type) {

        case kCGPathElementMoveToPoint: {
            // move to command
            instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'M'
                                                                           dataCount:2];
            CGPoint point = pathElement->points[0];
            instruction.data[0] = point.x;
            instruction.data[1] = point.y;
            currentPoint = point;

            [instructions addObject:instruction];
            break;
        }

        case kCGPathElementAddLineToPoint: {
            // line to command
            CGPoint point = pathElement->points[0];
            if(point.x == currentPoint.x) {
                instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'V'
                                                                               dataCount:1];
                instruction.data[0] = point.y;
            } else if(point.y == currentPoint.y) {
                instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'H'
                                                                               dataCount:1];
                instruction.data[0] = point.x;
            } else {
                instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'L'
                                                                               dataCount:2];
                instruction.data[0] = point.x;
                instruction.data[1] = point.y;
            }
            currentPoint = point;

            [instructions addObject:instruction];
            break;
        }

        case kCGPathElementAddQuadCurveToPoint: {
            // quad curve to command
            CGPoint controlPoint = pathElement->points[0];
            CGPoint point = pathElement->points[1];
            instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'Q'
                                                                           dataCount:4];
            instruction.data[0] = controlPoint.x;
            instruction.data[1] = controlPoint.y;
            instruction.data[2] = point.x;
            instruction.data[3] = point.y;
            currentPoint = point;

            [instructions addObject:instruction];
            break;
        }

        case kCGPathElementAddCurveToPoint: {
            // curve to command
            CGPoint controlPoint1 = pathElement->points[0];
            CGPoint controlPoint2 = pathElement->points[1];
            CGPoint point = pathElement->points[2];

            currentPoint = point;
            instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'C'
                                                                           dataCount:6];
            instruction.data[0] = controlPoint1.x;
            instruction.data[1] = controlPoint1.y;
            instruction.data[2] = controlPoint2.x;
            instruction.data[3] = controlPoint2.y;
            instruction.data[4] = point.x;
            instruction.data[5] = point.y;

            [instructions addObject:instruction];
            break;
        }

        case kCGPathElementCloseSubpath: {
            // close command
            instruction = [[IJSVGExporterPathInstruction alloc] initWithInstruction:'Z'
                                                                           dataCount:0];
            [instructions addObject:instruction];
            break;
        }
        }
    };

    // apply the
    CGPathApply(path, (__bridge void*)callback, IJSVGExporterPathCaller);

    // remove last instruction if it was Z -> M
    IJSVGExporterPathInstruction* lastInstruction = instructions.lastObject;
    if(lastInstruction.instruction == 'M' || lastInstruction.instruction == 'm') {
        if(instructions.count >= 2) {
            NSInteger index = [instructions indexOfObject:lastInstruction] - 1;
            IJSVGExporterPathInstruction* prevInstruction = instructions[index];
            if(prevInstruction.instruction == 'z' || prevInstruction.instruction == 'Z') {
                [instructions removeLastObject];
            }
        }
    }

    return instructions;
}

@end

#endif
