//
//  AppDelegate.h
//  Pathway
//
//  Created by Ajay Kirtikar on 3/21/14.
//  Copyright (c) 2014 K Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>{
    AVAudioPlayer *AudioPlayer1;
    
}
@property (strong, nonatomic) UIWindow *window;

@end





