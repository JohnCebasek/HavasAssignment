//
//  ArticleTableViewCell.swift
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-23.
//

import UIKit

class RedditArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsItemTextLabel: UILabel?
    @IBOutlet weak var newsItemImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with newsItem: RedditDataItem) {
        newsItemTextLabel?.text = newsItem.redditTitle
        newsItemImage?.image = newsItem.redditThumbNail
    }
}
