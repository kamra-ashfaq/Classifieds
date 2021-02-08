//
//  homeEntity.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Freddy

struct homeEntity {
    var name: String
    var price: String
    var imageUrl: String
    var imageThumbnail: String
}

extension homeEntity: JSONDecodable {
    
    init(json: JSON) throws {
        name = try json.getString(at: "name")
        price = try json.getString(at: "price")
        imageUrl = try json.getString(at: "image_urls")
        imageThumbnail = try json.getString(at: "image_urls_thumbnails")
    }
    
}
