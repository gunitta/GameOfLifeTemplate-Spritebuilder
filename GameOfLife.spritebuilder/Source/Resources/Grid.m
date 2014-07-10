//
//  Grid.m
//  GameOfLife
//
//  Created by Gulnaz Iskakova on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h" //we inport it because we will be creting creatures.
//now we declare the vriable that cannot be changed
//we define two constants that define the rows and the colums
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;


@implementation Grid
{
    NSMutableArray *_gridArray;//this is the private variable 2d array that will store all the creatures
    // on the grid
    float _cellWidth;
    float _cellHeight;
}
-(void)onEnter
{
    [super onEnter];
    [self setupGrid];
    //accept touches on grid
    self.userInteractionEnabled = YES;
    
}

//first we calculate the size of _cellHeight and _cellWidth by dividing the
//size of the grid by the aount of rows and columns.
//array will hold the creatures in the grid
//then in two nested loops we fill the gri with the creatures


-(void)setupGrid
{
    //divide the grid's size by the nu,ner of columns/row to figure out
    //right height and width ofech cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array]; //inititalize the blank array
    //initialize creatures
    for(int i = 0; i <  GRID_ROWS; i++)
    {
        //creating the 2d array inObj-C
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j< GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature] ;
            
            _gridArray[i][j] = creature;
            //creature.isAlive = YES;
            x+=_cellWidth;
        
        }
        y+=_cellHeight;
    }
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //get the x, y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    //get the the Creature at the location
    Creature *creature = [self creatureForTouchPosition: touchLocation];
    
    //we should kill of it is alive and bring to life id it is dead
    creature.isAlive = !creature.isAlive;
    

}
-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    int row = touchPosition.y;
    int column = touchPosition.x;
    
    //get the row that was touched and return the Greature on it
    return _gridArray[row][column];
}
@end
