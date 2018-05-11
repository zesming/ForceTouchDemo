//
//  FTDForcePropertiesViewController.m
//  ForceTouchDemo
//
//  Created by 赵恩生 on 2018/5/8.
//  Copyright © 2018年 ming.cm. All rights reserved.
//

#import "FTDForcePropertiesViewController.h"

@interface FTDForcePropertiesViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *forcePropertiesView;
@property (weak, nonatomic) IBOutlet UILabel *forcePropertiesLabel;

@end

@implementation FTDForcePropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        UITouch *touch = [touches anyObject];
        CGFloat force = touch.force / touch.maximumPossibleForce;
        self.forcePropertiesLabel.text = [NSString stringWithFormat:@"Force: %.4f", force];
        [self.forcePropertiesView setProgress:force animated:NO];
        if (force == 1.0) {
            self.forcePropertiesView.progressTintColor = [UIColor redColor];
        } else {
            self.forcePropertiesView.progressTintColor = nil;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.forcePropertiesLabel.text = @"Force: 0.0000";
    [self.forcePropertiesView setProgress:0.0 animated:NO];
}

@end
