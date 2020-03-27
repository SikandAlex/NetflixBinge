//
//  ViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import Foundation
import SwiftSoup

class ViewController: UIViewController {
    
    private var shows: [Show]?
    private var baseUrl = "https://www.imdb.com/title/"
    
    func getRuntime(imdbid: String) {
        if let url = URL(string: baseUrl + imdbid) {
            do {
                let contents = try String(contentsOf: url)
                do {
                    let doc: Document = try SwiftSoup.parse(contents)
                    let episodes = try doc.getElementsByClass("bp_sub_heading").text()
                    let runtime = try doc.select("#titleDetails > div:nth-child(20) > time").text()
                    print(episodes)
                    print(runtime)
                   // print(runtime)
                } catch Exception.Error(let type, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //getTVShows()
        //self.getRuntime(imdbid: "tt10263466")
        
        Fetcher().fetchShows { [weak self] (shows) in
            self?.shows = shows
            
        }
 
        
        
        // Do any additional setup after loading the view.
    }


}

