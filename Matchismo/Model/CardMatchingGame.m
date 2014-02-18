//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 17/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score; //readwrite to show we are redeclaring
@property (nonatomic, readwrite) NSInteger lastScore; //readwrite to show we are redeclaring
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, readwrite) NSArray *lastChosenCards;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

//Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {

    self = [self init]; //super's designated initializer
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSMutableArray *)cards { //Lazy instantiation of cards
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger)numberOfMatchingCards {
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 2;
    return _numberOfMatchingCards;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    Card *card = [self.cards objectAtIndex:index];
    if (card.isChosen) {
        card.chosen = NO;
        
        //Remove from last chosen cards
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.chosen == true"];
        self.lastChosenCards = [self.lastChosenCards filteredArrayUsingPredicate:predicate];

    } else {
        //Match against other chosen cards
        NSMutableArray *chosenCards = [NSMutableArray array];
        
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                [chosenCards addObject:otherCard];
            }
        }
        
        self.lastScore = 0;
        self.lastChosenCards = [chosenCards arrayByAddingObject:card];
        
        if ([chosenCards count] == self.numberOfMatchingCards - 1) {
            //Reaches the limit, let's match
            
            int matchScore = [card match:chosenCards];
//            NSLog(@"Score of this match: %d", matchScore); //Debug
            if (matchScore) {
                self.lastScore = matchScore * MATCH_BONUS;
                card.matched = YES;
                for (Card *chosenCard in chosenCards) {
                    chosenCard.matched = YES;
                }
            } else {
                self.lastScore = - MISMATCH_PENALTY;
                for (Card *chosenCard in chosenCards) {
                    chosenCard.chosen = NO;
                }
            }
        }

        card.chosen = YES;
        self.score += self.lastScore - COST_TO_CHOOSE;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
