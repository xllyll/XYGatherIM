//
//  XYGIMSendImageView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMSendImageView.h"


@interface XYGIMSendImageView ()

@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;


@end

@implementation XYGIMSendImageView

- (instancetype)init {
    if ([super init]) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicatorView.hidden = YES;
        indicatorView.tintColor = [UIColor grayColor];
        [self addSubview:self.indicatorView = indicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.frame = self.bounds;
}

#pragma mark - Setters
- (void)setMessageSendState:(XYGIMNMessageSendState)messageSendState {
    _messageSendState = messageSendState;
    if (_messageSendState == XYGIMNMessageSendStateSending) {
        [self.indicatorView startAnimating];
        self.indicatorView.hidden = NO;
    }else {
        [self.indicatorView stopAnimating];
        self.indicatorView.hidden = YES;
    }
    
    switch (_messageSendState) {
        case XYGIMNMessageSendStateSending:
        case XYGIMNMessageSendFail:
            self.hidden = NO;
            break;
        default:
            self.hidden = YES;
            break;
    }
}

@end
