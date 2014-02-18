//
//  GameSettings.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 18/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "GameSettings.h"

@interface GameSettings()

@end

@implementation GameSettings

//Default values
const int MISMATCH_PENALTY = 2;
const int MATCH_BONUS = 4;
const int COST_TO_CHOOSE = 1;

#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCHBONUS_KEY @"MatchBonus_Key"
#define MISMATCHPENALTY_KEY @"MismatchPenalty_Key"
#define FLIPCOST_KEY @"FlipCost_Key"
#define NUMBERPLAYINGCARDS_KEY @"NumberPlayingCards_Key"

- (int)intValueForKey:(NSString *)key withDefault:(int)defaultValue {
    //Retrieves the value from the standardUserDefaults
    
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
    if (!settings) return defaultValue;
    if (![[settings allKeys] containsObject:key]) return defaultValue;
    return [settings[key] intValue];
}

- (void)setIntValue:(int)value forKey:(NSString *)key {
//    NSLog(@"Saving settings: %@ = %d", key, value);

    NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
    if (!settings) settings = [[NSMutableDictionary alloc] init];

    settings[key] = @(value);
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:GAME_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Properties

- (int)matchBonus {
    return [self intValueForKey:MATCHBONUS_KEY withDefault: MATCH_BONUS];
}

- (int)mismatchPenalty {
    return [self intValueForKey:MISMATCHPENALTY_KEY withDefault: MISMATCH_PENALTY];
}

- (int)flipCost {
    return [self intValueForKey:FLIPCOST_KEY withDefault: COST_TO_CHOOSE];
}

- (void)setMatchBonus:(int)matchBonus {
    [self setIntValue:matchBonus forKey:MATCHBONUS_KEY];
}

- (void)setMismatchPenalty:(int)mismatchPenalty {
    [self setIntValue:mismatchPenalty forKey:MISMATCHPENALTY_KEY];
}

- (void)setFlipCost:(int)flipCost {
    [self setIntValue:flipCost forKey:FLIPCOST_KEY];
}

@end
