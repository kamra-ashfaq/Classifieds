//
//  homeEntity.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//
import Foundation
import ObjectMapper

struct homeEntity: Mappable {
    var uid: String?
    var name: String?
    var price: String?
    var imageUrl: [String]?
    var imageThumbnail: [String]?
    var created_at: String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        uid     <- map["uid"]
        name     <- map["name"]
        price     <- map["price"]
        imageUrl     <- map["image_urls"]
        imageThumbnail     <- map["image_urls_thumbnails"]
        created_at    <- map["created_at"]
    }
}

struct resultEntity: Mappable {
    var results: [homeEntity]?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        results     <- map["results"]
    }
}
