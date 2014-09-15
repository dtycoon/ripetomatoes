//
//  DetailsViewController.swift
//  ripetomatoes
//
//  Created by Deepak Agarwal on 9/15/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var posterView: UIImageView!
   
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet var mpaaRating: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetails()
        // Do any additional setup after loading the view.
    }

    func loadMovieDetails()
    {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        self.titleLabel.text = (defaults.valueForKey("title") as String)
        var year = defaults.integerForKey("year")
        self.yearLabel.text = "\(year)"
        var critics = defaults.integerForKey("critics_score")
        var audience = defaults.integerForKey("audience_score")
        self.ratingsLabel.text = "Critics score: \(critics) Audience score: \(audience)"
        self.mpaaRating.text = (defaults.valueForKey("mpaa_rating") as String)
        self.synopsisLabel.text = (defaults.valueForKey("synopsis") as String)
        var thumbUrl = (defaults.valueForKey("thumbnail") as String)
        var profileUrl = (defaults.valueForKey("profile") as String)
        var originalUrl = (defaults.valueForKey("original") as String)
        self.posterView.setImageWithURL(NSURL(string: thumbUrl))
        self.posterView.setImageWithURL(NSURL(string: originalUrl))
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTapBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
