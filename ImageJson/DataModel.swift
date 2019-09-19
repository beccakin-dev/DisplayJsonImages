//
//  DataModel.swift
//  ImageJson
//
//  Created by Becca Akinlaja on 9/10/19.
//  Copyright © 2019 Becca Akinlaja. All rights reserved.
//

import Foundation

class DataModel {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init(dictionary: [String: Any]) {
        self.albumId = dictionary["albumId"] as! Int ?? 0
        self.id = dictionary["id"] as! Int ?? 0
        self.title = dictionary["title"] as! String ?? ""
        self.url = dictionary["url"] as! String ?? ""
        self.thumbnailUrl = dictionary["thumbnailUrl"] as! String ?? ""
    }
}
