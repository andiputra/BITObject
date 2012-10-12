//
//  NSObject+BITObject.m
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "NSObject+BITObject.h"
#import <objc/runtime.h>
#import "NSString+Extension.h"

#define BIT_OBJ_NO_PROPERTY     @"BITObject:PropertyWithNameUnavailable"

@implementation NSObject (BITObject)

#pragma mark - Private Methods

- (void)throwPropertyWithNameUnavailableException:(NSString *)name forClassNamed:(NSString *)className
{
    [NSException raise:BIT_OBJ_NO_PROPERTY
                format:@"Property %@ doesn't exist for %@ class.", name, className];
}

/** Check if property with a particular name is available for the class.
 */
- (BOOL)isPropertyAvailableWithName:(NSString *)name
{
    objc_property_t property = class_getProperty([self class], [name cStringUsingEncoding:NSASCIIStringEncoding]);
    if (property && property != NULL) {
        return YES;
    }
    
    return NO;
}

/** Returns an instance of a class, then set its property with values from the dictionary param.
 */
- (id)classInstanceFromDictionary:(NSDictionary *)dictionary withClassName:(NSString *)className ignoreMissingPropertyNames:(BOOL)shouldIgnore
{
    // Create new instance of the class
    // Make sure class name is always in singular form
    id classInstance = [[[NSClassFromString(className) alloc] init] autorelease];
    [classInstance setPropertyValuesWithDictionary:dictionary ignoreMissingPropertyNames:shouldIgnore];
    return classInstance;
}

/** Returns an array of class instances or base objects, like NSDictionary or NSString.
 */
- (NSArray *)arrayOfObjectsFromArray:(NSArray *)array withClassName:(NSString *)className ignoreMissingPropertyNames:(BOOL)shouldIgnore
{
    NSMutableArray *temp = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSArray class]]) {
            // Currently not handling array within array - multidimensional array
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            id classInstance = [self classInstanceFromDictionary:obj withClassName:className ignoreMissingPropertyNames:shouldIgnore];
            [temp addObject:classInstance];
        } else {
            [temp addObject:obj];
        }
        
    }];
    
    return [[temp copy] autorelease];
}

#pragma mark - Public Methods

- (void)setPropertyValuesWithDictionary:(NSDictionary *)dictionary ignoreMissingPropertyNames:(BOOL)shouldIgnore
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *propertyName = [key lowercaseFirstCharacter]; // Lowercase the first character of the key to use it as property name.
        NSString *className = [[key uppercaseFirstCharacter] singularize];
        
        if ([obj isKindOfClass:[NSArray class]]) {
            
            propertyName = [propertyName pluralize];
            
            if ([self isPropertyAvailableWithName:propertyName]) {
                
                NSArray *temp = [self arrayOfObjectsFromArray:obj withClassName:className ignoreMissingPropertyNames:shouldIgnore];  // Singularize class name
                [self setValue:temp forKey:propertyName];   // Pluralize array property name
                
            } else {
                
                if (!shouldIgnore) {
                    [self throwPropertyWithNameUnavailableException:propertyName forClassNamed:className];
                }
                
            }
            
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            if ([self isPropertyAvailableWithName:propertyName]) {
                
                id classInstance = [self classInstanceFromDictionary:obj withClassName:className ignoreMissingPropertyNames:shouldIgnore];   // Singularize class name
                [self setValue:classInstance forKey:propertyName];
                
            } else {
                
                if (!shouldIgnore) {
                    [self throwPropertyWithNameUnavailableException:propertyName forClassNamed:className];
                }
                
            }
            
        } else {
            
            if ([self isPropertyAvailableWithName:propertyName]) {
                
                [self setValue:obj forKey:propertyName];
                
            } else {
                
                if (!shouldIgnore) {
                    [self throwPropertyWithNameUnavailableException:propertyName forClassNamed:className];
                }
                
            }
            
        }
        
    }];
}

@end
