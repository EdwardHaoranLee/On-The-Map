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
    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var loadingImage: UIImageView!
    
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
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            print(true)
        } else {
            print(false)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
