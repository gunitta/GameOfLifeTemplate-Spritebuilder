//
//  Grid.h
//  GameOfLife
//
//  Created by Gulnaz Iskakova on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Creature.h"
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@interface Grid : CCSprite
@property (nonatomic, assign) int totalAlive;
@property (nonatomic,assign) int generation;
- (void)countNeighbors;
- (void)updateCreatures;
- (void)evolveStep;
- (void)onEnter;
- (void)setupGrid;
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition;


@end
