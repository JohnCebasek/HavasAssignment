//
//  RedditDetailViewController.m
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-24.
//

#import <HavasAssignment/HavasAssignment-Swift.h>
#import "RedditDetailViewController.h"

@interface RedditDetailViewController()
@end

@implementation RedditDetailViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *const decimalFormatter = @"%ld";

    if (self.dataItem.redditThumbNail == nil)
    {
        self.imageHeightConstraint.constant = 0;
    }
    else
    {
        self.articleImageView.image = self.dataItem.redditThumbNail;
    }

    self.titleLabel.text = self.dataItem.redditTitle;
    self.upCountLabel.text = [NSString stringWithFormat:decimalFormatter,
                              self.dataItem.redditUpCount];
    self.commentCountLabel.text = [NSString stringWithFormat:decimalFormatter,
                                   self.dataItem.redditCommentCount];
    
}

@end
