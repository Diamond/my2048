//
//  Tile.m
//  my2048
//
//  Created by Brandon Richey on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tile.h"

@implementation Tile {
    CCLabelTTF *_valueLabel;
    CCNodeColor *_backgroundNode;
}

-(id)init {
    self = [super init];
    if (self) {
        self.value = (arc4random() % 2 + 1) * 2;
    }
    return self;
}

-(void)updateValueDisplay {
    _valueLabel.string = [NSString stringWithFormat:@"%d",self.value];
}

-(void)didLoadFromCCB {
    [self updateValueDisplay];
}

@end
