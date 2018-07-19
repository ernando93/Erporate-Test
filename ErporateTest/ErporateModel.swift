//
//  ErporateModel.swift
//  ErporateTest
//
//  Created by Ernando on 7/18/18.
//  Copyright © 2018 eDEV's. All rights reserved.
//

import Foundation

final class ErporateModel: NSObject {
    let result: String
    var modelData = [ModelData]()
    
    init?(dictionary: [String: Any]) {
        if let result = dictionary["result"] as? String {
            self.result = result
        } else {
            self.result = ""
        }
        
        if let modelDatas = dictionary["data"] as? [[String: Any]] {
            for data in modelDatas {
//                let modelData = ModelData(dictionary: data)
//                self.modelData.append(modelData!)
                self.modelData.append(ModelData(dictionary: data)!)
            }
        }
    }
}
