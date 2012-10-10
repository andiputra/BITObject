//
//  NSStringExtensionTests.m
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "NSStringExtensionTests.h"
#import "NSString+Extension.h"

@implementation NSStringExtensionTests

- (void)testLowercaseFirstCharacter
{
    NSString *string = @"ILoveYou";
    string = [string lowercaseFirstCharacter];
    STAssertTrue([string isEqualToString:@"iLoveYou"], @"%@ should be iLoveYou", string);
}

- (void)testUppercaseFirstCharacter
{
    NSString *string = @"whoMovedMyCheese";
    string = [string uppercaseFirstCharacter];
    STAssertTrue([string isEqualToString:@"WhoMovedMyCheese"], @"%@ should be WhoMovedMyCheese", string);
}

- (void)testPluralize
{
    NSString *string = @"apple";
    string = [string pluralize];
    STAssertTrue([string isEqualToString:@"apples"], @"%@ should be apples", string);
}

- (void)testSingularize
{
    NSString *string = @"oranges";
    string = [string singularize];
    STAssertTrue([string isEqualToString:@"orange"], @"%@ should be orange", string);
}

@end
