//
//  LoginViewController.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldPassword.isSecureTextEntry = true
        setupTextFieldLayout(withTextField: textFieldEmail)
        setupTextFieldLayout(withTextField: textFieldPassword)
        self.setupButtonLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupButtonLayout() {
        buttonRegister.layer.borderWidth = 2.0
        buttonRegister.layer.cornerRadius = 3.0
        buttonRegister.layer.borderColor = UIColor(red: 20.0/255.0, green: 119.0/255.0, blue: 233.0/255.0, alpha: 1.0).cgColor
        buttonRegister.layer.masksToBounds = true
    }
    
    func setupTextFieldLayout(withTextField textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 6.0
        textField.layer.borderColor = UIColor(red: 206.0/255.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1.0).cgColor
        textField.layer.masksToBounds = true
    }
    
    @IBAction func buttonLogin(sender: UIButton) {
        Auth.auth().signIn(withEmail: self.textFieldEmail.text!, password: self.textFieldPassword.text!) { (user, error) in
            
            if error == nil {
                
                //Print into the console if successfully logged in
                print("You have successfully logged in")
                
                //Go to the HomeViewController if the login is sucessful
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVc = storyBoard.instantiateViewController(withIdentifier: "HomeList")
                self.navigationController?.pushViewController(rootVc, animated: true)
                //self.present(rootVc, animated: true, completion: nil)
                
            } else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}
