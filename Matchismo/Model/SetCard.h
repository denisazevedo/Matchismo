//
//  SetCard.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 27/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic)NSUInteger number;
@property (nonatomic, strong)NSString *symbol;
@property (nonatomic, strong)NSString *shading;
@property (nonatomic, strong)NSString *color;

+ (NSUInteger)minNumber;
+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
