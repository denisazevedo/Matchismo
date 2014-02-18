//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 24/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    self.gameType = @"Playing Cards";
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.numberOfMatchingCards = 2;
    [self updateUI];
}

- (void)refreshFlipResult {
    
    int lastScore = self.game.lastScore;
    NSString *lastResult = @"";
    
    if ([self.game.lastChosenCards count]) {
        lastResult = [self.game.lastChosenCards componentsJoinedByString:@""];
        
        if (lastScore > 0) {
            lastResult = [NSString stringWithFormat:@"Matched %@ for %d points.", lastResult, lastScore];
        } else if (lastScore < 0){
            lastResult = [NSString stringWithFormat:@"%@ don't match! %d points penalty!", lastResult, lastScore];
        }
    }
    [self updateFlipResult:[[NSAttributedString alloc] initWithString:lastResult]];
}

@end
