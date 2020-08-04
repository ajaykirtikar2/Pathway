//
//  Game.h
//  Pathway
//
//  Created by Ajay Kirtikar on 3/22/14.
//  Copyright (c) 2014 K Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>

 SystemSoundID PlaySoundID;
 SystemSoundID CoinSoundID;
 SystemSoundID ExplosionSoundID;

int RandomLeftObjectPosition;
int RandomRightObjectPosition;

int RandomLeftObjectPosition2;
int RandomRightObjectPosition2;

int RandomLeftObjectPosition3;
int RandomRightObjectPosition3;

int RandomLeftObjectPosition4;
int RandomRightObjectPosition4;

int RandomLeftObjectPosition5;
int RandomRightObjectPosition5;

int myScoreValue;

BOOL CoinCollected;
BOOL CoinCollected2;
BOOL CoinCollected3;
BOOL CoinCollected4;

int timeNumber;
int ScoreNumber;
int TimeBoostNumber;

NSInteger HighScoreNumber;

@interface Game : UIViewController <ADBannerViewDelegate>

{
    IBOutlet UIImageView *Ball;
    IBOutlet UIButton *Startgame;
    IBOutlet UIImageView *ObjecteLeft;
    IBOutlet UIImageView *ObjectRight;
    
    
    IBOutlet UIImageView *ObjectLeft2;
    IBOutlet UIImageView *ObjectRight2;
    
    IBOutlet UIImageView *ObjectLeft3;
    IBOutlet UIImageView *ObjectRight3;
    
    IBOutlet UIImageView *ObjectLeft4;
    IBOutlet UIImageView *ObjectRight4;
    
    IBOutlet UIImageView *ObjectLeft5;
    IBOutlet UIImageView *ObjectRight5;
    
    IBOutlet UIImageView *Coin;
    IBOutlet UIImageView *Coin2;
    IBOutlet UIImageView *Coin3;
    IBOutlet UIImageView *Coin4;
    
    IBOutlet UIButton *Exit;
    IBOutlet UILabel *ScoreLabel;
    
    IBOutlet UIButton *GameOver;
    
    IBOutlet UIImageView *Explosion;
    IBOutlet UILabel *TimerDisplayLabel;
    
    IBOutlet UIButton *Replay;
    
    IBOutlet UILabel *SecondLabel;
    
    
  
    NSTimer *ObjectMovement;
    NSTimer *ObjectMovement1;
    NSTimer *ObjectMovement2;
    NSTimer *ObjectMovement3;
    NSTimer *countdownTimer;

    ADBannerView *adView;
}

-(IBAction)StartGame:(id)sender;
-(void)ObjectMoving;
-(void)ObjectMovement;
-(void)PlaceObjects;
-(void)PlaceObjects2;
-(void)PlaceObjects3;
-(void)PlaceObjects4;
-(void)PlaceCoin;
-(void)PlaceCoin2;
-(void)PlaceCoin3;
-(void)PlaceCoin4;
-(void)Score;
-(void)GameOver;
-(void)Collision;
-(void)CoinCollected;
-(void)TimerCount;
-(void)TimerBoost;
-(void)ExplosionAnimation;
-(void)CoinSounds;
-(void)ExplosionSound;
-(void)SubmitScore;

-(IBAction)PlayButtonAudio:(id)sender;

@property(nonatomic, retain)IBOutlet ADBannerView *adView;


@end
