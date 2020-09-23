//
//  UserListViewController.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-11.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit

class UserListViewController: UserViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! UserListTableViewCell
        let userLocation = self.userLocations[indexPath.row]
        
        cell.UpperLabel?.text = userLocation.firstName + " " + userLocation.lastName
        cell.LowerLabel?.text = userLocation.mediaURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = self.userLocations[indexPath.row]
        var stringURL = location.mediaURL
        if (!stringURL.starts(with: "https://")){
            stringURL = "https://" + stringURL
        }
        if let url = URL(string: stringURL){
            UIApplication.shared.open(url) {
                success in
                if !success {
                    self.showInvalidURLWarning(message: stringURL) // showing alert as new page
                }
            }
        } else {
            self.showInvalidURLWarning(message: stringURL) // showing alert as new page
        }
        
    }
    
    @IBAction override func logout(_ sender: Any) {
        super.logout(sender)
    }
    
    @IBAction override func addLocation(_ sender: Any) {
        super.addLocation(sender)
    }
    
    @IBAction override func refresh(_ sender: Any) {
        super.refresh(sender)
        self.tableView.reloadData()
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
