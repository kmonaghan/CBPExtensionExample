//
//  CBPExtensionExampleTableViewCell.h
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 13/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat CBPExtensionExampleTableViewCellHeight = 210.0;
static NSString * const CBPExtensionExampleTableViewCellIdentifier = @"CBPExtensionExampleTableViewCellIdentifier";

@interface CBPExtensionExampleTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic) NSString *imageURI;
@property (nonatomic) NSString *postDate;
@property (nonatomic) NSString *postTitle;
@end