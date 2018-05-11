//
//  FTDTableViewController.m
//  ForceTouchDemo
//
//  Created by zesming on 2018/5/7.
//  Copyright © 2018年 ming.cn. All rights reserved.
//

#import "FTDTableViewController.h"
#import "FTDTableViewCell.h"

#import "FTDDetailViewController.h"

#import <Photos/Photos.h>
#import "UIImage+fixOrientation.h"

@interface FTDTableViewController () <UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) PHFetchResult *allPhotosResult;

@end

@implementation FTDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    [self.tableView reloadData];
}

- (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(NSData *imageData))imageBlock {
    
    [[PHImageManager defaultManager] requestImageDataForAsset:mAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        // Orientation fix
        if (orientation != UIImageOrientationUp) {
            UIImage *image = [UIImage imageWithData:imageData];
            image = [image fixOrientation];
            imageData = UIImageJPEGRepresentation(image, 0.5);
        }
        
        if (imageBlock) {
            imageBlock(imageData);
        }
        
    }];
}

- (BOOL)forceTouchAvailable {
    return self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPhotosResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTDTableViewCell" forIndexPath:indexPath];
    
    [self fetchImageWithAsset:[self.allPhotosResult objectAtIndex:indexPath.row] imageBlock:^(NSData *imageData) {
        cell.thumbnailImageView.image = [UIImage imageWithData:imageData];
    }];
    
    if ([self forceTouchAvailable]) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    
    return cell;
}

#pragma mark - UITableViewController Previewing Delegate

// Peek
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    FTDTableViewCell *cell = (FTDTableViewCell *)previewingContext.sourceView;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FTDDetailViewController *detailViewController = [storyBoard instantiateViewControllerWithIdentifier:@"FTDDetailViewController"];
    detailViewController.image = cell.thumbnailImageView.image;
//    detailViewController.preferredContentSize = CGSizeMake(0.0f, 320);
    
    previewingContext.sourceRect = cell.thumbnailImageView.frame;
    
    return detailViewController;
}

// Pop
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[FTDTableViewCell class]]) {
        FTDDetailViewController *viewController = [segue destinationViewController];
        FTDTableViewCell *cell = (FTDTableViewCell *)sender;
        viewController.image = cell.thumbnailImageView.image;
    }
}

@end
