//
//  GameVC.m
//  FishingMaster
//
//  Created by Henry on 5/6/15.
//  Copyright (c) 2015 unbirdlikebird. All rights reserved.
//

#import "GameVC.h"

@interface GameVC ()

@property   UIImageView     *IV_net;


@end

@implementation GameVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    NSThread *fishThread = [[NSThread alloc]initWithTarget:self selector:@selector(fish) object:nil];
    [fishThread start];

    NSThread *netThread = [[NSThread alloc]initWithTarget:self selector:@selector(net) object:nil];
    [netThread start];

    // Do any additional setup after loading the view from its nib.
}
- (void)net
{
    _IV_net = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"net.png"]];
    CGRect rect = _IV_net.frame;
    rect.size = CGSizeMake(80, 80);
    _IV_net.frame = rect;
}
- (void)fish
{
    Fish *fish1 = [[Fish alloc]initWithDirection:@"e" andFishNumber:3];
    [self.view addSubview:[fish1 drawingFish]];
    [fish1 move];
    Fish *fish2 = [[Fish alloc]initWithDirection:@"w" andFishNumber:5];
    [self.view addSubview:[fish2 drawingFish]];
    [fish2 move];
    Fish *fish3 = [[Fish alloc]initWithDirection:@"s" andFishNumber:9];
    [self.view addSubview:[fish3 drawingFish]];
    [fish3 move];
    Fish *fish4 = [[Fish alloc]initWithDirection:@"n" andFishNumber:4];
    [self.view addSubview:[fish4 drawingFish]];
    [fish4 move];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_IV_net removeFromSuperview];

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];

    CGRect netRect = _IV_net.frame;
    netRect.origin.x = location.x - 40;
    netRect.origin.y = location.y - 40;
    netRect.size.height = 80;
    netRect.size.width  = 80;
    
    _IV_net.frame = netRect;
    [self.view addSubview:_IV_net];

    NSLog(@"%f,%f", location.x,location.y);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
