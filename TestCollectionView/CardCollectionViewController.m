//
//  CardCollectionViewController.m
//  TestCollectionView
//
//  Created by Igor on 12/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCollectionViewCell.h"

@interface CardCollectionViewController () 

@property (strong, nonatomic) NSArray *source;

@end

@implementation CardCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.source = [NSArray arrayWithObjects:@"http://skdevelopment.esy.es/3.jpg",
                                            @"http://skdevelopment.esy.es/4.jpg",
                                            @"http://skdevelopment.esy.es/5.jpg",
                                            @"http://skdevelopment.esy.es/6.jpg",
                                            @"http://skdevelopment.esy.es/7.jpg",
                                            @"http://skdevelopment.esy.es/8.jpg",
                                            @"http://skdevelopment.esy.es/9.jpg",
                                            @"http://skdevelopment.esy.es/10.jpg",
                                            @"http://skdevelopment.esy.es/end_of_the_winter_season_202254.jpg",
                                            @"http://skdevelopment.esy.es/PanoramicLandscapes4.jpg",
                                            @"http://skdevelopment.esy.es/the_end_of_the_day_563979.jpg",
                                            @"http://skdevelopment.esy.es/TropicalBeach1.jpg",
                                            @"http://skdevelopment.esy.es/TropicalBeach2.jpg",
                                            @"http://skdevelopment.esy.es/finland_in_the_middle_of_the_summer_flower.jpg", nil];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"CardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.source.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(250,200);
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
