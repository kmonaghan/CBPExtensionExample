//
//  CBPExtensionExampleDataSource.m
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 13/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import "NSURLConnection+CBP.h"

#import "CBPExtensionExampleDataSource.h"

#import "CBPExtensionExampleTableViewCell.h"

#import "CBPExtensionExamplePost.h"

@interface CBPExtensionExampleDataSource()
@property (nonatomic) NSArray *items;
@property (nonatomic, assign) BOOL useTodayCell;
@end

@implementation CBPExtensionExampleDataSource
- (instancetype)initWithTodayCell
{
    self = [super init];
    
    if (self) {
        _useTodayCell = YES;
    }
    
    return self;
}

#pragma mark -
- (void)loadPosts:(NSInteger)count completion:(void (^)(NSError* error)) handler
{
    __weak typeof(self) weakSelf = self;
    
    [NSURLConnection loadPosts:count
                    completion:^(NSArray *posts, NSError* error) {
                        if (!error) {
                            __strong typeof(weakSelf) strongSelf = self;
                        
                            strongSelf.items = posts;
                            handler(nil);
                        } else {
                            handler(error);
                        }
                    }];
}

- (CBPExtensionExamplePost *)postAtIndex:(NSInteger)index
{
    return self.items[index];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPExtensionExampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CBPExtensionExampleTableViewCellIdentifier];
    cell.todayCell = self.useTodayCell;
    
    CBPExtensionExamplePost *post = self.items[indexPath.row];
    
    cell.postTitle = post.title;
    cell.imageURI = post.thumbnail;
    cell.postDate = post.date;
    cell.commentCount = post.commentCount;
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

@end
