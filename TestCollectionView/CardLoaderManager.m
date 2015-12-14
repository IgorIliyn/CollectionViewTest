//
//  CardLoaderManager.m
//  TestCollectionView
//
//  Created by Igor on 12/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

#import "CardLoaderManager.h"

NSString *const TLCardDownloadedNotification = @"TLCardDownloadedNotification";

@interface CardLoaderManager()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableArray *cardFiles;

@end

@implementation CardLoaderManager

+ (id)sharedDownloadManager
{
    static CardLoaderManager *sharedLoaderManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedLoaderManager = [[CardLoaderManager alloc] init];
    });
    
    return sharedLoaderManager;
}

- (id)init
{
    if (self = [super init]) {
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"card"];

        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                     delegate:self
                                                delegateQueue:nil];
        
    }
    return self;
}


#pragma mark
#pragma mark - Manage download process

- (void)addCardForDownloading:(CardFile *)file
{
    BOOL add = YES;

    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.cardFiles];
    for (CardFile *cardfile in tmpArr) {
        if ((file.indexPath.row == cardfile.indexPath.row) && ([file.downloadSource isEqualToString:cardfile.downloadSource])) {
            add = NO;
            break;
        }
    }
    if (add) {
        [self.cardFiles addObject:file];
        [self startDownloading:file];
    }
    
}

- (void)startDownloading:(CardFile *)cardFile
{
    cardFile.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:cardFile.downloadSource]];
    cardFile.taskIdentifier = cardFile.downloadTask.taskIdentifier;
    [cardFile.downloadTask resume];
}

- (void)stopCardDownloadingForIndexPath:(NSIndexPath *)indexPath
{
    CardFile *cardFileForStop = nil;
    for (CardFile *cardFile in self.cardFiles)
    {
        if (cardFile.indexPath.row == indexPath.row && cardFile.indexPath.section == indexPath.section) {
            [cardFile.downloadTask cancel];
            cardFileForStop = cardFile;
        }
    }
    if (cardFileForStop) {
        [self.cardFiles removeObject:cardFileForStop];
    }
}

#pragma mark
#pragma mark - NSURLSessionDelegete

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error != nil) {
        NSLog(@"Download completed with error: %@", [error localizedDescription]);
    }
    else{
        NSLog(@"Download finished successfully.");
    }
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    CardFile *downloadedFile = nil;
    
    for (CardFile *tmpCardFile in self.cardFiles) {
        if (tmpCardFile.taskIdentifier == downloadTask.taskIdentifier) {
            downloadedFile = tmpCardFile;
            break;
        }
    }

    if (downloadedFile) {
        [self.cardFiles removeObject:downloadedFile];
    }

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:TLCardDownloadedNotification object:downloadedFile userInfo:@{@"url":downloadedFile.downloadSource}];
        
    }];
   
}

-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
     didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    if (totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown) {
        NSLog(@"Unknown transfer size");
    }
    else{
        CardFile *cardFile = nil;
        for (CardFile *card in self.cardFiles) {
            if (card.taskIdentifier == downloadTask.taskIdentifier) {
                cardFile = card;
            }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cardFile.downloadProgress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
            if ([self.progressDelegate respondsToSelector:@selector(updateProgressBar:forIndexPath:)]) {
                [self.progressDelegate updateProgressBar:cardFile.downloadProgress forIndexPath:cardFile.indexPath];
            }
        }];
    }
}


@end
