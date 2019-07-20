//
//  URLConstant.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


//HostURL

let k_APIHost     = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=25/json"

struct requestConstants {
    
    static let kGET  = "GET"
    static let kPUT  = "PUT"
    static let kPOST = "POST"
    
    static let kApplicationHeader        =  "application/x-www-form-urlencoded"
    static let kContent                  =  "Content-type"
    static let kJSONContent              =  "application/json; charset=UTF-8"
    static let kAccept                   =  "Accept"
    static let kAcceptType               =  "text/javascript"
    static let kContentLength            =  "Content-Length"
    static let kauthorization            =  "Authorization"
    static let kContentType              =  "text/javascript"
}
