//
//  CBPExtensionExampleTableViewCell.m
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 13/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import <SDWebImageKit/SDWebImageKit.h>

#import "CBPExtensionExampleTableViewCell.h"

static const CGFloat CBPExtensionExampleTableViewCellPadding = 15.0;

@interface CBPExtensionExampleTableViewCell()
@property (nonatomic, assign) BOOL constraintsUpdated;
@property (nonatomic) UILabel *postCommentLabel;
@property (nonatomic) UILabel *postDateLabel;
@property (nonatomic) UIImageView *postImageView;
@property (nonatomic) UILabel *postTitleLabel;
@end

@implementation CBPExtensionExampleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.constraintsUpdated) {
        NSDictionary *views = @{@"postCommentLabel": self.postCommentLabel,
                                @"postDateLabel": self.postDateLabel,
                                @"postImageView": self.postImageView,
                                @"postTitleLabel": self.postTitleLabel};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[postTitleLabel]-(5)-[postImageView(150)]-(5)-[postDateLabel]-(5)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[postTitleLabel]-(%f)-|", CBPExtensionExampleTableViewCellPadding, CBPExtensionExampleTableViewCellPadding]
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[postImageView]-(%f)-|", CBPExtensionExampleTableViewCellPadding, CBPExtensionExampleTableViewCellPadding]
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[postDateLabel]-(>=0)-[postCommentLabel]-(%f)-|", CBPExtensionExampleTableViewCellPadding, CBPExtensionExampleTableViewCellPadding]
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.postCommentLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.postDateLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0f
                                                                      constant:0]];
        
        self.constraintsUpdated = YES;
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    self.postTitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentView.frame) - (CBPExtensionExampleTableViewCellPadding * 2);
    
    [super layoutSubviews];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.postCommentLabel.text = nil;
    self.postDateLabel.text = nil;
    self.postImageView.image = nil;
    self.postTitleLabel.text = nil;
}

#pragma mark -
- (void)setCommentCount:(NSInteger)commentCount
{
    if (commentCount < 1) {
        self.postCommentLabel.text = NSLocalizedString(@"No comments yet", @"Text for when there are no comments on a post");
    } else if (commentCount == 1) {
        self.postCommentLabel.text = NSLocalizedString(@"1 comment", @"A single comment on this post");
    } else {
        self.postCommentLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d comments", @"X comments on this post"), commentCount];
    }
}

- (void)setImageURI:(NSString *)imageURI
{
    [self.postImageView setImageWithURL:[NSURL URLWithString:imageURI]
                       placeholderImage:nil];
}

- (void)setPostDate:(NSString *)postDate
{
    self.postDateLabel.text = postDate;
    [self.postDateLabel sizeToFit];
}

- (void)setPostTitle:(NSString *)postTitle
{
    self.postTitleLabel.text = postTitle;
    [self.postTitleLabel sizeToFit];
}

- (UILabel *)postCommentLabel
{
    if (!_postCommentLabel) {
        _postCommentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _postCommentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _postCommentLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        [self.contentView addSubview:_postCommentLabel];
    }
    
    return _postCommentLabel;
}

- (UILabel *)postDateLabel
{
    if (!_postDateLabel) {
        _postDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _postDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _postDateLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        
        [self.contentView addSubview:_postDateLabel];
    }
    
    return _postDateLabel;
}

- (UIImageView *)postImageView
{
    if (!_postImageView) {
        _postImageView = [UIImageView new];
        _postImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _postImageView.contentMode = UIViewContentModeScaleAspectFill;
        _postImageView.clipsToBounds = YES;
        _postImageView.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_postImageView];
    }
    
    return _postImageView;
}

- (UILabel *)postTitleLabel
{
    if (!_postTitleLabel) {
        _postTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _postTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _postTitleLabel.numberOfLines = 0;
        _postTitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        [self.contentView addSubview:_postTitleLabel];
    }
    
    return _postTitleLabel;
}

@end
