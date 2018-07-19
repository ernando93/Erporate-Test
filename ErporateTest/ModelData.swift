//
//  ModelData.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import Foundation

final class ModelData: NSObject {
    let namaPariwisata: String
    let alamatPariwisata: String
    let detailPariwisata: String
    let gambarPariwisata: String
    
    init?(dictionary: [String: Any]) {
        if let namaPariwisata = dictionary["nama_pariwisata"] as? String {
            self.namaPariwisata = namaPariwisata
        } else {
            self.namaPariwisata = ""
        }
        
        if let alamatPariwisata = dictionary["alamat_pariwisata"] as? String {
            self.alamatPariwisata = alamatPariwisata
        } else {
            self.alamatPariwisata = ""
        }
        
        if let detailPariwisata = dictionary["detail_pariwisata"] as? String {
            self.detailPariwisata = detailPariwisata
        } else {
            self.detailPariwisata = ""
        }
        
        if let gambarPariwisata = dictionary["gambar_pariwisata"] as? String {
            self.gambarPariwisata = gambarPariwisata
        } else {
            self.gambarPariwisata = ""
        }
    }
}
