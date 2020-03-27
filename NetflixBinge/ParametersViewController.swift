//
//  ParametersViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/27/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import TTRangeSlider

class ParametersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var category: String = "Movies"
    var pickerData = ["Movies", "TV Shows"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    

    @IBOutlet weak var imdbSlider: TTRangeSlider!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.category = pickerData[row]
    }
    
    
    @IBAction func search(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "resultsVC") as! MovieTableViewController
        controller.startRating = Int(imdbSlider.selectedMinimum)
        controller.endRating = Int(imdbSlider.selectedMaximum)
        controller.category = self.category
        print(Int(imdbSlider.selectedMinimum))
        print(Int(imdbSlider.selectedMaximum))
        print(self.category)
        self.present(controller, animated: true, completion: nil)
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
