//
//  Power.m
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "Power.h"

@implementation Power
@synthesize name = _name;
@synthesize elements = _elements;

- (void)dealloc
{
    [_name release], _name = nil;
    [_elements release], _elements = nil;
    [super dealloc];
}

@end
