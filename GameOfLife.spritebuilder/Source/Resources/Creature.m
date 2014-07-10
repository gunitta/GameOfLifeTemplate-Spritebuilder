//
//  Creature.m
//  GameOfLife
//
//  Created by Gulnaz Iskakova on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature
-(instancetype)initCreature{
    //Creature inherit from CCSprite, so 'super' refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    if(self)
    {
        self.isAlive = NO;

    }
    return self;
}
-(void)setIsAlive:(BOOL)newState
{
    //when you create an @property as we did in the .h, an instance variable
    //with leading underscore is created for you
    
    _isAlive = newState;
    
    //'visible' is a property pf any class tat inherits from CCnode. CCSprite
    // is a subclass of the node CCNode, and Creature is a subclass of the CCSprite
    //so creatures have visible property
    
    self.visible = _isAlive;
    
    //when we set the Creature to be alive it will become visible, when we set it to be dead it will
    //just dispappear
}
@end
