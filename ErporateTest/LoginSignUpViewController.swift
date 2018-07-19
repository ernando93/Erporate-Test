//
//  LoginSignUpViewController.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {

    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonSignUP: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Erporate"
        
        setupButtonLayout(withButton: buttonLogin)
        setupButtonLayout(withButton: buttonSignUP)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Back"
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupButtonLayout(withButton button: UIButton) {
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 3.0
        button.layer.borderColor = UIColor(red: 20.0/255.0, green: 119.0/255.0, blue: 233.0/255.0, alpha: 1.0).cgColor
        button.layer.masksToBounds = true
    }
    
    @IBAction func buttonLoginClick(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVc = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        self.navigationController?.pushViewController(rootVc, animated: true)
        //self.present(rootVc, animated: true, completion: nil)
    }

    @IBAction func buttonSignUPClick(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVc = storyBoard.instantiateViewController(withIdentifier: "SignVC")
        self.navigationController?.pushViewController(rootVc, animated: true)
        //self.present(rootVc, animated: true, completion: nil)
    }
}
