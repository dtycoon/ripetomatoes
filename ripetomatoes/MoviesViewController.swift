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
    
     var movies: [NSDictionary] = []
    
    func loadMovies()
    {
        let YourApiKey = "9nee6kpg3mtbpnr4y2eujegq"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
        })

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
        tableView.delegate = self
        tableView.dataSource = self
        
   /*     let YourApiKey = "9nee6kpg3mtbpnr4y2eujegq"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
  
            self.movies = dictionary["movies"] as [NSDictionary]
            self.tableView.reloadData()
        
        }) */
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
        let index = tableView.indexPathForSelectedRow()?.row
        println(" row selected = \(index)")
            
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("some_string_to_save", forKey: "some_key_that_you_choose")
        defaults.setInteger(123, forKey: "another_key_that_you_choose")
        defaults.synchronize()
        }
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
    

}
