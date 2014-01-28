//
//  SetCard.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 27/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - Overrided

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    //TODO create a dynamic value
    int numberOfMatchingCards = 3;
    int numOtherCards = [otherCards count];
    
    if (numOtherCards == numberOfMatchingCards - 1) {
        
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        
        for (id card in otherCards) {
            if ([card isKindOfClass:[SetCard class]]) {
                SetCard *otherCard = (SetCard *)card;
                
                if (![colors containsObject:otherCard.color])
                    [colors addObject:otherCard.color];
                if (![symbols containsObject:otherCard.symbol])
                    [symbols addObject:otherCard.symbol];
                if (![shadings containsObject:otherCard.shading])
                    [shadings addObject:otherCard.shading];
                if (![numbers containsObject:@(otherCard.number)])
                    [numbers addObject:@(otherCard.number)];
                if (([colors count] == 1 || [colors count] == numberOfMatchingCards)
                    && ([symbols count] == 1 || [symbols count] == numberOfMatchingCards)
                    && ([shadings count] == 1 || [shadings count] == numberOfMatchingCards)
                    && ([numbers count] == 1 || [numbers count] == numberOfMatchingCards)) {
                    score = 4;
                }
            }
        }
    }
    return score;
}

- (NSString *)contents {
    return [NSString stringWithFormat:@"%d %@ %@ %@", self.number, self.symbol, self.shading, self.color];
}

- (NSString *)description { //For debug
    return [self contents];
}

#pragma mark - Class methods

+ (NSUInteger)minNumber {
    return 1;
}
+ (NSUInteger)maxNumber {
    return 3;
}

+ (NSArray *)validSymbols {
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

#pragma mark - Properties

//- (void)setNumber:(NSUInteger)number {
//    if (number <= [SetCard maxNumber]) {
//        _number = number;
//    }
//}

@synthesize symbol = _symbol;
- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}
- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

@synthesize shading = _shading;
- (NSString *)shading {
    return _shading ? _shading : @"?";
}
- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

@synthesize color = _color;
- (NSString *)color {
    return _color ? _color : @"?";
}
- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

@end
