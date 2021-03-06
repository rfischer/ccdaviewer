/********************************************************************************
 * The MIT License (MIT)                                                        *
 *                                                                              *
 * Copyright (C) 2016 Alex Nolasco                                              *
 *                                                                              *
 *Permission is hereby granted, free of charge, to any person obtaining a copy  *
 *of this software and associated documentation files (the "Software"), to deal *
 *in the Software without restriction, including without limitation the rights  *
 *to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     *
 *copies of the Software, and to permit persons to whom the Software is         *
 *furnished to do so, subject to the following conditions:                      *
 *The above copyright notice and this permission notice shall be included in    *
 *all copies or substantial portions of the Software.                           *
 *                                                                              *
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    *
 *IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      *
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   *
 *AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        *
 *LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, *
 *OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     *
 *THE SOFTWARE.                                                                 *
 *********************************************************************************/


#import "HL7ResultSummaryEntry_Private.h"
#import "HL7SummaryEntry_private.h"
#import "HL7ResultEntry.h"
#import "HL7ResultObservation.h"
#import "HL7ResultOrganizer.h"
#import "HL7Code.h"
#import "HL7Value.h"
#import "HL7EffectiveTime.h"
#import "HL7InterpretationCode.h"
#import "HL7ResultReferenceRange.h"
#import "HL7CodeSummary_Private.h"

@implementation HL7ResultSummaryEntry

- (instancetype _Nonnull)initWithObservation:(HL7ResultObservation *_Nonnull)observation
{
    if (self = [super init]) {    
        [super setNarrative:[[[observation code] displayName] copy]];
        _value = [[observation value] value];
        _units = [[observation value] unit];
        _date = [[observation effectiveTime] valueAsNSDate];
        _interpretation = [[observation firstInterpretationCode] displayName];
        _range = [[observation firstReferenceRange] observationRangeAsString];
        _code = [[HL7CodeSummary alloc] initWithCode:observation.code];
        _resultRange = HL7ResultRangeUnknown;
    }
    return self;
}

#pragma mark NSCopying
- (id)copyWithZone:(nullable NSZone *)zone
{
    HL7ResultSummaryEntry *clone = [super copyWithZone:zone];
    [clone setValue:self.value];
    [clone setUnits:self.units];
    [clone setRange:self.range];
    [clone setDate:self.date];
    [clone setInterpretation:self.interpretation];
    [clone setCode:self.code];
    [clone setResultRange:self.resultRange];
    return clone;
}

#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super initWithCoder:decoder])) {
        [self setValue:[decoder decodeObjectForKey:@"value"]];
        [self setUnits:[decoder decodeObjectForKey:@"units"]];
        [self setRange:[decoder decodeObjectForKey:@"range"]];
        [self setDate:[decoder decodeObjectForKey:@"date"]];
        [self setInterpretation:[decoder decodeObjectForKey:@"interpretation"]];
        [self setCode:[decoder decodeObjectForKey:@"code"]];
        [self setResultRange:[decoder decodeIntegerForKey:@"resultRange"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:[self value] forKey:@"value"];
    [encoder encodeObject:[self units] forKey:@"units"];
    [encoder encodeObject:[self range] forKey:@"range"];
    [encoder encodeObject:[self date] forKey:@"date"];
    [encoder encodeObject:[self interpretation] forKey:@"interpretation"];
    [encoder encodeObject:[self code] forKey:@"code"];
    [encoder encodeInteger:[self resultRange] forKey:@"resultRange"];
}
@end
