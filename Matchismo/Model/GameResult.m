//
//  GameResult.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 05/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#pragma mark - Constants

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_TYPE_KEY @"GameType"

#pragma mark - Properties

- (void)setScore:(NSInteger)score {
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

- (NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

#pragma mark - Initializers

- (instancetype) init {
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (instancetype)initFromPropertyList:(id)plist {
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionay = (NSDictionary *)plist;
            _start = resultDictionay[START_KEY];
            _end = resultDictionay[END_KEY];
            _score = [resultDictionay[SCORE_KEY] intValue];
            _gameType = resultDictionay[GAME_TYPE_KEY];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

- (NSComparisonResult)compareStartDate:(GameResult *)result {
    return !([self.start compare:result.start] == NSOrderedDescending);
}

- (NSComparisonResult)compareScore:(GameResult *)result {
    return [@(self.score) compare:@(result.score)];
}

- (NSComparisonResult)compareDuration:(GameResult *)result {
    return [@(self.duration) compare:@(result.duration)];
}

#pragma mark - Synchronize

- (void)synchronize {

    //User defaults
    NSMutableDictionary *gameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    if (!gameResultsFromUserDefaults) {
        gameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    gameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    //Synchronize to user defaults
    [[NSUserDefaults standardUserDefaults] setObject:gameResultsFromUserDefaults
                                              forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList {
    return @{START_KEY: self.start,
             END_KEY: self.end,
             SCORE_KEY: @(self.score),
             GAME_TYPE_KEY: self.gameType};
}

#pragma mark - Class methods

+ (NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return allGameResults;
}

@end
