//
//  FormButton.m
//  MultiTest
//
//  Created by Administrator on 02.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "FormButton.h"
#import "UIColor+UKResident.h"

@interface FormButton ()

@property (strong,nonatomic) CATransition *transitionAnimation;
@property (strong,nonatomic) UIColor *textLabelColor;
@property (strong,nonatomic) UIColor *textLabelHighlightedColor;
@property (strong,nonatomic) UIColor *backgroundLabelColor;
@property (strong,nonatomic) UIColor *backgroundHighlightedColor;

@end

@implementation FormButton

- (id)initWithFrame:(CGRect)frame
{
	self  =  [super initWithFrame:frame];
	if (self) {
		self.adjustsImageWhenHighlighted = NO;
		[self addSubview:self.backgroundLabel];
		[self addSubview:self.textLabel];
	}
	return self;
}

- (void)setText:(NSString *)text withIsNeedEdit:(BOOL)isNeedEdit ansIsCancel:(BOOL)isCancel
{
    self.isCancel = isCancel;
    self.isNeedEdit = isNeedEdit;
    [self.textLabel setText:text];
}

- (void)setIsNeedEdit:(BOOL)isNeedEdit
{
        
    if (isNeedEdit) {
            self.textLabelColor = [UIColor colorButtonNeedEditOkText];
            self.textLabelHighlightedColor = [UIColor colorButtonNeedEditOkTextHigligted];
            self.backgroundLabelColor = [UIColor colorButtonNeedEditOkBackground];
            self.backgroundHighlightedColor = [UIColor colorButtonNeedEditOkBackgroundHigligted];
            [self animationToNormal];
    }else{
            if (self.isCancel){
                self.textLabelColor = [UIColor colorButtonCancelText];
                self.textLabelHighlightedColor = [UIColor colorButtonCancelTextHigligted];
                self.backgroundLabelColor = [UIColor colorButtonCancelBackground];
                self.backgroundHighlightedColor = [UIColor colorButtonCancelBackgroundHigligted];
            }else{
                self.textLabelColor = [UIColor colorButtonOkText];
                self.textLabelHighlightedColor = [UIColor colorButtonOkTextHigligted];
                self.backgroundLabelColor = [UIColor colorButtonOkBackground];
                self.backgroundHighlightedColor = [UIColor colorButtonOkBackgroundHigligted];
            }
            [self animationToNormal];
    }
    
    _isNeedEdit = isNeedEdit;
}

- (void)animationToNeedEdit
{
    [self.backgroundLabel.layer addAnimation:self.transitionAnimation forKey:@"BackgroundAnimation"];
    
    [self.backgroundLabel setBackgroundColor:self.backgroundColor];
    [self.transitionAnimation setDuration:0.2];
    [self.textLabel.layer addAnimation:self.transitionAnimation forKey:@"TextAnimation"];
    [self.textLabel setTextColor:self.textLabelColor];
}

- (void)animationToNotNeedEdit
{
    [self.transitionAnimation setDuration:0.6];
    [self.backgroundLabel.layer addAnimation:self.transitionAnimation forKey:@"BackgroundAnimation"];
    [self.backgroundLabel  setBackgroundColor:[UIColor colorButtonCancelBackground]];
    [self.transitionAnimation setDuration:0.4];
    [self.textLabel.layer addAnimation:self.transitionAnimation forKey:@"TextAnimation"];
    [self.textLabel  setTextColor:[UIColor colorButtonCancelText]];
    
}

- (UIColor *)textLabelColor
{
    if (!_textLabelColor) {
        if (self.isCancel) _textLabelColor = [UIColor colorButtonCancelText];
        else if (self.isNeedEdit) _textLabelColor = [UIColor colorButtonNeedEditOkText];
        else _textLabelColor = [UIColor colorButtonOkText];
    }
    return _textLabelColor;
}

- (UIColor *)textLabelHighlightedColor
{
    if (!_textLabelHighlightedColor) {
        if (self.isCancel) _textLabelHighlightedColor = [UIColor colorButtonCancelTextHigligted];
        else if (self.isNeedEdit) _textLabelHighlightedColor = [UIColor colorButtonNeedEditOkTextHigligted];
        else _textLabelHighlightedColor = [UIColor colorButtonOkTextHigligted];
    }
    return _textLabelHighlightedColor;
}

- (UIColor *)backgroundLabelColor
{
    if (!_backgroundLabelColor) {
        if (self.isCancel) _backgroundLabelColor = [UIColor colorButtonCancelBackground];
        else if (self.isNeedEdit) _backgroundLabelColor = [UIColor colorButtonNeedEditOkBackground];
        else _backgroundLabelColor = [UIColor colorButtonOkBackground];
    }
    return _backgroundLabelColor;
}

- (UIColor *)backgroundHighlightedColor
{
    if (!_backgroundHighlightedColor) {
        if (self.isCancel) _backgroundHighlightedColor = [UIColor colorButtonCancelBackgroundHigligted];
        else if (self.isNeedEdit) _backgroundHighlightedColor = [UIColor colorButtonNeedEditOkBackgroundHigligted];
        else _backgroundHighlightedColor = [UIColor colorButtonOkBackgroundHigligted];
    }
    return _backgroundHighlightedColor;
}

- (CATransition *)transitionAnimation
{
    if (!_transitionAnimation) {
        CATransition *transitionAnimation  =  [CATransition animation];
        [transitionAnimation setType:kCATransitionFade];
        [transitionAnimation setDuration:0.3f];
        [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [transitionAnimation setFillMode:kCAFillModeBoth];
        transitionAnimation.delegate = self;
        _transitionAnimation = transitionAnimation;
    }
    return _transitionAnimation;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 265, 44)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:15.0]];
        label.textColor = self.textLabelColor;
        _textLabel = label;
    }
    return _textLabel;
}

- (UILabel *)backgroundLabel
{
    if (!_backgroundLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 265, 44)];
        label.backgroundColor = self.backgroundLabelColor;
        _backgroundLabel = label;
    }
    return _backgroundLabel;
}

- (void)animationToHighlighted
{
    [self.backgroundLabel.layer removeAllAnimations];
    [self.backgroundLabel setBackgroundColor:self.backgroundHighlightedColor];
    [self.transitionAnimation setDuration:0.2];
    [self.textLabel.layer addAnimation:self.transitionAnimation forKey:@"TextAnimation"];
    [self.textLabel setTextColor:self.textLabelHighlightedColor];
}

- (void)animationToNormal
{
    [self.transitionAnimation setDuration:0.6];
    [self.backgroundLabel.layer addAnimation:self.transitionAnimation forKey:@"BackgroundAnimation"];
    [self.backgroundLabel  setBackgroundColor:self.backgroundLabelColor];
    [self.transitionAnimation setDuration:0.4];
    [self.textLabel.layer addAnimation:self.transitionAnimation forKey:@"TextAnimation"];
    [self.textLabel  setTextColor:self.textLabelColor];
    
}

-(void)setHighlighted:(BOOL)highlighted
{
    if(![self isHighlighted] && highlighted) {
        [self animationToHighlighted];

       // NSLog(@"Highlighted: %hhd",highlighted);
    }
    else if([self isHighlighted] && !highlighted) {
        [self animationToNormal];
        //NSLog(@"Highlighted Animated: %hhd",highlighted);
    }
    
    [super setHighlighted:highlighted];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //NSLog(@"Animation did stop %@",anim);
    if (anim == [self.textLabel.layer animationForKey:@"TextAnimation"]) {
        [self.textLabel.layer removeAllAnimations];
    }
    if (anim == [self.backgroundLabel.layer animationForKey:@"BackgroundAnimation"]) {
        [self.backgroundLabel.layer removeAllAnimations];
    }
}


@end
