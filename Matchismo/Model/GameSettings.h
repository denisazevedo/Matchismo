//
//  GameSettings.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 18/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettings : NSObject

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;

//Default values
extern const int MISMATCH_PENALTY;
extern const int MATCH_BONUS;
extern const int COST_TO_CHOOSE;

@end
