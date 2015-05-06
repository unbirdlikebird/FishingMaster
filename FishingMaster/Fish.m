//
//  Fish.m
//  FishingMaster
//
//  Created by Henry on 5/6/15.
//  Copyright (c) 2015 unbirdlikebird. All rights reserved.
//

#import "Fish.h"

@implementation Fish

//direction 用于表示方向 number用于表示鱼的种类
- (id)initWithDirection:(NSString *)direction andFishNumber:(int)fishNumber
{
    self = [super init];
    if (self) {
        _fishThread = [[NSThread alloc]initWithTarget:self selector:@selector(timerStart) object:nil];
        _fishImagePath = [[NSMutableArray alloc]initWithCapacity:10];
        _direction =[direction lowercaseString];
        _fishNumber = fishNumber;
        _fishImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@fish%d_0.png", _direction, fishNumber]];
        _fishImageView = [[UIImageView alloc]initWithImage:_fishImage];

        for (int i = 0 ; i < 10; i++) {
            [_fishImagePath addObject:[UIImage imageNamed:
              [NSString stringWithFormat:@"%@fish%d_%d.png", _direction, fishNumber, i]]];
        }
        _fishImageView.animationImages = _fishImagePath;
        
    }
    return self;
}
//##############################################################################
//draw fish
//##############################################################################
- (UIImageView *)drawingFish
{
    if ([_direction isEqualToString:@"n"]) {
        [self nfishInit];
    }
    else if ([_direction isEqualToString:@"s"]){
        [self sfishInit];
    }
    else if ([_direction isEqualToString:@"w"]){
        [self wfishInit];
    }
    else if ([_direction isEqualToString:@"e"]){
        [self efishInit];
    }
    else{
        NSLog(@"drawingfish error");
        return 0;
    }
    return _fishImageView;
}
//------------------------------------------------------------------------------
- (void)nfishInit
{
    CGRect rect = _fishImageView.frame;
    rect.origin.x = arc4random() % 450 + 50;
    rect.origin.y = 0 - 50;
    _fishImageView.frame = rect;

    _fishImageView.animationRepeatCount = 0;
    _fishImageView.animationDuration = 0.25;
    [_fishImageView startAnimating];
}
//------------------------------------------------------------------------------
- (void)sfishInit
{
    CGRect rect = _fishImageView.frame;
    rect.origin.x = arc4random() % 450 + 50;
    rect.origin.y = 320 + 50;
    _fishImageView.frame = rect;

    _fishImageView.animationRepeatCount = 0;
    _fishImageView.animationDuration = 0.25;
    [_fishImageView startAnimating];
}
//------------------------------------------------------------------------------
- (void)wfishInit
{
    CGRect rect = _fishImageView.frame;
    rect.origin.x = 0 - 50;
    rect.origin.y = arc4random() % 250 + 40;
    _fishImageView.frame = rect;

    _fishImageView.animationRepeatCount = 0;
    _fishImageView.animationDuration = 0.25;
    [_fishImageView startAnimating];
}
//------------------------------------------------------------------------------
- (void)efishInit
{
    CGRect rect = _fishImageView.frame;
    rect.origin.x = 568 + 50;
    rect.origin.y = arc4random() % 250 + 40;

    _fishImageView.frame = rect;
    NSLog(@"efishInit");

    _fishImageView.animationRepeatCount = 0;
    _fishImageView.animationDuration = _fishNumber / 10;
    [_fishImageView startAnimating];
}

//##############################################################################
//moving fish
//##############################################################################
- (void)timerStart
{
    [NSTimer scheduledTimerWithTimeInterval:[self randomSpeed] target:self selector:@selector(moving) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]run];
    NSLog(@"[[NSRunLoop currentRunLoop]run]");
}
- (void)move
{
    [_fishThread start];
       NSLog(@"[_fishThread start]");
    }
//------------------------------------------------------------------------------
- (NSTimeInterval)randomSpeed
{
    return _fishNumber / 10;
    NSLog(@"randomSpeed = %u", arc4random() % 200 / 1000);
}
//------------------------------------------------------------------------------
- (void)moving
{
    if ([_direction isEqualToString:@"n"]) {
        [self moving2South];
    }
    else if ([_direction isEqualToString:@"s"]){
        [self moving2North];
    }
    else if ([_direction isEqualToString:@"w"]){
        [self moving2East];
    }
    else if ([_direction isEqualToString:@"e"]){
        [self moving2West];
    }
    else{
        NSLog(@"fishMoving error");
    }
}
//------------------------------------------------------------------------------
- (void)moving2South
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.y > 320 + 50) {
        rect.origin.y = 0 - 50;
        rect.origin.x = arc4random() % 450 + 50;
    }
    rect.origin.y += 0.5;
    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (void)moving2North
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.y < 0 - 50) {
        rect.origin.y = 320 + 50;
        rect.origin.x = arc4random() % 450 + 50;
    }
    rect.origin.y -= 0.5;
    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (void)moving2East
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.x > 568 + 50) {
        rect.origin.x  = 0 - 50;
        rect.origin.y = arc4random() % 250 + 40;
    }
    rect.origin.x += 0.5;
    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (void)moving2West
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.x < 0 - 50) {
        rect.origin.x = 568 + 50;
        rect.origin.y = arc4random() % 250 + 40;
    }
    rect.origin.x -= 0.5;
    _fishImageView.frame = rect;
}

@end
