//
//  ArtistList.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


struct ArtistResultList : Codable {
    let feed : Feed?
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
    }
}

struct Feed : Codable {
    let album : [Album]?
    
    enum CodingKeys: String, CodingKey {
        case album = "entry"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album = try values.decodeIfPresent([Album].self, forKey: .album)
    }
}


struct Album : Codable {
    let name : Name?
    let image : [Image]?
    let price : Price?
    let title : Title?
    let link : [Link]?
    let id : Id?
    let artist : Artist?
    let releaseDate : ReleaseDate?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "im:name"
        case image = "im:image"
        case price = "im:price"
        case title = "title"
        case link = "link"
        case id = "id"
        case artist = "im:artist"
        case releaseDate = "im:releaseDate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(Name.self, forKey: .name)
        image = try values.decodeIfPresent([Image].self, forKey: .image)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        title = try values.decodeIfPresent(Title.self, forKey: .title)
        link = try values.decodeIfPresent([Link].self, forKey: .link)
        id = try values.decodeIfPresent(Id.self, forKey: .id)
        artist = try values.decodeIfPresent(Artist.self, forKey: .artist)
        releaseDate = try values.decodeIfPresent(ReleaseDate.self, forKey: .releaseDate)
    }
    
}


struct Name : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

struct Image : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}


struct Price : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}


struct Title : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

struct Icon : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}

struct Link : Codable {
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}

struct Id : Codable {
    let label : String?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
    }
    
}


struct Artist : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}


struct ReleaseDate : Codable {
    let label : String?
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
    
}


struct Attributes : Codable {
    let rel : String?
    let type : String?
    let href : String?
    
    enum CodingKeys: String, CodingKey {
        
        case rel = "rel"
        case type = "type"
        case href = "href"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rel = try values.decodeIfPresent(String.self, forKey: .rel)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        href = try values.decodeIfPresent(String.self, forKey: .href)
    }
    
}
