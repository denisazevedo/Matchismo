//
//  PlayingCard.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 16/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
