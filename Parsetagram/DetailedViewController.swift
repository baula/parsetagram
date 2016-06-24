//
//  DetailedViewController.swift
//  Parsetagram
//
//  Created by Baula Xu on 6/23/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailedViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var imageLabel: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    var post: PFObject!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = post["author"] as? PFUser {
            self.usernameLabel.text = user.username
        }
        if let caption = post["caption"] as? String {
            self.captionLabel.text = caption
        }
        if let imageFile = post["media"] as? PFFile {
            self.imageLabel.file = imageFile
            self.imageLabel.loadInBackground()
        }
        
        if let date = post["timestamp"] as? String{
            self.timestampLabel.text = date
        }
        
        if let likes = post["likesCount"] as? Int{
            self.likeLabel.text = "\(likes)"
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        if let likes = post["likesCount"] as? Int{
            post["likesCount"] = likes+1
            self.likeLabel.text = "\(post["likesCount"])"
        }
        
        post.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            if let error = error{
                print(error)
            }
            else {
                print("yay!")
            }
        }
)
    
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
