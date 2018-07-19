//
//  ViewController.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    var erporateModel: ErporateModel?
    var modelData: [ModelData] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        self.title = "List Wisata"
        
        setIsLogin(withString: "1")
        requestErporateData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "erporateListTableViewCell", bundle: nil), forCellReuseIdentifier: "erporateCell")
        tableView.backgroundColor = UIColor.init(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setIsLogin(withString string: String) {
        let defaults = UserDefaults.standard
        defaults.set(string, forKey: "Login")
    }
    
    static func getName() -> String {
        let defaults = UserDefaults.standard
        let name = defaults.object(forKey: "fullName") as? String
        return name != nil ? name! : ""
    }
    
    func requestErporateData() {
        Alamofire.request("http://erporate.com/bootcamp/jsonBootcamp.php").responseJSON { (responseData) -> Void in
            switch responseData.result {
                
            case .success(let response):
                if let responseValue = ErporateModel(dictionary: (response as? [String : Any])!) {
                    print(responseValue)
                    self.erporateModel = responseValue
                    self.modelData = (self.erporateModel?.modelData)!
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func buttonLogout() {
        let alert = UIAlertController(title: "Keluar", message: "Anda yakin ingin keluar?", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "Tidak", style: .default) { (action:UIAlertAction) in
            
        }
        let action = UIAlertAction(title: "Ya", style: .default) { (action:UIAlertAction) in
            self.logout()
        }
        alert.addAction(cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func logout() {
        setIsLogin(withString: "0")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavBarLogin")
        self.present(vc, animated: true, completion: nil)
        //self.navigationController?.pushViewController(initialViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "erporateCell") as? erporateListTableViewCell {
            
            cell.configureCell(withData: modelData[indexPath.row])
            
            return cell
        } else {
            return erporateListTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = modelData[indexPath.row]
        let vc = DetailListViewController(nibName: "DetailListViewController", bundle: nil)
        vc.address = data.alamatPariwisata
        vc.modelData = modelData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

