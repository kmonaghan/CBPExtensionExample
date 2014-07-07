//
//  CBPExtensionExampleViewController.m
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 13/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import "CBPExtensionExampleViewController.h"
#import "CBPExtensionExamplePostViewController.h"

@import CBPKit;

@interface CBPExtensionExampleViewController () <UITableViewDelegate>
@property (nonatomic) CBPExtensionExampleDataSource *dataSource;
@property (nonatomic) UITableView *tableView;

@end

@implementation CBPExtensionExampleViewController
- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.dataSource loadPosts:10 completion:^(NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Download error: %@", error);
        }
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPExtensionExamplePostViewController *vc = [[CBPExtensionExamplePostViewController alloc] initWithPost:[self.dataSource postAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self.dataSource;
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = CBPExtensionExampleTableViewCellHeight;
        
        [_tableView registerClass:[CBPExtensionExampleTableViewCell class] forCellReuseIdentifier:CBPExtensionExampleTableViewCellIdentifier];
    }
    
    return _tableView;
}

- (CBPExtensionExampleDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [CBPExtensionExampleDataSource new];
    }
    
    return _dataSource;
}
@end
