//
//  NSURLConnection+CBP.h
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 14/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (CBP)
+ (void)loadPosts:(NSInteger)count completion:(void (^)(NSArray *posts, NSError* error)) handler;
@end