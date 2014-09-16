//
//  MoviesViewController.swift
//  ripetomatoes
//
//  Created by Deepak Agarwal on 9/14/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl:UIRefreshControl!
    let button1 = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let label1 = UILabel() as UILabel
    
  //  @IBOutlet var errorLabel: UILabel!
    
     var movies: [NSDictionary] = []
    
    
   
    
    func loadMovies()
    {
        let YourApiKey = "9nee6kpg3mtbpnr4y2eujegq"
    /*    let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey */
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=" + YourApiKey
        
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if (error != nil) {
                println("API error: \(error), \(error.userInfo)")
                self.refreshControl.endRefreshing()
             //   self.makeLayout()
            }
            else
            {
            var errorValue: NSError? = nil
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            if (errorValue != nil) {
                println("Error parsing json: \(errorValue)")
                self.refreshControl.endRefreshing()
           //     self.makeLayout()
            }
            else
            {
            //self.errorLabel.hidden = true
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            }
            }
        })

        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.blackColor()
        tableView.tintColor = UIColor.whiteColor()
        tableView.separatorColor = UIColor.darkGrayColor()
        var label = UILabel(frame: CGRectMake(0, 0, 20, 21))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.orangeColor()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(14))
        label.text = "Movies"
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        navigationItem.titleView = label
   //     self.navigationItem.
        loadMovies()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    func refresh(sender:AnyObject)
    {
        println(" reloading from refresh ")
        loadMovies()
    }
    
      @IBAction func onTapReload(sender: UIButton) {
        if(sender as NSObject == self.reloadButton)
        {
            println(" reloading ")
        loadMovies()
        }
  
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailSegue" {
        var rowIndex = tableView.indexPathForSelectedRow()?.row
        println(" row selected = \(rowIndex)")
        storeMovieDetails(rowIndex!)
            
        }
    }

    func storeMovieDetails (jsonIndex: Int)
    {
        println(" storeMovieDetailsrow selected = \(jsonIndex)")
        var movieItem = movies[jsonIndex] as NSDictionary
        println(" movies total = \(movies.count)")
    //    println(" movieItem selected = \(movieItem)")
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValuesForKeysWithDictionary(movieItem)
        defaults.setValue(movieItem["title"], forKey: "title")
        var year = movieItem["year"] as Int
        defaults.setInteger(year, forKey: "year")
     
        defaults.setValue(movieItem["mpaa_rating"], forKey: "mpaa_rating")
     
        var ratings = movieItem["ratings"] as NSDictionary
        var critics_score = ratings["critics_score"] as Int
        defaults.setInteger(critics_score, forKey: "critics_score")
        var audience_score = ratings["audience_score"] as Int
        defaults.setInteger(audience_score, forKey: "audience_score")
  
        defaults.setValue(movieItem["synopsis"], forKey: "synopsis")
        var posters = movieItem["posters"] as NSDictionary
        defaults.setValue(posters["thumbnail"], forKey: "thumbnail")
        var profile = (posters["thumbnail"] as NSString).stringByReplacingOccurrencesOfString("tmb", withString: "pro")
        defaults.setValue(profile, forKey: "profile")
        
        let detailed = (posters["thumbnail"] as NSString).stringByReplacingOccurrencesOfString("tmb", withString: "det")
        defaults.setValue(detailed, forKey: "detailed")
        
        let original = (posters["thumbnail"] as NSString).stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        defaults.setValue(original, forKey: "original")
        defaults.synchronize()
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
 {
    return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        println("I'm at row: \(indexPath.row), section: \(indexPath.section)")
       
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        var movieItem = movies[indexPath.row]
        cell.movieTitleLabel.text = movieItem["title"] as? String
        cell.movieSynopsisLabel.text = movieItem["synopsis"] as? String
        
        var posters = movieItem["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        return cell
        
    }
    

    func tableView(_tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
