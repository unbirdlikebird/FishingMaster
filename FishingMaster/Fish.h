//
//  Fish.h
//  FishingMaster
//
//  Created by Henry on 5/6/15.
//  Copyright (c) 2015 unbirdlikebird. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameVC;

@interface Fish : NSObject

@property   NSMutableArray      *fishImagePath;
@property   NSString            *direction;
@property   UIImage             *fishImage;
@property   UIImageView         *fishImageView;
@property   NSThread            *fishThread;
@property   int                 fishNumber;
@property   GameVC              *gameVC;


- (id)initWithDirection:(NSString *)direction andFishNumber:(int)fishNumber andGameVC:(GameVC *)gameVC;
- (void)move;


@end
