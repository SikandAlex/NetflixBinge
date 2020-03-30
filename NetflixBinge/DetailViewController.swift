//
//  DetailViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/30/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bingeTimeLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    var imgUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.detailImageView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholderImg.png"))
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
