//
//  GameEnd.m
//  my2048
//
//  Created by Brandon Richey on 7/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEnd.h"

@implementation GameEnd {
    CCLabelTTF *_messageLabel;
    CCLabelTTF *_scoreLabel;
}

-(void)newGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void)setMessage:(NSString *)message score:(NSInteger)score
{
    _messageLabel.string = message;
    _scoreLabel.string = [NSString stringWithFormat:@"%d",score];
}

@end
