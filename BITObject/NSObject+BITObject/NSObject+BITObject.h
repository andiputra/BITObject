//
//  NSObject+BITObject.h
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BITObject)

/** Set the properties of an object with values from the dictionary. This convention is applied; All class names will be singularize and all the names of properties that are arrays will be pluralize.
 *
 *  @param dictionary
 *  The dictionary that will be converted into objects.
 *
 *  @param shouldIgnore
 *  If shouldIgnore is YES, dictionary keys that do not have its correlated properties will be ignored. If shouldIgnore is NO, dictionary keys that do not have its correlated properties will throw an exception.
 */
- (void)setPropertyValuesWithDictionary:(NSDictionary *)dictionary ignoreMissingPropertyNames:(BOOL)shouldIgnore;

@end
