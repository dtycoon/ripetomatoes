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
        self.synopsisLabel.sizeToFit()
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
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.orangeColor()
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
            var titleLabelFrame = self.titleLabel.frame
            var yearLabelFrame = self.yearLabel.frame
            var ratingsLabelFrame = self.ratingsLabel.frame
            var mpaaRatingFrame = self.mpaaRating.frame
            
            titleLabelFrame.origin.y =
            self.posterView.frame.minY
            
            yearLabelFrame.origin.y =
                self.posterView.frame.minY
            
            ratingsLabelFrame.origin.y =
                self.posterView.frame.minY + self.titleLabel.frame.height
            mpaaRatingFrame.origin.y =
                self.posterView.frame.minY + self.titleLabel.frame.height + self.ratingsLabel.frame.height
            
     
            synopsisLabelFrame.origin.y =
                self.posterView.frame.minY + self.titleLabel.frame.height + self.ratingsLabel.frame.height + self.mpaaRating.frame.height
      
       /*     let maxHeight : CGFloat = self.synopsisLabel.frame.maxY - synopsisLabelFrame.origin.y
            let rect = self.synopsisLabel.attributedText?.boundingRectWithSize(CGSizeMake(self.synopsisLabel.frame.width, maxHeight),
                options: .UsesLineFragmentOrigin, context: nil).height
            
            
            synopsisLabelFrame.size.height = rect! */
            
        /*
            synopsisLabelFrame.size.height = self.synopsisLabel.frame.maxY - synopsisLabelFrame.origin.y
            */
            self.posterView.alpha = 0
            
            self.synopsisLabel.frame = synopsisLabelFrame
            self.titleLabel.frame = titleLabelFrame
            self.yearLabel.frame = yearLabelFrame
            self.ratingsLabel.frame = ratingsLabelFrame
            self.mpaaRating.frame = mpaaRatingFrame
            }, completion: { finished in
                println("label slide up!")
        })
    }
    
    func slideDownAnimation() {
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
            var synopsisLabelFrame = self.synopsisLabel.frame
            var titleLabelFrame = self.titleLabel.frame
            var yearLabelFrame = self.yearLabel.frame
            var ratingsLabelFrame = self.ratingsLabel.frame
            var mpaaRatingFrame = self.mpaaRating.frame
           
            self.posterView.alpha = 1
            
            titleLabelFrame.origin.y =
                self.posterView.frame.maxY
            
            yearLabelFrame.origin.y =
                self.posterView.frame.maxY
           
            ratingsLabelFrame.origin.y =
                self.posterView.frame.maxY + self.titleLabel.frame.height
            mpaaRatingFrame.origin.y =
                self.posterView.frame.maxY + self.titleLabel.frame.height + self.ratingsLabel.frame.height
            
            synopsisLabelFrame.origin.y =
                self.posterView.frame.maxY + self.titleLabel.frame.height + self.ratingsLabel.frame.height + self.mpaaRating.frame.height
       
    /*        let maxHeight : CGFloat = self.synopsisLabel.frame.maxY - synopsisLabelFrame.origin.y
            let rect = self.synopsisLabel.attributedText?.boundingRectWithSize(CGSizeMake(self.synopsisLabel.frame.width, maxHeight),
                options: .UsesLineFragmentOrigin, context: nil).height
            
            
            synopsisLabelFrame.size.height = rect! */

            
           self.synopsisLabel.frame = synopsisLabelFrame
            self.titleLabel.frame = titleLabelFrame
            self.yearLabel.frame = yearLabelFrame
            self.ratingsLabel.frame = ratingsLabelFrame
            self.mpaaRating.frame = mpaaRatingFrame
            
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
