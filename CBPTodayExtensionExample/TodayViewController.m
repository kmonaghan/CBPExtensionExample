//
//  TodayViewController.m
//  CBPTodayExtensionExample
//
//  Created by Karl Monaghan on 17/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#import "CBPExtensionExampleDataSource.h"

#import "CBPExtensionExampleTableViewCell.h"

#import "CBPExtensionExamplePost.h"

@interface TodayViewController () <NCWidgetProviding, UITableViewDelegate>
@property (nonatomic) CBPExtensionExampleDataSource *dataSource;
@property (nonatomic) UITableView *tableView;
@end

@implementation TodayViewController

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.dataSource loadPosts:2 completion:^(NSError *error) {
        if (!error) {
            [self updateTableView];
        } else {
            NSLog(@"Download error: %@", error);
        }
    }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    [self.dataSource loadPosts:2 completion:^(NSError *error) {
        NCUpdateResult result = NCUpdateResultNoData;
        if (!error) {
            result = NCUpdateResultNewData;
            
            [self updateTableView];
        } else {
            NSLog(@"Download error: %@", error);
            
            result = NCUpdateResultFailed;
        }
        
        completionHandler(result);
    }];
}

#pragma mark -
- (void)updateTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
        
        CGFloat height = (self.tableView.contentSize.height) ? self.tableView.contentSize.height : [self.dataSource tableView:self.tableView numberOfRowsInSection:0] * CBPTodayTableViewCellHeight;
        
        [self setPreferredContentSize:CGSizeMake(self.tableView.contentSize.width, height)];
    });
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPExtensionExamplePost *post = [self.dataSource postAtIndex:indexPath.row];
    
    [self.extensionContext openURL:[NSURL URLWithString:[NSString stringWithFormat:@"cbpextensionexample://%@", @(post.postId)]]
                 completionHandler:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}

#pragma mark -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self.dataSource;
        
        _tableView.rowHeight = CBPTodayTableViewCellHeight;
        _tableView.estimatedRowHeight = CBPTodayTableViewCellHeight;
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor clearColor];
        
        [_tableView registerClass:[CBPExtensionExampleTableViewCell class] forCellReuseIdentifier:CBPExtensionExampleTableViewCellIdentifier];
    }
    
    return _tableView;
}

- (CBPExtensionExampleDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[CBPExtensionExampleDataSource alloc] initWithTodayCell];
    }
    
    return _dataSource;
}

@end
