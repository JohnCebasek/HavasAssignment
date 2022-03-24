//
//  ContentManager.swift
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-23.
//

import Foundation
import UIKit

let DataKey = "data"
let ChildrenKey = "children"
let TitleKey = "title"
let ThumbNailKey = "thumbnail"
let UpCountKey = "ups"
let CommentCountKey = "num_comments"

public class RedditContentManager {
    
    let dataSourceURL = "https://www.reddit.com/.json"
    let countOfSections = 1
    let defaultSession = URLSession(configuration: .default)
    let noDescriptionKey = "NoDescription"
    
    var dataTask: URLSessionDataTask?
    var items: NSMutableArray = NSMutableArray.init()
    
    enum JSONError: String, Error {
        case NoData = "Error: No Data Returned"
        case ConversionFailed = "Error: Conversion from JSON failed"
    }
    
    public var numberOfItems: Int {
        return items.count
    }
    
    public var numberOfSections: Int {
        return countOfSections
    }
    
    public func item(at index: Int) -> RedditDataItem {
        return items[index] as! RedditDataItem;
    }
    
    public func loadRedditHomeData(completion: (() -> Void)?)
    {
        guard let endPoint = URL(string: dataSourceURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: endPoint) { (data, response, error ) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                guard let topLevelData = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                
                guard let dataDictionary: NSDictionary = topLevelData.object(forKey: DataKey) as? NSDictionary else {
                    throw JSONError.NoData
                }
                let childrenArray: NSArray? = dataDictionary.object(forKey: ChildrenKey) as? NSArray
                
                guard let itemCount = childrenArray?.count else {
                    throw JSONError.NoData
                }
                
                for count in 0 ... (itemCount - 1) {
                    let containerDict: NSDictionary? = childrenArray?.object(at: count) as? NSDictionary
                    let articleDict = containerDict?.object(forKey: DataKey) as? NSDictionary
                    
                    guard let title = articleDict?.object(forKey: TitleKey) as? String else {
                        break       // Dictionary may be broken, so try the next one
                    }
                    
                    guard var articleImageURL = articleDict?.object(forKey: ThumbNailKey) as? String else {
                        break
                    }
                    
                    guard let upCount = articleDict?.object(forKey: UpCountKey) as? Int else {
                        break
                    }
                    
                    guard let commentCount = articleDict?.object(forKey: CommentCountKey) as? Int else {
                        break
                    }
                    
                    if self.verifyURL(urlString: articleImageURL) == false {
                        articleImageURL = ""
                    }
                                        
                    let dataItem = RedditDataItem(redditTitle: title,
                                                  upsCount: upCount,
                                                  commentCount: commentCount,
                                                  thumbNailImageURL: articleImageURL)
                    self.items.add(dataItem)
                }
                
                completion?()
            }

            catch let error as JSONError {
                debugPrint(error.localizedDescription)
            }
            catch let error as NSError {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
    
    // Normally I would do this with regEx and friends, but I can't remember how right now...
    fileprivate func verifyURL(urlString: String) -> Bool
    {
        var result = false
        guard let urlFromString = NSURL(string: urlString) as NSURL? else {
            return result
        }
        let hostString = urlFromString.scheme
        
        if hostString == "http" ||
            hostString == "https" {
            result = true
        }
        
        return result
    }
}

