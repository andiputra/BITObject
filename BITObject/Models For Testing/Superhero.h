//
//  Superhero.h
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Superhero : NSObject

@property (strong, nonatomic) NSString *name;
@property (unsafe_unretained, nonatomic) NSInteger age;
@property (unsafe_unretained, nonatomic) BOOL isDead;
@property (strong, nonatomic) NSArray *powers;

@end
