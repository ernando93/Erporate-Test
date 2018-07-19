//
//  RegisterViewController.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var buttonRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialising firebase
        //FirebaseApp.configure()
        textFieldPassword.isSecureTextEntry = true
        setupTextFieldLayout(withTextField: textFieldEmail)
        setupTextFieldLayout(withTextField: textFieldPassword)
        setupButtonLayout()
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
    
    //button for registration
    @IBAction func buttonRegister(sender: UIButton) {
        let email = textFieldEmail.text
        let password = textFieldPassword.text
        
        if (password?.count)! >= 6 {
            Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user: User?, error) in
                if error == nil {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let rootVc = storyBoard.instantiateViewController(withIdentifier: "HomeList")
                    self.navigationController?.pushViewController(rootVc, animated: true)
                }else{
                    self.labelMessage.text = "Daftar gagal, Coba lagi!"
                }
                
            })
        } else {
            self.labelMessage.text = "Password harus 6 karakter"
        }
        
    }
    
}
