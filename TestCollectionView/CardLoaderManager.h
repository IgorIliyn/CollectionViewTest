//
//  CardLoaderManager.h
//  TestCollectionView
//
//  Created by Igor on 12/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CardFile.h"

UIKIT_EXTERN NSString *const TLCardDownloadedNotification;

@protocol CardLoaderManagerDelegate <NSObject>

@optional

- (void)updateProgressBar:(double)progress forIndexPath:(NSIndexPath *)indexPath;

@end

@interface CardLoaderManager : NSObject <NSURLSessionDelegate>

@property (nonatomic, strong) id<CardLoaderManagerDelegate>progressDelegate;

+ (id)sharedDownloadManager;

- (id)init;

//Call this method for instantiate new background downloading
- (void)addCardForDownloading:(CardFile *)file;
//Call this method to cancel downloading with indexPath to indicate which file need cancel
- (void)stopCardDownloadingForIndexPath:(NSIndexPath *)indexPath;

@end
