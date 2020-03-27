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

    override func viewDidLoad() {
        super.viewDidLoad()
        Fetcher().fetchShows { [weak self] (shows) in
            self?.shows = shows
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.imdbLabel.text = "IMDB ID: " + (shows?[indexPath.row].imdbid)!
        cell.posterImageView.sd_setImage(with: URL(string: (shows?[indexPath.row].imgUrl)!), placeholderImage: UIImage(named: "placeholderImg.png"))
        return cell
    }
    

   

}
