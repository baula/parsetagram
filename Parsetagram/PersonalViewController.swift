//
//  PersonalViewController.swift
//  Parsetagram
//
//  Created by Baula Xu on 6/21/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class PersonalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var post: [PFObject] = []
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        let refreshControl = UIRefreshControl()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        refresh()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*@IBAction func onSignOut(sender: AnyObject) {
        self.performSegueWithIdentifier("LogoutSegue", sender: nil)
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.currentUser() will now be nil
        }
    }
 */
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                isMoreDataLoading = true
                
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // Code to load more results
                refresh()
            }
        }
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refresh()
        // Reload the tableView now that there is new data
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func refresh() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        var query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        
        query.whereKey("author", equalTo: PFUser.currentUser()!)
        
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock {
            (posts: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(posts!.count) messages.")
                // Do something with the found objects
                if let posts = posts {
                    self.post = posts
                    self.loadingMoreView!.stopAnimating()
                    self.tableView.reloadData()
                    print(posts)
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        self.isMoreDataLoading = false
        
    }
    // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
    // immediately.  Any code that depends on the query result should be moved
    // inside the completion block above.
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (post.count)
        return post.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonalCell", forIndexPath: indexPath) as! PersonalCell
        print(post)
        print("hello")
        let row = indexPath.row
        let po = post[row]
        
        if let user = po["author"] as? PFUser {
            cell.usernameLabel2.text = user.username
        }
        
        if let caption = po["caption"] as? String {
            cell.overviewLabel2.text = caption
        }
        //cell.imageLabel = po["media"]
        if let imageFile = po["media"] as? PFFile {
            cell.imageLabel2.file = imageFile
            cell.imageLabel2.loadInBackground()
        }
        
        if let like = po["likesCount"] as? Int{
            cell.likeLabel.text = "\(like)"
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.purpleColor()
        cell.selectedBackgroundView = backgroundView

        return cell
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
