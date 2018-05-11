//
//  FTDDetailViewController.m
//  ForceTouchDemo
//
//  Created by zesming on 2018/5/7.
//  Copyright © 2018年 ming.cn. All rights reserved.
//

#import "FTDDetailViewController.h"

@interface FTDDetailViewController ()

@end

@implementation FTDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.image;
}

- (NSArray<id<UIPreviewActionItem>> *)previewActions {
    UIPreviewActionGroup *groupActions = [UIPreviewActionGroup actionGroupWithTitle:@"更多…"
                                                                              style:UIPreviewActionStyleDefault
                                                                            actions:@[
                                                                                      [self previewActionForTitle:@"更多一号" style:UIPreviewActionStyleDefault],
                                                                                      [self previewActionForTitle:@"更多二号" style:UIPreviewActionStyleDefault]
                                                                                      ]
                                          ];
    
    return @[
             [self previewActionForTitle:@"一号按键" style:UIPreviewActionStyleDefault],
             [self previewActionForTitle:@"二号按键" style:UIPreviewActionStyleDestructive],
             groupActions
             ];
}

- (UIPreviewAction *)previewActionForTitle:(NSString *)title style:(UIPreviewActionStyle)style {
    return [UIPreviewAction actionWithTitle:title style:style handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%@", [previewViewController class]);
    }];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    return [self previewActions];
}

@end
