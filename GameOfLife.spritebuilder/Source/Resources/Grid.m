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



@implementation Grid
{
    NSMutableArray *_gridArray;//this is the private variable 2d array that will store all the creatures
    // on the grid
    float _cellWidth;
    float _cellHeight;
}
- (void)onEnter
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


- (void)setupGrid
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

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //get the x, y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    //get the the Creature at the location
    Creature *creature = [self creatureForTouchPosition: touchLocation];
    
    //we should kill of it is alive and bring to life id it is dead
    creature.isAlive = !creature.isAlive;
    

}
- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    NSLog(@"Error here beginning");
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    
    NSLog(@"Error here");
    
    //get the row that was touched and return the Greature on it
    return _gridArray[row][column];
}
- (void)evolveStep
{
    //update each Creature's neighbor count
    [self countNeighbors];
    
    //update each Creature's state
    [self updateCreatures];
    
    //update the generation so the label's text will display the correct generation
    _generation++;
}
-(void)countNeighbors
{
    // iterate through the rows
    // note that NSArray has a method 'count' that will return the number of elements in the array
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            currentCreature.livingNeighbors = 0;
            
            // now examine every cell around the current one
            
            // go through the row on top of the current cell, the row the cell is in, and the row past the current cell
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to the left of the current cell, the column the cell is in, and the column to the right of the current cell
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check that the cell we're checking isn't off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    // skip over all cells that are off screen AND the cell that contains the creature we are currently updating
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
        }
    }
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}
-(void)updateCreatures
{
    int numAlive = 0;
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            if(currentCreature.livingNeighbors == 3)
            {
                currentCreature.isAlive = YES;
                numAlive++;
            
            }
            else{
                currentCreature.isAlive = NO;
            }
            
        }
    }
    _totalAlive = numAlive;
}
@end
