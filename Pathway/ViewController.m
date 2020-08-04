//
//  ViewController.m
//  Pathway
//
//  Created by Ajay Kirtikar on 3/21/14.
//  Copyright (c) 2014 K Studios. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>


@interface ViewController ()

@end

@implementation ViewController

@synthesize adView;



-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    adView.hidden = FALSE;
    NSLog(@"Has ad Showing");
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    adView.hidden = TRUE;
    NSLog(@"has no ads, hiding");
}


-(IBAction)ShowLeader:(id)sender{
    GKLeaderboardViewController *lb = [[GKLeaderboardViewController alloc] init];
    if(lb != nil){
    
        lb.leaderboardDelegate = self;
        [self presentModalViewController:lb animated:YES];
        
    }}
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated: YES];
    
}

    
-(IBAction)PlayButtonAudio:(id)sender{
    
    AudioServicesPlaySystemSound(PlaySoundID);
    
}


- (void)viewDidLoad
    
{
    adView.delegate = self;
    
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error){
        
        if (error == nil) {
            NSLog(@"Success");
        } else {
            NSLog(@"Fail");
            //NSLog([NSString stringWithFormat:@"%@", error]);
            
        }
        
    }];
    
    
    NSURL *ButtonSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"Button clicks" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)ButtonSoundURL, &PlaySoundID);
    
    
    HighscoreNumber =[[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    HighScore.text = [NSString stringWithFormat:@"High Score: %li", (long)HighscoreNumber];
    
    
    
    [super viewDidLoad];
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


