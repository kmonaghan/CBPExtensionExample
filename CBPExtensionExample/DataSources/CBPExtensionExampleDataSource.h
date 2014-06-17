//
//  CBPExtensionExampleDataSource.h
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 13/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBPExtensionExamplePost;

@interface CBPExtensionExampleDataSource : NSObject <UITableViewDataSource>
- (void)loadPosts:(NSInteger)count completion:(void (^)(NSError* error)) handler;
- (CBPExtensionExamplePost *)postAtIndex:(NSInteger)index;
@end
