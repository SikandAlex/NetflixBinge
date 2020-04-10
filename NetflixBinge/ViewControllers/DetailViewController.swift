//
//  DetailViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/30/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class DetailViewController: UIViewController {
    
    // Outlets for labels and image views
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bingeTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    // Used to set the text for the UILabels defined above (except for bingeTime and seasonsLabel) because they are not
    // computed in advance
    var titleText = ""
    var synopsis = ""
    var rating = ""
    
    // Used to set the image
    var imgUrl: String = ""
    
    // Used to set the Hero ID of views for animation purposes
    var imgHeroId = ""
    var synopHeroId = ""
    var titleHeroId = ""
    var ratingHeroId = ""
    var backgroundHeroId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Rounded corners and scaleAspectFill mode for the image view
        self.detailImageView.layer.cornerRadius = 8
        self.detailImageView.contentMode = .scaleAspectFill
        // Set the image to load asynchronously from the URL (it's cached)
        self.detailImageView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholderImg.png"))
        
        // Replace the &#39; character with an apostrophe for the title and synopsis
        titleText = titleText.replacingOccurrences(of: "&#39;", with: "'")
        synopsis = synopsis.replacingOccurrences(of: "&#39;", with: "'")
        
        // Set the text and size the view to fit the text
        self.synopsisLabel.text = synopsis
        self.synopsisLabel.sizeToFit()
        
        // Set the title and rating text
        self.titleLabel.text = titleText
        self.ratingLabel.text = rating
        
        // Setup the Hero IDs
        self.detailImageView.heroID = imgHeroId
        self.synopsisLabel.heroID = synopHeroId
        self.titleLabel.heroID = titleHeroId
        self.ratingLabel.heroID = ratingHeroId
        self.view.heroID = backgroundHeroId
    }


}
