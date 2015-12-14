//
//  CardFile.m
//  TestCollectionView
//
//  Created by Igor on 12/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

#import "CardFile.h"

@implementation CardFile

-(id)initWithDownloadSource:(NSString *)source indexPath:(NSIndexPath *)indexPath {
    
    if (self == [super init]) {
        self.downloadSource = source;
        self.downloadProgress = 0.0;
        self.taskIdentifier = -1;
        self.indexPath = indexPath;
    }
    return self;
}

@end
