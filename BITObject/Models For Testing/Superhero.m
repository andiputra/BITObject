//
//  Superhero.m
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "Superhero.h"

@implementation Superhero
@synthesize name = _name;
@synthesize age = _age;
@synthesize isDead = _isDead;
@synthesize powers = _powers;

- (void)dealloc
{
    [_name release], _name = nil;
    [_powers release], _powers = nil;
    [super dealloc];
}


@end
