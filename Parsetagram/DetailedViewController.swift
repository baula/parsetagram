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
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
