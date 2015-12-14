//
//  CardCollectionViewCell.h
//  TestCollectionView
//
//  Created by Igor on 12/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@end
