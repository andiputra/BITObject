//
//  JusticeLeague.m
//  BITObject
//
//  Created by Andi Putra on 9/10/12.
//  Copyright (c) 2012 Andi Putra. All rights reserved.
//

#import "JusticeLeague.h"

@implementation JusticeLeague
@synthesize superheros = _superheros;

- (void)dealloc
{
    [_superheros release], _superheros = nil;
    [super dealloc];
}

@end
