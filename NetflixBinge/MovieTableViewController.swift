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

class MovieTableViewController: UITableViewController {
    
    private var shows: [Show]?
    
    var category = "TV Shows"
    var startRating = 0
    var endRating = 10
    
    @objc func signOut() {
        print("signOut")
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
     
      

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Saved Shows", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        
        
        
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        //self.tableView.backgroundColor =  UIColor(red:0.75, green:0.22, blue:0.17, alpha:1.00)
        tableView.tableFooterView = UIView()
        Fetcher().fetchShows(category: category, startRating: startRating, endRating: endRating) { [weak self] (shows) in
            self?.shows = shows
            self?.shows = shows.sorted(by: {Double($0.avgRating ?? 0.0) > Double($1.avgRating ?? 0.0)})
            print(shows)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shows?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.posterImageView.layer.cornerRadius = 8
        cell.cellContainerView.layer.cornerRadius = 8
        cell.titleLabel.text = shows?[indexPath.row].title?.replacingOccurrences(of: "&#39;", with: "'")
        cell.synopsisLabel.text = shows?[indexPath.row].synopsis?.replacingOccurrences(of: "&#39;", with: "'")
        var rating = shows?[indexPath.row].avgRating ?? 0.0
        rating = (rating)*2
        rating = Float(round(10*rating)/10)
        cell.ratingLabel.text = "\(rating)"
        let yr = shows?[indexPath.row].year as! Int
        cell.votesLabel.text = String(yr)
        cell.cellContainerView.backgroundColor = .black
            
           
        cell.backgroundColor = UIColor.black
        cell.posterImageView.sd_setImage(with: URL(string: (shows?[indexPath.row].imgUrl)!), placeholderImage: UIImage(named: "placeholderImg.png"))
        cell.cellContainerView.layer.shadowColor = UIColor.white.cgColor
        cell.cellContainerView.layer.shadowOpacity = 0.35
        cell.cellContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.posterImageView.layer.shadowColor = UIColor.black.cgColor
        cell.posterImageView.layer.shadowOpacity = 0.3
        cell.posterImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        return cell
        
    }
    
    func minutesToDaysHours(minutes : Int) -> (Int, Int) {
      return (minutes / (60*24), (minutes % (60*24)) / 60)
    }
    
    func getBingeTimeString(minutes:Int) -> String {
        let (d, h) = minutesToDaysHours(minutes: minutes)
        var resStr = String(d) + " Days, " + String(h) + " Hours"
        resStr = resStr.replacingOccurrences(of: "0 Days, ", with: "")
        return resStr
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! DetailViewController
        controller.imgUrl = shows?[indexPath.row].imgUrl ?? ""
        controller.titleText = shows?[indexPath.row].title ?? ""
        controller.synopsis = shows?[indexPath.row].synopsis ?? ""
        var rating = shows?[indexPath.row].avgRating ?? 0.0
        rating = (rating)*2
        rating = Float(round(10*rating)/10)
        controller.rating = "\(rating)"
       // controller.ratingLabel.text = "\(rating)"
        
        
 
        Fetcher().convertId(imdbId: (shows?[indexPath.row].imdbid)!) { [weak self] (id) in
                Fetcher().getRuntime(tmdbId: id) {
                    [weak self] (runtime, seasons) in
                    DispatchQueue.main.async {
                        controller.bingeTimeLabel.text = self?.getBingeTimeString(minutes: runtime)
                        if seasons == 1 {
                             controller.seasonsLabel.text = String(seasons) + " Season"
                        }
                        else {
                            controller.seasonsLabel.text = String(seasons) + " Seasons"
                        }
                        
                       
                    }
                    return self?.getBingeTimeString(minutes: runtime)
                }
                return id
            }
        self.present(controller, animated: true)
    }
}
