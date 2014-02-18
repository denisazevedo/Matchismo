//
//  GameResult.h
//  Matchismo
//
//  Created by Denis C de Azevedo on 05/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (nonatomic) NSInteger score;
@property (readonly, strong, nonatomic) NSDate *start;
@property (readonly, strong, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) NSString *gameType;

+ (NSArray *)allGameResults; //Of GameResult
- (NSComparisonResult)compareStartDate:(GameResult *)result;

@end
