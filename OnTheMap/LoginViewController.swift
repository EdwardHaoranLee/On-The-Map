//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-08.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingImage: UIImageView!
    
    var userLocations: [UserLocation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = ""
        passwordTextField.text = ""

        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        self.setLoggingIn(true)
        UdacityClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
    }

    @IBAction func signup(_ sender: Any) {
        guard let url = URL(string: "https://auth.udacity.com/sign-up") else { return }
        UIApplication.shared.open(url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarVC = segue.destination as! TabBarViewController
        tabBarVC.modalPresentationStyle = .fullScreen
        
        let userMapNVC = tabBarVC.viewControllers![0] as! UINavigationController
        let userMapVC = userMapNVC.topViewController as! UserMapViewController
        
        let userListNVC = tabBarVC.viewControllers![1] as! UINavigationController
        let userListVC = userListNVC.topViewController as! UserListViewController
        
        userMapVC.userLocations = self.userLocations
        userListVC.userLocations = self.userLocations
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        
        if success {
            ParseClient.downloadMostRecent100Locations(completion: self.handleDownloadUserLocations(locations:error:))
        } else {
            setLoggingIn(false)
            self.showLoginFailure(message: "Username or password is incorrect.")
        }
    }
    
    func handleDownloadUserLocations(locations: [UserLocation]?, error: Error?){
        if let locations = locations {
            self.userLocations = locations
            self.setLoggingIn(false)
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            setLoggingIn(false)
            self.showDownloadFailure(message: "Logined successfully but the user locations cannot be downloaded. Please check your network.")
        }
    }
    
    func setLoggingIn(_ isLoggingIn: Bool){
        /*
         This method is used to disabling view when logging in.
         */
        if isLoggingIn {
            self.loadingImage.isHidden = false
            self.loadingImage.startAnimating()
        } else {
            self.loadingImage.isHidden = true
            self.loadingImage.stopAnimating()
        }
        self.loginButton.isEnabled = !isLoggingIn
        self.emailTextField.isEnabled = !isLoggingIn
        self.passwordTextField.isEnabled = !isLoggingIn
    }
    
    func showLoginFailure(message: String){
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func showDownloadFailure(message: String){
        let alertVC = UIAlertController(title: "Download Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
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
