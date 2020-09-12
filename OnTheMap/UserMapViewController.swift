//
//  UserMapViewController.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-12.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit
import MapKit

class UserMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var userLocations: [UserLocation]!

    override func viewDidLoad() {
        super.viewDidLoad()

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
