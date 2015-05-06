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
@property   int             fishCount;

@end

@implementation GameVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];

        // Custom initialization
    }
    return self;
}

- (void)refresh
{

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
    Fish *fish1 = [[Fish alloc]initWithDirection:[self randomDirect] andFishNumber:[self randomBreed] andGameVC:self];
    [fish1 move];

}

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

- (int)randomBreed
{
    return arc4random() % 8 + 1;
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

- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer

{

    [self.view setBackgroundColor:[UIColor blueColor]];

    NSLog(@"-----doubleTap-----");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"warningngngngngngngngn");
    // Dispose of any resources that can be recreated.
}

@end
