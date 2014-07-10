//
//  Grid.h
//  GameOfLife
//
//  Created by Gulnaz Iskakova on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Creature.h"
@interface Grid : CCSprite
@property (nonatomic, assign) int totalAlive;
@property (nonatomic,assign) int generation;
@end
