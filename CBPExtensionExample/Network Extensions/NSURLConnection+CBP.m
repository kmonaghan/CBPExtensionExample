//
//  NSURLConnection+CBP.m
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 14/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import "NSURLConnection+CBP.h"

#import "CBPExtensionExamplePost.h"

@implementation NSURLConnection (CBPWordPress)
+ (void)loadPosts:(NSInteger)count completion:(void (^)(NSArray *posts, NSError* error)) handler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://broadsheet.ie/?json=1&count=%d", count]];
        
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (error) {
                                   handler(nil, error);
                               } else {
                                   NSError *localError = nil;
                                   NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                options:0
                                                                                                  error:&localError];
                                   if (localError) {
                                       handler(nil, error);
                                   } else {
                                       if ([parsedObject[@"posts"] isKindOfClass:[NSArray class]]) {
                                           NSMutableArray *items = @[].mutableCopy;
                                           
                                           for (NSDictionary *details in parsedObject[@"posts"]) {
                                               [items addObject:[CBPExtensionExamplePost initFromDictionary:details]];
                                           }

                                           handler(items, nil);
                                       }
                                   }
                               }
                           }];
}
@end