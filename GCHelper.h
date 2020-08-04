//
//  GSHelper.h
//  Pathway
//
//  Created by Ajay Kirtikar on 4/5/14.
//  Copyright (c) 2014 K Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCHelper : NSObject{
    
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    
}


@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCHelper *)sharedInstance;
-(void)AuthenticateLocalUser;

@end
