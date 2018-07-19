//
//  erporateListTableViewCell.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import UIKit
import SDWebImage

class erporateListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    
    func configureCell(withData data: ModelData) {
        setupSubViews(withImageURL: data.gambarPariwisata, withTitle: data.namaPariwisata, andAddress: data.alamatPariwisata)
    }
    
}

//MARK: - Setup View
extension erporateListTableViewCell {
    func setupSubViews(withImageURL imageURL: String, withTitle title: String, andAddress address: String) {
        setupImageTitle(withImageURL: imageURL)
        setupLabelTitle(withTitle: title)
        setupLabelAddress(withAddress: address)
    }
    
    func setupImageTitle(withImageURL imageURL : String) {
        imageTitle.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder"))

    }
    
    func setupLabelTitle(withTitle title: String) {
        labelTitle.text = title
    }
    
    func setupLabelAddress(withAddress address: String) {
        labelAddress.text = address
    }
}
