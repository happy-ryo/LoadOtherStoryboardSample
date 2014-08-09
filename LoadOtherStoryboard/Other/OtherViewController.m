//
// Created by happy_ryo on 2014/08/09.
// Copyright (c)  happy_ryo. All rights reserved.
//
//
#import <objc/runtime.h>
#import "OtherViewController.h"


@implementation OtherViewController {
}

+ (void)show {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 一旦隠しておく
    window.alpha = 0;

    // Storyboard をインスタンス化する
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
    // Storyboard の InitialViewController を取得して Window の RootViewController として設定する
    window.rootViewController = [storyboard instantiateInitialViewController];
    window.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    window.transform = CGAffineTransformMakeScale(1.3, 1.3);

    // 他の Window よりも高いところに表示する
    window.windowLevel = UIWindowLevelNormal + 10;

    [window makeKeyAndVisible];

    OtherViewController *otherViewController = (OtherViewController *) window.rootViewController;

    // アプリケーションにプロパティを定義して window をセットする
    objc_setAssociatedObject([UIApplication sharedApplication], &kOtherWindow, window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [UIView transitionWithView:window duration:0.2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        // 隠していた Window を見えるようにする
        window.alpha = 1.0;
        window.transform = CGAffineTransformIdentity;
    }               completion:nil];
}

- (IBAction)close:(UIButton *)sender {
    // アプリケーションのプロパティから window を取得する
    UIWindow *window = objc_getAssociatedObject([UIApplication sharedApplication], &kOtherWindow);

    [UIView transitionWithView:window
                      duration:.2
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseInOut
                    animations:^{
        window.transform = CGAffineTransformMakeScale(1.3, 1.3);
        // Window を隠す
        window.alpha = 0;
    }
                    completion:^(BOOL finished) {
        // Window を解放するための下準備
        [window.rootViewController.view removeFromSuperview];
        window.rootViewController = nil;

        // window を解放する
        objc_setAssociatedObject([UIApplication sharedApplication], &kOtherWindow, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        UIWindow *nextWindow = [[UIApplication sharedApplication].delegate window];
        [nextWindow makeKeyAndVisible];
    }];
}
@end