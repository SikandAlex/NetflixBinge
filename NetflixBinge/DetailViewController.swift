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
    
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bingeTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var titleText = ""
    var synopsis = ""
    var rating = ""
    
    
    var imgUrl: String = ""
    @IBOutlet weak var detailImageView: UIImageViewAligned!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText = titleText.replacingOccurrences(of: "&#39;", with: "'")
        synopsis = synopsis.replacingOccurrences(of: "&#39;", with: "'")
        self.detailImageView.contentMode = .scaleAspectFill
        self.detailImageView.alignBottom = true
            self.detailImageView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholderImg.png"))
        self.synopsisLabel.sizeToFit()
        self.detailImageView.layer.cornerRadius = 8
        self.titleLabel.text = titleText
        self.synopsisLabel.text = synopsis
        self.ratingLabel.text = rating
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
