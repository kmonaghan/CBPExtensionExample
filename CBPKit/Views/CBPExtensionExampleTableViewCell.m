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
static const CGFloat CBPTodayTableViewCellPadding = 10.0;
static const CGFloat CBPTodayTableViewCellVerticalPadding = 5.0;
static const CGFloat CBPTodayImageHeight = 60.0;

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
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        NSDictionary *views = @{@"postCommentLabel": self.postCommentLabel,
                                @"postDateLabel": self.postDateLabel,
                                @"postImageView": self.postImageView,
                                @"postTitleLabel": self.postTitleLabel};
        
        if (self.todayCell) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%f)-[postTitleLabel]-(%f)-[postCommentLabel]-(%f)-[postDateLabel]-(%f)-|", CBPTodayTableViewCellVerticalPadding, CBPTodayTableViewCellVerticalPadding, CBPTodayTableViewCellVerticalPadding, CBPTodayTableViewCellVerticalPadding]
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[postImageView(%f)]-(%f)-[postTitleLabel]-(%f)-|", CBPTodayImageHeight,CBPTodayTableViewCellPadding, CBPTodayTableViewCellPadding]
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[postImageView]-(%f)-[postCommentLabel]-(%f)-|", CBPTodayTableViewCellPadding, CBPTodayTableViewCellPadding]
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[postImageView]-(%f)-[postDateLabel]-(%f)-|", CBPTodayTableViewCellPadding, CBPTodayTableViewCellPadding]
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:views]];
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.postImageView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0f
                                                                          constant:0]];
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.postImageView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0f
                                                                          constant:CBPTodayImageHeight]];
        } else {
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
                                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                                     metrics:nil
                                                                                       views:views]];
        }
        
        self.constraintsUpdated = YES;
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.postTitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentView.frame) - (CBPExtensionExampleTableViewCellPadding * 2) - (self.todayCell ? CBPTodayImageHeight : 0);
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

- (void)setTodayCell:(BOOL)todayCell
{
    if (todayCell) {
        self.constraintsUpdated = NO;
    
        [self setNeedsUpdateConstraints];
    }
    
    _todayCell = todayCell;
}

- (UILabel *)postCommentLabel
{
    if (!_postCommentLabel) {
        _postCommentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _postCommentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _postCommentLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        
        
        if (self.todayCell) {
            _postCommentLabel.textColor = [UIColor whiteColor];
        }
        
        
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
        
        if (self.todayCell) {
            _postDateLabel.textColor = [UIColor whiteColor];
        }
        
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
        
        if (self.todayCell) {
            _postTitleLabel.textColor = [UIColor whiteColor];
        }
        
        [self.contentView addSubview:_postTitleLabel];
    }
    
    return _postTitleLabel;
}

@end
