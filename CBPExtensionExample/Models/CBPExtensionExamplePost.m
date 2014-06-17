//
//  CBPExtensionExamplePost.m
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 13/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import "CBPExtensionExamplePost.h"

@implementation CBPExtensionExamplePost
+ (instancetype)initFromDictionary:(NSDictionary *)aDictionary
{
    CBPExtensionExamplePost *instance = [[CBPExtensionExamplePost alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [self setValuesForKeysWithDictionary:aDictionary];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"comment_count"]) {
        [self setValue:value forKey:@"commentCount"];
    } else if ([key isEqualToString:@"comment_status"]) {
        [self setValue:value forKey:@"commentStatus"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"postId"];
    } else if ([key isEqualToString:@"title_plain"]) {
        [self setValue:value forKey:@"titlePlain"];
    } else if ([key isEqualToString:@"next_title"]) {
        [self setValue:value forKey:@"nextTitle"];
    } else if ([key isEqualToString:@"next_url"]) {
        [self setValue:value forKey:@"nextURL"];
    } else if ([key isEqualToString:@"previous_title"]) {
        [self setValue:value forKey:@"previousTitle"];
    } else if ([key isEqualToString:@"previous_url"]) {
        [self setValue:value forKey:@"previousURL"];
    } else {
        //[super setValue:value forUndefinedKey:key];
        NSLog(@"Undefined key post: %@ with value: %@", key, value);
    }
}

- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.attachments) {
        [dictionary setObject:self.attachments forKey:@"attachments"];
    }
    
    if (self.author) {
        [dictionary setObject:self.author forKey:@"author"];
    }
    
    if (self.categories) {
        [dictionary setObject:self.categories forKey:@"categories"];
    }
    
    [dictionary setObject:@(self.commentCount) forKey:@"commentCount"];
    
    if (self.commentStatus) {
        [dictionary setObject:self.commentStatus forKey:@"commentStatus"];
    }
    
    if (self.comments) {
        [dictionary setObject:self.comments forKey:@"comments"];
    }
    
    if (self.content) {
        [dictionary setObject:self.content forKey:@"content"];
    }
    
    if (self.date) {
        [dictionary setObject:self.date forKey:@"date"];
    }
    
    if (self.excerpt) {
        [dictionary setObject:self.excerpt forKey:@"excerpt"];
    }
    
    [dictionary setObject:@(self.postId) forKey:@"postId"];
    
    if (self.modified) {
        [dictionary setObject:self.modified forKey:@"modified"];
    }
    
    if (self.slug) {
        [dictionary setObject:self.slug forKey:@"slug"];
    }
    
    if (self.status) {
        [dictionary setObject:self.status forKey:@"status"];
    }
    
    if (self.tags) {
        [dictionary setObject:self.tags forKey:@"tags"];
    }
    
    if (self.thumbnail) {
        [dictionary setObject:self.thumbnail forKey:@"thumbnail"];
    }
    
    if (self.title) {
        [dictionary setObject:self.title forKey:@"title"];
    }
    
    if (self.titlePlain) {
        [dictionary setObject:self.titlePlain forKey:@"titlePlain"];
    }
    
    if (self.type) {
        [dictionary setObject:self.type forKey:@"type"];
    }
    
    if (self.url) {
        [dictionary setObject:self.url forKey:@"url"];
    }
    
    return dictionary;
}

@end
