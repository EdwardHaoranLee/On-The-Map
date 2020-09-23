//
//  UserViewController.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-22.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit
class UserViewController: UIViewController{
    
    var userLocations: [UserLocation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showInvalidURLWarning(message: String){
        let alertVC = UIAlertController(title: message, message: "is an invalid URL.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func logout(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addLocationVC = segue.destination as! AddLocationViewController
        addLocationVC.modalPresentationStyle = .fullScreen
    }
    
    func addLocation(_ sender: Any){
        performSegue(withIdentifier: "addLocation", sender: nil)
    }
    
    func refresh(_ sender: Any) {
        ParseClient.downloadMostRecent100Locations(completion: {
            locations, error in
            if let locations = locations {
                self.userLocations = locations
            } else {
                let alertVC = UIAlertController(title: "Something Wrong", message: "User list cannot be refreshed.", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        })
    }
}
