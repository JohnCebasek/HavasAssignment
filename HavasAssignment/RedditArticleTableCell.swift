//
//  RedditArticleTableCell.swift
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-23.
//

import UIKit

class RedditArticleTableCell: UITableViewCell {
    @IBOutlet weak var redditArticleText: UILabel?
    @IBOutlet weak var redditArticleImage: UIImageView?
    @IBOutlet weak var redditArticleUpCount: UILabel?
    @IBOutlet weak var redditArticleCommentCount: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with newsItem: RedditDataItem) {
        self.redditArticleText?.text = newsItem.redditTitle
        self.redditArticleImage?.image = newsItem.redditThumbNail
        self.redditArticleUpCount?.text = String(format: "%ld", newsItem.redditUpCount)
        self.redditArticleCommentCount?.text = String(format: "%ld", newsItem.redditCommentCount)
    }
}
