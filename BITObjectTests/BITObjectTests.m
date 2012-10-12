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

@interface BITObjectTests ()
@property (strong, nonatomic) NSDictionary *superherosDictionary;
@end

@implementation BITObjectTests
@synthesize superherosDictionary = _superherosDictionary;

- (void)setUp
{
    [super setUp];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Superheroes" ofType:@"plist"];
    self.superherosDictionary = [NSDictionary dictionaryWithContentsOfFile:file];
    STAssertNotNil([_superherosDictionary objectForKey:@"superheros"], nil);
    STAssertTrue([[_superherosDictionary objectForKey:@"superheros"] isKindOfClass:[NSArray class]], nil);
}

- (void)tearDown
{
    [_superherosDictionary release], _superherosDictionary = nil;
    [super tearDown];
}

- (void)testSetPropertyValuesWithDictionaryCompletion_IgnoreMissingPropertyValueIsYES
{
    NSArray *superherosDict = [_superherosDictionary objectForKey:@"superheros"];
    NSDictionary *batmanDict = [superherosDict objectAtIndex:0];
    
    JusticeLeague *league = [[JusticeLeague alloc] init];
    STAssertNotNil(league, nil);
    [league setPropertyValuesWithDictionary:_superherosDictionary ignoreMissingPropertyNames:YES];
    
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

- (void)testSetPropertyValuesWithDictionaryCompletion_IgnoreMissingPropertyValueIsNO
{
    JusticeLeague *league = [[JusticeLeague alloc] init];
    STAssertNotNil(league, nil);
    STAssertThrows([league setPropertyValuesWithDictionary:_superherosDictionary ignoreMissingPropertyNames:NO], nil);
    [league release];
}

@end
