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
        self.view.backgroundColor = UIColor.blackColor()
        titleLabel.textColor = UIColor.whiteColor()
        yearLabel.textColor = UIColor.whiteColor()
        ratingsLabel.textColor = UIColor.whiteColor()
        mpaaRating.textColor = UIColor.whiteColor()
        synopsisLabel.textColor = UIColor.whiteColor()
        
        
        loadMovieDetails()
    }

    @IBAction func onTap(sender: AnyObject) {
        println("OnTap ")
        if(self.posterView.alpha == 1)
        {
        slideUpAnimation()
        }
        else
        {
            slideDownAnimation()
        }
    }
    
    func loadMovieDetails()
    {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        self.titleLabel.text = (defaults.valueForKey("title") as String)
      
        var label = UILabel(frame: CGRectMake(0, 0, 20, 21))
       // label.center = CGPointMake(160, 284) //CGPointMake(20, 20)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.orangeColor()
       // label.shadowColor = UIColor.blackColor()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(14))
        label.text = (defaults.valueForKey("title") as String)
        
        self.navigationItem.titleView = label
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
    
    func slideUpAnimation() {
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
            var synopsisLabelFrame = self.synopsisLabel.frame
            synopsisLabelFrame.origin.y =
            self.posterView.frame.minY
            
            self.posterView.alpha = 0
            self.titleLabel.alpha = 0;
            self.yearLabel.alpha = 0;
            self.ratingsLabel.alpha = 0;
            self.mpaaRating.alpha = 0;
            
            self.synopsisLabel.frame = synopsisLabelFrame
            }, completion: { finished in
                println("label slide up!")
        })
    }
    
    func slideDownAnimation() {
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
            var synopsisLabelFrame = self.synopsisLabel.frame
            synopsisLabelFrame.origin.y =
                497
            
            self.posterView.alpha = 1
            self.titleLabel.alpha = 1;
            self.yearLabel.alpha = 1;
            self.ratingsLabel.alpha = 1;
            self.mpaaRating.alpha = 1;
            
            self.synopsisLabel.frame = synopsisLabelFrame
            }, completion: { finished in
                println("label slide down!")
        })
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
