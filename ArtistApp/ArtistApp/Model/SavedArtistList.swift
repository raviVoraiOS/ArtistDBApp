//
//  SavedArtistList.swift
//  ArtistApp
//
//  Created by Ravi vora on 20/07/19.
//  Copyright © 2019 Ravi vora. All rights reserved.
//

import Foundation

struct SavedArtistList : Codable {
    let name : String?
    let image : String?
    let price : String?
    let title : String?
    let link : String?
    let id : String?
    let releaseDate : String?
    let artistLink:String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case image = "image"
        case price = "price"
        case title = "title"
        case link = "link"
        case id = "id"
        case releaseDate = "releaseDate"
        case artistLink = "artistLink"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        artistLink = try values.decodeIfPresent(String.self, forKey: .artistLink)
    }
    
}
