//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-14.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    var location: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = location{
            self.uploadLocation()
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let findLocationVC = segue.destination as! FindLocationViewController
        findLocationVC.locationString = self.locationTextField.text!
        findLocationVC.addLocationVC = self
    }
    
    @IBAction func findLocation(_ sender: Any) {
        guard self.locationTextField.text != "" else {
            showEmptyTextWarning(message: "Empty Location")
            return
        }
        guard self.urlTextField.text != "" else {
            showEmptyTextWarning(message: "Empty URL")
            return
        }
        guard self.firstNameTextField.text != "", self.lastNameTextField.text != "" else {
            showEmptyTextWarning(message: "Empty First and/or Last Name")
            return
        }
        performSegue(withIdentifier: "findLocationSegue", sender: nil)
    }
    
    func showEmptyTextWarning(message: String){
        let alertVC = UIAlertController(title: message, message: "You cannot leave the text field empty.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func uploadLocation(){
        let requestLocation = UserLocationPOST(uniqueKey: "", firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, mapString: self.locationTextField.text!, mediaURL: urlTextField.text!, latitude: Double(self.location.x), longitude: Double(self.location.y))
        ParseClient.postLocation(location: requestLocation, completion: self.handlePOSTLocationResponse(result:error:))
    }
    
    func handlePOSTLocationResponse(result: Bool, error: Error?) {
        if result {
            self.urlTextField.text = ""
            self.firstNameTextField.text = ""
            self.lastNameTextField.text = ""
            self.locationTextField.text = ""
            self.location = nil
            let alertVC = UIAlertController(title: "Congratulation!", message: "Your location pin has been uploaded successfully.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "Something Wrong", message: "Your location pin was not uploaded properly.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
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
