//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Denis C de Azevedo on 18/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController ()
@property (strong, nonatomic) GameSettings *settings;
//Outlets
@property (weak, nonatomic) IBOutlet UILabel *matchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *costToChooseLabel;
@property (weak, nonatomic) IBOutlet UISlider *matchBonusSlider;
@property (weak, nonatomic) IBOutlet UISlider *mismatchPenaltySlider;
@property (weak, nonatomic) IBOutlet UISlider *costToChooseSlider;
@end

@implementation SettingsViewController

- (void)setValueLabel:(UILabel *)label forSlider:(UISlider *)slider {
    int sliderValue = lroundf(slider.value);
    [slider setValue:sliderValue animated:NO];
    label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (void)setValueLabels {
    [self setValueLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setValueLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setValueLabel:self.costToChooseLabel forSlider:self.costToChooseSlider];
}


#pragma mark - Actions

- (IBAction)matchBonusSliderChanged:(UISlider *)sender {
    [self setValueLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    self.settings.matchBonus = floor(sender.value);
}

- (IBAction)mismatchPenaltySliderChanged:(UISlider *)sender {
    [self setValueLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    self.settings.mismatchPenalty = floor(sender.value);
}

- (IBAction)costToChooseSliderChanged:(UISlider *)sender {
    [self setValueLabel:self.costToChooseLabel forSlider:self.costToChooseSlider];
    self.settings.flipCost = floor(sender.value);
}

- (IBAction)restoreDefaultSettings:(UIButton *)sender {
    //Save the defauls
    self.settings.matchBonus = MATCH_BONUS;
    self.settings.mismatchPenalty = MISMATCH_PENALTY;
    self.settings.flipCost = COST_TO_CHOOSE;
    //Set the sliders
    self.matchBonusSlider.value = MATCH_BONUS;
    self.mismatchPenaltySlider.value = MISMATCH_PENALTY;
    self.costToChooseSlider.value = COST_TO_CHOOSE;
    //Set the labels
    [self setValueLabels];
}

#pragma mark

- (GameSettings *)settings {
    if (!_settings) {
        _settings = [[GameSettings alloc] init];
    }
    return _settings;
}

#pragma mark - Lifecyle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.matchBonusSlider.value = self.settings.matchBonus;
    self.mismatchPenaltySlider.value = self.settings.mismatchPenalty;
    self.costToChooseSlider.value = self.settings.flipCost;
    
    [self setValueLabels];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

@end
