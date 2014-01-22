//
//  PlayingCard.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 16/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

static const int MATCH_SCORE_RANK = 4;
static const int MATCH_SCORE_SUIT = 1;

//Overriding the Card's getter
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    //return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

//Override Card's match
- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) { //Introspection to check class type
            PlayingCard *otherCard = card;
            if (otherCard.rank == self.rank) {
                score = MATCH_SCORE_RANK;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score = MATCH_SCORE_SUIT;
            }
        }
    }
    return score;
}

@synthesize suit = _suit;
+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}
- (NSString *)suit {
    return _suit ? _suit : @"?";
}
- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

@synthesize rank = _rank;
+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}
- (void) setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
