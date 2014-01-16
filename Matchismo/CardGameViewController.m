//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 15/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    UIImage *cardImage;
    NSString *cardTitle;
    
    if ([sender.currentTitle length]) {
        cardImage = [UIImage imageNamed:@"cardback"];
        cardTitle = @"";
    } else {
        cardImage = [UIImage imageNamed:@"cardfront"];
        cardTitle = @"A♣️";
    }
    [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
    [sender setTitle:cardTitle forState:UIControlStateNormal];
    self.flipCount++;
}

@end
