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
        
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(resignResponder(_:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func resignResponder(_ sender: UITapGestureRecognizer) {
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Setup Layout
extension LoginViewController {
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
}

//MARK: - Action
extension LoginViewController {
    @IBAction func buttonLogin(sender: UIButton) {
        
        if textFieldEmail.text != "" && textFieldPassword.text != "" {
            Auth.auth().signIn(withEmail: self.textFieldEmail.text!, password: self.textFieldPassword.text!) { (user, error) in
                
                if error == nil {
                    print("success Login")
                    
                    //Go to the ListViewController if the login is sucessful
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let rootVc = storyBoard.instantiateViewController(withIdentifier: "HomeList")
                    self.navigationController?.pushViewController(rootVc, animated: true)
                    
                } else {
                    self.setupAlertView(withMessage: (error?.localizedDescription)!)
                }
            }
        } else {
            setupAlertView(withMessage: "Mohon isi semua kolom")
        }
        
        
    }
    
    func setupAlertView(withMessage message: String) {
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
