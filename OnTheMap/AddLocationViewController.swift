//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-14.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if let location = self.locationTextField.text {
            if let urlString = self.urlTextField.text {
                
            } else {
                showEmptyTextWarning(message: "Empty URL")
            }
        } else {
            showEmptyTextWarning(message: "Empty Location")
        }
    }
    
    func showEmptyTextWarning(message: String){
        let alertVC = UIAlertController(title: message, message: "You cannot leave the text field empty.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
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
