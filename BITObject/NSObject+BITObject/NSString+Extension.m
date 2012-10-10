//
//  NSString+Extension.m
//  MobileTeacher
//
//  Created by Andi Putra on 29/05/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "NSString+Extension.h"
#import "ActiveSupportInflector.h"

static ActiveSupportInflector *__ACInflector = nil;

@implementation NSString (Extension)

- (NSString *)stringWithFirstCharacterLowercased:(BOOL)lowercased
{
    NSString *firstCharacter = [self substringToIndex:1];
    if (lowercased) {
        firstCharacter = [firstCharacter lowercaseString];
    } else {
        firstCharacter = [firstCharacter uppercaseString];
    }
    NSString *remainingString = [self substringFromIndex:1];
    return [NSString stringWithFormat:@"%@%@", firstCharacter, remainingString];
}

- (NSString *)lowercaseFirstCharacter
{
    return [self stringWithFirstCharacterLowercased:YES];
}

- (NSString *)uppercaseFirstCharacter
{
    return [self stringWithFirstCharacterLowercased:NO];
}

- (NSString *)singularize
{
    if (!__ACInflector) {
        __ACInflector = [[ActiveSupportInflector alloc] init];
    }
    return [__ACInflector singularize:self];
}

- (NSString *)pluralize
{
    if (!__ACInflector) {
        __ACInflector = [[ActiveSupportInflector alloc] init];
    }
    return [__ACInflector pluralize:self];
}

@end
