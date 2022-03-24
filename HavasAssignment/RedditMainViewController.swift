//
//  ViewController.swift
//  HavasAssignment
//
//  Created by John Cebasek on 2022-03-23.
//

import UIKit

typealias DownloadCompletion = (Bool) -> Void

extension UIImageView {
    func downloadArticleImage(_ URLString: String,
                              imageCache: NSCache<NSString, UIImage>,
                              completion: (DownloadCompletion)?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            completion?(true)
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url,
                                       completionHandler: { (data, response, error) in
                if error != nil {
                    debugPrint("Error Loading Data From URL: \(String(describing: error))")
                    return
                }
                
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage,
                                             forKey: NSString(string: URLString))
                        DispatchQueue.main.async {
                            self.image = downloadedImage
                            completion?(true)
                        }
                    }
                    else {
                        completion?(false)
                    }
                }
            }).resume()
        }
    }
}

class RedditMainViewController: UITableViewController  {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private var contentManager = RedditContentManager()
    private let cellIdentifier = "NewsItemCell"
    private let sectionCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCache.name = "Image Cache"
        imageCache.countLimit = 50
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 84.0
        tableView.rowHeight = UITableView.automaticDimension
        
        if contentManager.items.count == 0 {
            contentManager.loadRedditHomeData {
                DispatchQueue.main.async {
                    self.initializeTable()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Only load the data once
    }
    
    func initializeTable()
    {
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // sender is the UItableViewCell that the user has tapped or the accessory button has been tapped
    // Ask the tableview for the indexpath
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let nextViewController = segue.destination as? RedditDetailViewController {
            var redditDataItem: RedditDataItem
            
            guard let indexPath = self.tableView.indexPath(for: sender as! RedditArticleTableCell) else {
                return
            }
            
            redditDataItem = contentManager.item(at: indexPath.row)
            nextViewController.title = redditDataItem.redditTitle
            nextViewController.dataItem = redditDataItem
        }
    }
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return contentManager.numberOfItems
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contentManager.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> RedditArticleTableCell {
        let cell: RedditArticleTableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RedditArticleTableCell
        let item = contentManager.item(at: indexPath.row) as RedditDataItem
        
        cell.config(with: item)
        
        if (item.redditThumbNailURL != "") {
            cell.redditArticleImage?.downloadArticleImage(item.redditThumbNailURL,
                                                          imageCache: self.imageCache,
                                                          completion: { (success) in
                if success {
                    tableView.beginUpdates()
                    item.redditThumbNail = cell.redditArticleImage?.image
                    tableView.endUpdates()
                }
            })
        }
        
        return cell
    }
}


