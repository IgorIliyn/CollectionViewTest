//
//  CardFile.h
//  TestCollectionView
//
//  Created by Igor on 12/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardFile : NSObject

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSString *downloadSource;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) unsigned long taskIdentifier;
@property (nonatomic) double downloadProgress;

- (id)initWithDownloadSource:(NSString *)source indexPath:(NSIndexPath *)indexPath;

@end
