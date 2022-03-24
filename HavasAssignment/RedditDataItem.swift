//
//  RedditDataItem.swift
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-23.
//


import Foundation
import UIKit

@objc public class RedditDataItem: NSObject {
    @objc public var redditUpCount: Int
    @objc public var redditTitle : String
    @objc public var redditThumbNailURL: String
    @objc public var redditCommentCount: Int
    @objc public var redditThumbNail: UIImage? = nil
    
    internal init(redditTitle: String,
                  upsCount: Int,
                  commentCount: Int,
                  thumbNailImageURL: String) {
        self.redditTitle = redditTitle
        self.redditUpCount = upsCount
        self.redditCommentCount = commentCount
        self.redditThumbNailURL = thumbNailImageURL
        self.redditThumbNail = nil
    }
    
    // MARK: - -- Debugging Helpers --
    
    override public var debugDescription: String {
        let debugStringFormat = "Title: %@ Image URL: %@ Up Count: %d Comment Count: %d"
        let result = String(format: debugStringFormat,
                            self.redditTitle,
                            self.redditThumbNailURL,
                            self.redditUpCount,
                            redditCommentCount)
        
        return result
    }
    
    override public var description: String {
        return self.debugDescription
    }
    
    @objc func debugQuickLookObject() -> Any? {
        return self.debugDescription
    }
}
