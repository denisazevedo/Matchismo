//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 17/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger lastScore;
@property (nonatomic) NSUInteger numberOfMatchingCards;
@property (nonatomic, readonly) NSArray *lastChosenCards;

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;

@end
