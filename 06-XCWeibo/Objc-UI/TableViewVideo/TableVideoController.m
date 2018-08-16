//
//  TableVideoController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TableVideoController.h"
#import <JPVideoPlayer/JPVideoPlayerKit.h>

#import "TableVideoCell.h"

@interface TableVideoController ()<JPTableViewPlayVideoDelegate, JPVideoPlayerDelegate>

/**
 * Arrary of video paths.
 * 播放路径数组集合.
 */
@property(nonatomic, strong, nonnull)NSArray *pathStrings;

@end

@implementation TableVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 150;
    self.tableView.jp_delegate = self;
    
    self.pathStrings = @[
                         @"http://www.w3school.com.cn/example/html5/mov_bbb.mp4",
                         @"https://www.w3schools.com/html/movie.mp4",
                         @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                         @"https://media.w3.org/2010/05/sintel/trailer.mp4",
                         @"http://mvvideo2.meitudata.com/576bc2fc91ef22121.mp4",
                         @"http://mvvideo10.meitudata.com/5a92ee2fa975d9739_H264_3.mp4",
                         @"http://mvvideo11.meitudata.com/5a44d13c362a23002_H264_11_5.mp4",
                         @"http://mvvideo10.meitudata.com/572ff691113842657.mp4",
                         @"https://api.tuwan.com/apps/Video/play?key=aHR0cHM6Ly92LnFxLmNvbS9pZnJhbWUvcGxheWVyLmh0bWw%2FdmlkPXUwNjk3MmtqNWV6JnRpbnk9MCZhdXRvPTA%3D&aid=381374",
                         @"https://api.tuwan.com/apps/Video/play?key=aHR0cHM6Ly92LnFxLmNvbS9pZnJhbWUvcGxheWVyLmh0bWw%2FdmlkPWswNjk2enBud2xvJnRpbnk9MCZhdXRvPTA%3D&aid=381395",
                         ];
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -= self.navigationController.navigationBar.bounds.size.height;
    self.tableView.jp_tableViewVisibleFrame = tableViewFrame;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
    [self.tableView jp_playVideoInVisibleCellsIfNeed];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pathStrings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"video_cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.jp_videoURL = [NSURL URLWithString:self.pathStrings[indexPath.row]];
    cell.jp_videoPlayView = cell.videoImage;
    cell.videoImage.jp_videoPlayerDelegate = self;
    [tableView jp_handleCellUnreachableTypeForCell:cell
                                       atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [selectedCell.jp_videoPlayView jp_playVideoWithURL:selectedCell.jp_videoURL ];

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView jp_scrollViewDidEndDraggingWillDecelerate:decelerate];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.tableView jp_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView jp_scrollViewDidScroll];
}

- (BOOL)shouldShowBlackBackgroundWhenPlaybackStart{
    return NO;
}
- (BOOL)shouldShowBlackBackgroundBeforePlaybackStart{
    return NO;
}

@end
