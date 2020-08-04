//
//  Game.m
//  Pathway
//
//  Created by Ajay Kirtikar on 3/22/14.
//  Copyright (c) 2014 K Studios. All rights reserved.
//

#import "Game.h"
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>
@interface Game ()

@end

@implementation Game;

@synthesize adView;

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    adView.hidden = FALSE;
    NSLog(@"Has ad Showing");
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    adView.hidden = TRUE;
    NSLog(@"has no ads, hiding");
}


-(void)SubmitScore{
    
    //send scores to gamecenter
    GKScore *myScoreValue = [[GKScore alloc] initWithCategory:@"1234567"];
    myScoreValue.value = HighScoreNumber;
    
    
    [myScoreValue reportScoreWithCompletionHandler:^(NSError *error){
        
        if(error != nil){
            NSLog(@"Score Submission Failed");
            //NSLog([NSString stringWithFormat:@"%@", error]);
            
            
            
        } else {
            
            NSLog(@"Score Submitted");
            
        }
        
    }];
}

    

-(IBAction)PlayButtonAudio:(id)sender{
    
    AudioServicesPlaySystemSound(PlaySoundID);
    
}


-(void)CoinSounds{
    
    AudioServicesPlaySystemSound(CoinSoundID);
    
    
}

-(void)ExplosionSound{
    
    AudioServicesPlaySystemSound(ExplosionSoundID);
    
}

-(void)TimerBoost{
    if (TimeBoostNumber == 5){
        timeNumber = timeNumber + 10;
        TimeBoostNumber = 0;
       
    }
}

-(void) timerRun{
    if (timeNumber == 0) {
        [self GameOver];
    }
    TimerDisplayLabel.text = [NSString stringWithFormat:@"%u", timeNumber];
    timeNumber = timeNumber - 1;
    SecondLabel.hidden = NO;
}
-(void)timerCount{
    timeNumber = 15;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:Nil repeats:YES];
}


-(void)GameOver{
    
    [self SubmitScore];
    
    [self ExplosionAnimation];
    


    [self ExplosionSound];
    

    [countdownTimer invalidate];
    countdownTimer = nil;
    
    if (ScoreNumber > HighScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
    }
    
    [ObjectMovement invalidate];
    [ObjectMovement1 invalidate];
    [ObjectMovement2 invalidate];
    [ObjectMovement3 invalidate];
    
    Exit.hidden = NO;
    
    Ball.hidden = YES;
    
    GameOver.hidden = NO;
    Replay.hidden = NO;
}


-(void)ExplosionAnimation{
   
    Explosion.hidden = NO;
    Explosion.center = CGPointMake(Ball.center.x, Ball.center.y);    Explosion.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"Explosion4.png"],
                                 [UIImage imageNamed:@"Explosion2.png"],
                                 [UIImage imageNamed:@"Explosion1.png"],nil];
    
    [Explosion setAnimationRepeatCount:-1];
    Explosion.animationDuration = 0.25;
    [Explosion startAnimating];

    
    
}

-(void)Collision{
    
    if ((CGRectIntersectsRect(Ball.frame, Coin.frame)) && (CoinCollected == NO)){
        CoinCollected = YES;
        Coin.hidden = YES;
        [self Score];
        [self CoinSounds];
        
    }
    
    if ((CGRectIntersectsRect(Ball.frame, Coin2.frame)) && (CoinCollected2 == NO)){
        CoinCollected2 = YES;
        Coin2.hidden = YES;
        [self Score];
        [self CoinSounds];
    }
    
    if ((CGRectIntersectsRect(Ball.frame, Coin3.frame))&& (CoinCollected3 == NO)){
        Coin3.hidden = YES;
        CoinCollected3 = YES;
        [self Score];
        [self CoinSounds];
    }
    if ((CGRectIntersectsRect(Ball.frame, Coin4.frame))&& (CoinCollected4 == NO)){
        Coin4.hidden = YES;
        CoinCollected4 = YES;
        [self Score];
        [self CoinSounds];
    }
    
    
}

-(void)Score{
    
    ScoreNumber = ScoreNumber + 1 ;
    TimeBoostNumber = TimeBoostNumber + 1;
    [self TimerBoost];
    
    ScoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    if (ScoreNumber == 10) {
        ObjectMovement1 = [NSTimer scheduledTimerWithTimeInterval:0.0190 target:self selector:@selector(ObjectMoving) userInfo:nil repeats:YES];
    }
    
        if (ScoreNumber == 50) {
            ObjectMovement2 = [NSTimer scheduledTimerWithTimeInterval:0.0189 target:self selector:@selector(ObjectMoving) userInfo:nil repeats:YES];

    }
    
    if (ScoreNumber == 100) {
        ObjectMovement3 = [NSTimer scheduledTimerWithTimeInterval:0.0188 target:self selector:@selector(ObjectMoving) userInfo:nil repeats:YES];
    }
    
}


-(IBAction)StartGame:(id)sender{

    
    
    [self timerCount];
    
    ObjecteLeft.hidden = NO;
    ObjectRight.hidden = NO;
    
    ObjectLeft2.hidden = NO;
    ObjectRight2.hidden = NO;
    
    ObjectLeft3.hidden = NO;
    ObjectRight3.hidden = NO;
    
    ObjectLeft4.hidden = NO;
    ObjectRight4.hidden = NO;
    
    ObjectLeft5.hidden = NO;
    ObjectRight5.hidden = NO;
    
    Coin.hidden = NO;
    Coin2.hidden = NO;
    Coin3.hidden = NO;
    Coin4.hidden = NO;
    
    
    Startgame.hidden = YES;
    
    [self PlaceObjects];
    
    [self PlaceObjects2];
    
    [self PlaceObjects3];
    
    [self PlaceObjects4];
    
    [self PlaceObjects5];
    
    [self PlaceCoin];
    
    [self PlaceCoin2];
    
    [self PlaceCoin3];
    
    [self PlaceCoin4];
    
    ObjectMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ObjectMoving) userInfo:nil repeats:YES];
    
    
 }

-(void)ObjectMoving{
    
    [self Collision];
    
    ObjecteLeft.center = CGPointMake(ObjecteLeft.center.x, ObjecteLeft.center.y + 2);
    ObjectRight.center = CGPointMake(ObjectRight.center.x, ObjectRight.center.y + 2);
    
    ObjectLeft2.center = CGPointMake(ObjectLeft2.center.x, ObjectLeft2.center.y + 2);
    ObjectRight2.center = CGPointMake(ObjectRight2.center.x, ObjectRight2.center.y + 2);
    
    ObjectLeft3.center = CGPointMake(ObjectLeft3.center.x, ObjectLeft3.center.y + 2);
    ObjectRight3.center = CGPointMake(ObjectRight3.center.x, ObjectRight3.center.y + 2);
    
    ObjectLeft4.center = CGPointMake(ObjectLeft4.center.x, ObjectLeft4.center.y + 2);
    ObjectRight4.center = CGPointMake(ObjectRight4.center.x, ObjectRight4.center.y + 2);
    
    
    ObjectLeft5.center = CGPointMake(ObjectLeft5.center.x, ObjectLeft5.center.y + 2);
    ObjectRight5.center = CGPointMake(ObjectRight5.center.x, ObjectRight5.center.y + 2);
    
    Coin.center = CGPointMake(Coin.center.x, Coin.center.y + 2);
    Coin2.center = CGPointMake(Coin2.center.x, Coin2.center.y + 2);
    Coin3.center = CGPointMake(Coin3.center.x, Coin3.center.y + 2);
    Coin4.center = CGPointMake(Coin4.center.x, Coin4.center.y + 2);

    
    if (Coin.center.y > 1270){
        [self PlaceCoin];
    }

    
    if (Coin2.center.y > 1070){
        [self PlaceCoin2];
    }
    
    if (Coin3.center.y > 870){
        [self PlaceCoin3];
    }
    
    if (Coin4.center.y > 670){
        [self PlaceCoin4];
    }
    
    
    if (ObjecteLeft.center.y > 1370){
        [self PlaceObjects];
        }
    
    if (ObjectLeft2.center.y > 1170) {
        [self PlaceObjects2];
    }
    
    if (ObjectLeft3.center.y > 970) {
        [self PlaceObjects3];
    }
    
    if (ObjectLeft4.center.y > 770) {
        [self PlaceObjects4];
    }
    
    if (ObjectLeft5.center.y > 570) {
        [self PlaceObjects5];
    }
    
    
   
    if (CGRectIntersectsRect(Ball.frame, ObjecteLeft.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectRight.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectLeft2.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectRight2.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectLeft3.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectRight3.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectLeft4.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectRight4.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectLeft5.frame)) {
        [self GameOver];
    }
    if (CGRectIntersectsRect(Ball.frame, ObjectRight5.frame)) {
        [self GameOver];
    }


}

-(void)PlaceCoin{
    
    
    Coin.center = CGPointMake(260, -100);
    Coin.hidden = NO;
    CoinCollected = NO;
}

-(void)PlaceCoin2{
    
    
    Coin2.center = CGPointMake(30, -300);
    Coin2.hidden = NO;
    CoinCollected2 = NO;
}


-(void)PlaceCoin3{
        
        
    Coin3.center = CGPointMake(260, -500);
    Coin3.hidden = NO;
    CoinCollected3 = NO;
    }





-(void)PlaceCoin4{
    
    
    Coin4.center = CGPointMake(30, -700);
    Coin4.hidden = NO;
    CoinCollected4 = NO;
}





-(void)PlaceObjects{
  
    RandomLeftObjectPosition = arc4random() %239;
    RandomLeftObjectPosition = RandomLeftObjectPosition + 235;
    RandomRightObjectPosition = RandomLeftObjectPosition - 380;
    
    
    ObjecteLeft.center = CGPointMake(RandomLeftObjectPosition, 0);
    ObjectRight.center = CGPointMake(RandomRightObjectPosition, 0);
   
    
    
}

    

    
-(void)PlaceObjects2{

    RandomLeftObjectPosition2 = arc4random() %239;
    RandomLeftObjectPosition2 = RandomLeftObjectPosition2 + 235;
    RandomRightObjectPosition2 = RandomLeftObjectPosition2 - 380;
    
    ObjectLeft2.center = CGPointMake(RandomLeftObjectPosition2, -200);
    ObjectRight2.center = CGPointMake(RandomRightObjectPosition2, -200);
}


-(void)PlaceObjects3{

    RandomLeftObjectPosition3 = arc4random() %239;
    RandomLeftObjectPosition3 = RandomLeftObjectPosition3 + 235;
    RandomRightObjectPosition3 = RandomLeftObjectPosition3 - 380;
    
    ObjectLeft3.center = CGPointMake(RandomLeftObjectPosition3, -400);
    ObjectRight3.center = CGPointMake(RandomRightObjectPosition3, -400);
}


-(void)PlaceObjects4{
    
    RandomLeftObjectPosition4 = arc4random() %239;
    RandomLeftObjectPosition4 = RandomLeftObjectPosition4 + 235;
    RandomRightObjectPosition4 = RandomLeftObjectPosition4 - 380;
    
    ObjectLeft4.center = CGPointMake(RandomLeftObjectPosition4, -600);
    ObjectRight4.center = CGPointMake(RandomRightObjectPosition4,-600);

}


-(void)PlaceObjects5{
    
    RandomLeftObjectPosition5 = arc4random() %239;
    RandomLeftObjectPosition5 = RandomLeftObjectPosition5 + 235;
    RandomRightObjectPosition5 = RandomLeftObjectPosition5 - 380;
    
    ObjectLeft5.center = CGPointMake(RandomLeftObjectPosition5, -800);
    ObjectRight5.center = CGPointMake(RandomRightObjectPosition5,-800);
    
}
    

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *Drag = [[event allTouches] anyObject];
    Ball.center = [Drag locationInView:self.view];
    
    if (Ball.center.y > 400) {
        Ball.center = CGPointMake(Ball.center.x, 400);
    }
    if (Ball.center.y < 400) {
        Ball.center = CGPointMake(Ball.center.x, 400);
    }
}


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
    adView.delegate = self;
    
    NSURL *ButtonSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"Button clicks" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)ButtonSoundURL, &PlaySoundID);
    
    
    NSURL *CoinSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"Coin Sound" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)CoinSoundURL, &CoinSoundID);
    
    
    NSURL *ExplosionSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"explosion-01" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)ExplosionSoundURL, &ExplosionSoundID);
    
   


    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    GameOver.hidden = YES;
    Exit.hidden = YES;
    ScoreNumber = 0;
    TimeBoostNumber = 0;
    Explosion.hidden = YES;
    ObjecteLeft.hidden = YES;
    ObjectRight.hidden = YES;
    ObjectLeft2.hidden = YES;
    ObjectRight2.hidden = YES;
    ObjectLeft3.hidden = YES;
    ObjectRight3.hidden = YES;
    ObjectLeft4.hidden = YES;
    ObjectRight4.hidden = YES;
    ObjectLeft5.hidden = YES;
    ObjectRight5.hidden = YES;
    Coin.hidden = YES;
    Coin2.hidden = YES;
    Coin3.hidden = YES;
    Coin4.hidden = YES;
    Replay.hidden = YES;
    
    SecondLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

