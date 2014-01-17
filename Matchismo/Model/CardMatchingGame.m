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
@property (nonatomic, strong) NSMutableArray *cards; //of Card
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

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    Card *card = [self.cards objectAtIndex:index];
    if (card.isChosen) {
        card.chosen = NO;
    } else {
        //Match against other chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                int matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    otherCard.matched = YES;
                    NSLog(@"Match! %@ x %@", card.contents, otherCard.contents);
                } else {
                    otherCard.chosen = NO;
                    self.score -= MISMATCH_PENALTY;
                    NSLog(@"No match... %@ x %@", card.contents, otherCard.contents);
                }
                break; //Can only choose 2 cards for now
            }
        }
        card.chosen = YES;
        self.score -= COST_TO_CHOOSE;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
