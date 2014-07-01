//
//  Grid.m
//  my2048
//
//  Created by Brandon Richey on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"

@implementation Grid {
    CGFloat _columnWidth;
    CGFloat _columnHeight;
    CGFloat _tileMarginVertical;
    CGFloat _tileMarginHorizontal;
}
static const NSInteger GRID_SIZE = 4;

-(void)setupBackground
{
    CCNode *tile = [CCBReader load:@"Tile"];
    _columnWidth = tile.contentSize.width;
    _columnHeight = tile.contentSize.height;
    [tile performSelector:@selector(cleanup)];
    
    _tileMarginHorizontal = (self.contentSize.width - (GRID_SIZE * _columnWidth)) / (GRID_SIZE + 1);
    _tileMarginVertical   = (self.contentSize.height - (GRID_SIZE * _columnHeight)) / (GRID_SIZE + 1);
    float x = _tileMarginHorizontal;
    float y = _tileMarginVertical;
    
    for (int i = 0; i < GRID_SIZE; i++) {
        x = _tileMarginHorizontal;
        for (int j = 0; j < GRID_SIZE; j++) {
            CCNode *backgroundTile = [CCNodeColor nodeWithColor:[CCColor grayColor]];
            backgroundTile.contentSize = CGSizeMake(_columnWidth, _columnHeight);
            backgroundTile.position = ccp(x, y);
            [self addChild:backgroundTile];
            x += _columnWidth + _tileMarginHorizontal;
        }
        y += _columnHeight * _tileMarginVertical;
    }
}

-(void)didLoadFromCCB
{
    [self setupBackground];
}

@end
