//
//  Fish.m
//  FishingMaster
//
//  Created by Henry on 5/6/15.
//  Copyright (c) 2015 unbirdlikebird. All rights reserved.
//

#import "Fish.h"
#import "GameVC.h"
//static int fishCount;

@implementation Fish

//direction 用于表示方向 number用于表示鱼的种类
- (id)initWithDirection:(NSString *)direction andFishNumber:(int)fishNumber andGameVC:(GameVC *)gameVC
{
    self = [super init];
    if (self) {
        _gameVC = gameVC;
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
- (void)drawingFish
{
    [_fishImageView removeFromSuperview];

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
    }
    [_gameVC.view addSubview:_fishImageView];
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

    _fishImageView.animationRepeatCount = 0;
    _fishImageView.animationDuration = 1;
    [_fishImageView startAnimating];
}

//##############################################################################
//moving fish
//##############################################################################
- (void)timerStart
{
    [self drawingFish];
    [NSTimer scheduledTimerWithTimeInterval:[self randomSpeed] target:self selector:@selector(moving) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]run];
}
- (void)move
{
    [_fishThread start];
       NSLog(@"[_fishThread start]");
    }
//------------------------------------------------------------------------------
- (NSTimeInterval)randomSpeed
{
    NSTimeInterval i = random() % 100 / 50.0 + 1;
    NSLog(@"randomSpeed = %f", i / 100);
    return  i / 100;

}
//------------------------------------------------------------------------------
- (void)moving
{
    float speed = random() % 100 / 100.0 + 1;
    NSLog(@"speen = %f", speed);

    if ([_direction isEqualToString:@"n"]) {
        [self moving2SouthWithSpeed:speed];
    }
    else if ([_direction isEqualToString:@"s"]){
        [self moving2NorthWithSpeed:speed];
    }
    else if ([_direction isEqualToString:@"w"]){
        [self moving2EastWithSpeed:speed];
    }
    else if ([_direction isEqualToString:@"e"]){
        [self moving2WestWithSpeed:speed];
    }
    else{
        NSLog(@"fishMoving error");
    }
}
//------------------------------------------------------------------------------
- (void)moving2SouthWithSpeed:(float)speed
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.y > 320 + 70) {
        [self changeDirection];
    }
    rect.origin.y += speed;

    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (void)moving2NorthWithSpeed:(float)speed
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.y < 0 - 70) {
        [self changeDirection];
    }
    rect.origin.y -= speed;
    
    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (void)moving2EastWithSpeed:(float)speed
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.x > 568 + 70) {
        [self changeDirection];
    }
    rect.origin.x += speed;
    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (void)moving2WestWithSpeed:(float)speed
{
    CGRect rect = _fishImageView.frame;
    if (rect.origin.x < 0 - 70) {
        [self changeDirection];
    }
    rect.origin.x -= speed;
    _fishImageView.frame = rect;
}
//------------------------------------------------------------------------------
- (NSString *)randomDirect
{
    int i = arc4random() % 3 +1;

    switch (i) {
        case 1:
            return @"n";
            break;
        case 2:
            return @"s";
            break;
        case 3:
            return @"w";
            break;
        default:
            return @"e";
            break;
    }
}
//------------------------------------------------------------------------------
- (void)changeDirection
{
    [NSTimer s]
    [_fishThread cancel];
    _direction = [self randomDirect];

    _fishImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@fish%d_0.png", _direction, _fishNumber]];
    _fishImageView = [[UIImageView alloc]initWithImage:_fishImage];
    _fishImageView.animationImages = nil;
    [_fishImagePath removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
        [_fishImagePath addObject:[UIImage imageNamed:
                                   [NSString stringWithFormat:@"%@fish%d_%d.png", _direction, _fishNumber, i]]];
    }
    _fishImageView.animationImages = _fishImagePath;
    [_fishThread start];
}

@end
