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

@implementation NSObject (BITObject)

#pragma mark - Private Methods

- (NSException *)throwPropertyWithNameUnavailableException:(NSString *)name
{
    return [NSException exceptionWithName:@"BITObject:PropertyWithNameUnavailable"
                                   reason:[NSString stringWithFormat:@"Property with name: %@ doesn't exist.", name]
                                 userInfo:nil];
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

/** Set a value to the object's property, by checking if the property exists first. If it doesn't, throws an exception.
 */
- (void)setPropertyWithName:(NSString *)name withValue:(id)object ignoreMissingPropertyNames:(BOOL)shouldIgnore
{
    if ([self isPropertyAvailableWithName:name]) {
        [self setValue:object forKey:name];
    } else {
        if (!shouldIgnore) {
            [self throwPropertyWithNameUnavailableException:name];
        }
    }
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
                    [self throwPropertyWithNameUnavailableException:propertyName];
                }
                
            }
            
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            if ([self isPropertyAvailableWithName:propertyName]) {
                
                id classInstance = [self classInstanceFromDictionary:obj withClassName:className ignoreMissingPropertyNames:shouldIgnore];   // Singularize class name
                [self setValue:classInstance forKey:propertyName];
                
            } else {
                
                if (!shouldIgnore) {
                    [self throwPropertyWithNameUnavailableException:propertyName];
                }
                
            }
            
        } else {
            
            [self setPropertyWithName:propertyName withValue:obj ignoreMissingPropertyNames:shouldIgnore];
            
        }
        
    }];
}

@end
