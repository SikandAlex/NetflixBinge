//
//  MovieTableViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewController: UITableViewController {
    
    private var shows: [Show]?
    
    var category = ""
    var startRating = 0
    var endRating = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        Fetcher().fetchShows(category: category, startRating: startRating, endRating: endRating) { [weak self] (shows) in
            self?.shows = shows
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
        cell.titleLabel.text = shows?[indexPath.row].title
        cell.synopsisLabel.text = shows?[indexPath.row].synopsis
        cell.imdbLabel.text = "IMDB ID: " + ((shows?[indexPath.row].imdbid) ?? "N/A")
        cell.posterImageView.sd_setImage(with: URL(string: (shows?[indexPath.row].imgUrl)!), placeholderImage: UIImage(named: "placeholderImg.png"))
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
        
        //controller.bingeTimeLabel.text =
        Fetcher().convertId(imdbId: (shows?[indexPath.row].imdbid)!) { [weak self] (id) in
                Fetcher().getRuntime(tmdbId: id) {
                    [weak self] (runtime) in
                    DispatchQueue.main.async {
                        controller.bingeTimeLabel.text = self?.getBingeTimeString(minutes: runtime)
                    }
                    return self?.getBingeTimeString(minutes: runtime)
                }
                return id
            }
        self.present(controller, animated: true)
    }
}
