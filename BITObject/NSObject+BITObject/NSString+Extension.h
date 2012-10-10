//
//  NSString+Extension.h
//  MobileTeacher
//
//  Created by Andi Putra on 29/05/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)lowercaseFirstCharacter;
- (NSString *)uppercaseFirstCharacter;
- (NSString *)pluralize;
- (NSString *)singularize;

@end
