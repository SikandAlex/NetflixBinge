//
//  MovieTableViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import Hero

class MovieTableViewController: UITableViewController {
    
    // Store the list of shows
    private var shows: [Show]?
    
    // Sign the user out (will be automatically handled by listener defined in AppDelegate.swift)
    @objc func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable Hero animation library
        self.isHeroEnabled = true
        
        // Setup background color
        self.view.backgroundColor = UIColor.black
        
        // Setup navigation buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Saved Shows", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        // Setup Navigation Bar
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        // Fetch the TV Shows and provide a completion handler
        Fetcher().fetchShows() { [weak self] (shows) in
            // Sort the shows once they are recieved by the client (sorting using API options doesn't work well)
            self?.shows = shows.sorted(by: {Double($0.avgRating ?? 0.0) > Double($1.avgRating ?? 0.0)})
            // Reload the data for the Table View
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            // DEBUG OPTION
            //print(shows)
        }
        
    }

    // MARK: - Table view data source
    
    // The number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // The number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the reusable cell from the story board
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        // Setup shadows on the poster image and the cell itself
        cell.cellContainerView.layer.shadowColor = UIColor.white.cgColor
        cell.cellContainerView.layer.shadowOpacity = 0.35
        cell.cellContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.posterImageView.layer.shadowColor = UIColor.black.cgColor
        cell.posterImageView.layer.shadowOpacity = 0.3
        cell.posterImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        // Rounded corners
        cell.posterImageView.layer.cornerRadius = 8
        cell.cellContainerView.layer.cornerRadius = 8
        
        // Set cell background color
        cell.cellContainerView.backgroundColor = .black
        cell.backgroundColor = UIColor.black
        
        // Replace the &#39; character with an apostrophe for the title and synopsis
        cell.titleLabel.text = shows?[indexPath.row].title?.replacingOccurrences(of: "&#39;", with: "'")
        cell.synopsisLabel.text = shows?[indexPath.row].synopsis?.replacingOccurrences(of: "&#39;", with: "'")
        
        // Set the rating to the avgRating or 0.0 if it does not exist
        var rating = shows?[indexPath.row].avgRating ?? 0.0
        
        // Rating is from 0-5 but we want to scale it to 0-10
        rating = (rating)*2
        rating = Float(round(10*rating)/10)
        cell.ratingLabel.text = "\(rating)"
        
        // Set the year
        let yr = shows?[indexPath.row].year as! Int
        cell.yearLabel.text = String(yr)
        
        // Set the TV Show image
        cell.posterImageView.sd_setImage(with: URL(string: (shows?[indexPath.row].imgUrl)!), placeholderImage: UIImage(named: "placeholderImg.png"))
        
        // Return the cell
        return cell
        
    }
    
    // Convert minutes to days and hours
    // Returns a tuple (days, hours)
    func minutesToDaysHours(minutes : Int) -> (Int, Int) {
      return (minutes / (60*24), (minutes % (60*24)) / 60)
    }
    
    // Convert minutes to a readable string specifiying the number of days and hours
    // to binge the show
    func getBingeTimeString(minutes:Int) -> String {
        let (d, h) = minutesToDaysHours(minutes: minutes)
        var resStr = String(d) + " Days, " + String(h) + " Hours"
        resStr = resStr.replacingOccurrences(of: "0 Days, ", with: "")
        return resStr
    }
    
    // Define what happens when a show is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! DetailViewController
        
        // Scale and truncate the rating to one decimal place again
        var rating = shows?[indexPath.row].avgRating ?? 0.0
        rating = (rating)*2
        rating = Float(round(10*rating)/10)
        
        // Pass the image URL, title text, and synopsis text to the ViewController about to be presented
        controller.imgUrl = shows?[indexPath.row].imgUrl ?? ""
        controller.titleText = shows?[indexPath.row].title ?? ""
        controller.synopsis = shows?[indexPath.row].synopsis ?? ""
        controller.rating = "\(rating)"
        
        Fetcher().convertId(imdbId: (shows?[indexPath.row].imdbid)!) { [weak self] (id) in
            Fetcher().getRuntime(tmdbId: id) {[weak self] (runtime, seasons) in
                DispatchQueue.main.async {
                    controller.bingeTimeLabel.text = self?.getBingeTimeString(minutes: runtime)
                    // If there is only one season then display '1 Season'
                    if seasons == 1 {
                         controller.seasonsLabel.text = String(seasons) + " Season"
                    }
                    // If there is more than one season then display 'X Seasons'
                    else {
                        controller.seasonsLabel.text = String(seasons) + " Seasons"
                    }
                }
                return self?.getBingeTimeString(minutes: runtime)
            }
            return id
        }
        
        
        // This is a little hack to make sure that the MovieCell (UITableViewCell) has the same identifier
        // as the identifiers for the corresponding views in the ViewController about to be presented
        let mc = self.tableView.cellForRow(at: indexPath) as! MovieCell
    
        mc.posterImageView.heroID = "img" + String(indexPath.row)
        mc.synopsisLabel.heroID = "synop" + String(indexPath.row)
        mc.titleLabel.heroID = "title" + String(indexPath.row)
        mc.ratingLabel.heroID = "rating" + String(indexPath.row)
        mc.cellContainerView.heroID = "background" + String(indexPath.row)
       
        controller.isHeroEnabled = true
        controller.imgHeroId = "img" + String(indexPath.row)
        controller.synopHeroId = "synop" + String(indexPath.row)
        controller.titleHeroId = "title" + String(indexPath.row)
        controller.ratingHeroId = "rating" + String(indexPath.row)
        controller.backgroundHeroId = "background" + String(indexPath.row)
        
        // Push the DetailViewController onto the navigation stack
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
