//
//  ViewController.h
//  Pathway
//
//  Created by Ajay Kirtikar on 3/21/14.
//  Copyright (c) 2014 K Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>
#import <GameKit/GameKit.h>

int HighscoreNumber;

@interface ViewController : UIViewController <ADBannerViewDelegate>
{
    ADBannerView *adVIew;
    
    IBOutlet UILabel *HighScore;
    SystemSoundID PlaySoundID;
    
    
    
    
    
}

-(IBAction)PlayButtonAudio:(id)sender;
-(IBAction)ShowLeader:(id)sender;
-(void)bannerView;

@property(nonatomic, retain)IBOutlet ADBannerView *adView;

@end

