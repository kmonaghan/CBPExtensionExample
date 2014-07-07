//
//  CBPExtensionExamplePostViewController.m
//  CBPExtensionExample
//
//  Created by Karl Monaghan on 14/06/2014.
//  Copyright (c) 2014 Crayons and Brown Paper. All rights reserved.
//

#import "CBPExtensionExamplePostViewController.h"

@import CBPKit;

@interface CBPExtensionExamplePostViewController ()
@property (nonatomic) CBPExtensionExamplePost *post;
@property (nonatomic) UITextView *textView;
@end

@implementation CBPExtensionExamplePostViewController

- (instancetype)initWithPost:(CBPExtensionExamplePost *)post
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        _post = post;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.textView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSError *error;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithData:[self.post.content dataUsingEncoding:NSISOLatin1StringEncoding]
                                                                          options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                               documentAttributes:nil
                                                                            error:&error];
    
    if (!error) {
        self.textView.attributedText = attributedText;
    } else {
        self.textView.text = [NSString stringWithFormat:@"%@", error];
    }
}

#pragma mark -
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.view.frame];
    }
    
    return _textView;
}

@end
