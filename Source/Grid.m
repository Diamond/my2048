//
//  Grid.m
//  my2048
//
//  Created by Brandon Richey on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Tile.h"

@implementation Grid {
    CGFloat _columnWidth;
    CGFloat _columnHeight;
    CGFloat _tileMarginVertical;
    CGFloat _tileMarginHorizontal;
    
    NSMutableArray *_gridArray;
    NSNull         *_noTile;
}
static const NSInteger GRID_SIZE   = 4;
static const NSInteger START_TILES = 2;

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
        y += _columnHeight + _tileMarginVertical;
    }
}

-(void)didLoadFromCCB
{
    [self setupBackground];
    
    _noTile = [NSNull null];
    _gridArray = [NSMutableArray array];
    for (int i = 0; i < GRID_SIZE; i++) {
        _gridArray[i] = [NSMutableArray array];
        for (int j = 0; j < GRID_SIZE; j++) {
            _gridArray[i][j] = _noTile;
        }
    }
    [self spawnStartTiles];
}

-(CGPoint)positionForColumn:(NSInteger)column row:(NSInteger)row {
    NSInteger x = _tileMarginHorizontal + column * (_tileMarginHorizontal + _columnWidth);
    NSInteger y = _tileMarginVertical   + row    * (_tileMarginVertical   + _columnHeight);
    return CGPointMake(x,y);
}

-(void)addTileAtColumn:(NSInteger)column row:(NSInteger)row {
    Tile *tile = (Tile*)[CCBReader load:@"Tile"];
    _gridArray[column][row] = tile;
    tile.scale = 0.0f;
    [self addChild:tile];
    
    tile.position = [self positionForColumn:column row:row];
    CCActionDelay    *delay    = [CCActionDelay actionWithDuration:0.3f];
    CCActionScaleTo  *scaleUp  = [CCActionScaleTo actionWithDuration:0.2f scale:1.0f];
    CCActionSequence *sequence = [CCActionSequence actionWithArray:@[delay,scaleUp]];
    [tile runAction:sequence];
}

-(void)spawnRandomTile {
    BOOL spawned = FALSE;
    while (!spawned) {
        NSInteger randomRow = arc4random() % GRID_SIZE;
        NSInteger randomColumn = arc4random() % GRID_SIZE;
        
        BOOL positionFree = (_gridArray[randomColumn][randomRow] == _noTile);
        if (positionFree) {
            [self addTileAtColumn:randomColumn row:randomRow];
            spawned = TRUE;
        }
    }
}

-(void)spawnStartTiles {
    for (int i = 0; i < START_TILES; i++) {
        [self spawnRandomTile];
    }
}

@end
