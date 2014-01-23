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
static const int MATCH_DOUBLE_BONUS = 2;

//Overriding the Card's getter
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    //return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

//Override Card's match
- (int)match:(NSArray *)otherCards {
    int score = 0;

    int numOtherCards = [otherCards count];
    if (numOtherCards) {
        for (id card in otherCards) {
            if ([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = card;
                
                if (otherCard.rank == self.rank) {
                    score += MATCH_SCORE_RANK;
                    NSLog(@"Match rank! %d", otherCard.rank);
                } else if ([otherCard.suit isEqualToString:self.suit]) {
                    score += MATCH_SCORE_SUIT;
                    NSLog(@"Match suit! %@", otherCard.suit);
                }
            }
        }
    }
    if (numOtherCards > 1) {
        int nextScore = [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards -1)]];
        if (nextScore) {
            score += nextScore * MATCH_DOUBLE_BONUS;
            NSLog(@"Double bonus score! %d", score);
        }
    }
    return score;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
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
