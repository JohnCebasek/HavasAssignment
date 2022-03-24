//
//  RedditDetailVIewController.h
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-24.
//

#import <UIKit/UIKit.h>

@class RedditDataItem;

NS_ASSUME_NONNULL_BEGIN

@interface RedditDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *upCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;

@property (nonatomic, strong) RedditDataItem *dataItem;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end

NS_ASSUME_NONNULL_END
