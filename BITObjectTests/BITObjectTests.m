//
//  BITObjectTests.m
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "BITObjectTests.h"
#import "NSObject+BITObject.h"

#import "JusticeLeague.h"
#import "Superhero.h"
#import "Power.h"

@implementation BITObjectTests

- (void)testSetPropertyValuesWithDictionaryCompletion
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Superheroes" ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:file];
    STAssertNotNil([dictionary objectForKey:@"superheros"], nil);
    STAssertTrue([[dictionary objectForKey:@"superheros"] isKindOfClass:[NSArray class]], nil);
    
    NSArray *superherosDict = [dictionary objectForKey:@"superheros"];
    NSDictionary *batmanDict = [superherosDict objectAtIndex:0];
    
    JusticeLeague *league = [[JusticeLeague alloc] init];
    STAssertNotNil(league, nil);
    [league setPropertyValuesWithDictionary:dictionary ignoreMissingPropertyNames:YES];
    STAssertTrue([league.superheros count] == 2, nil);
    
    NSArray *superheros = [league superheros];
    Superhero *batman = [superheros objectAtIndex:0];
    
    STAssertTrue([[batman name] isEqualToString:[batmanDict objectForKey:@"name"]], nil);
    STAssertTrue([batman age] == 35, nil);
    STAssertTrue([batman isDead] == YES, nil);
    STAssertTrue([batman.powers count] == 2, nil);
    
    NSArray *powersDict = [batmanDict objectForKey:@"powers"];
    NSDictionary *batmobileDict = [powersDict objectAtIndex:0];
    NSDictionary *batarangDict = [powersDict lastObject];
    
    NSArray *powers = [batman powers];
    Power *batmobile = [powers objectAtIndex:0];
    Power *batarang = [powers lastObject];
    
    STAssertTrue([[batmobile name] isEqualToString:[batmobileDict objectForKey:@"name"]], nil);
    STAssertTrue([[batarang name] isEqualToString:[batarangDict objectForKey:@"name"]], nil);
    STAssertTrue([batmobile.elements count] == 2, nil);
    STAssertTrue([batarang.elements count] == 1, nil);
    
    [league release];
}

@end
