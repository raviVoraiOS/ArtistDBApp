//
//  ResponseConstant.swift


import Foundation


class ResponseConstant  {
    
    //general
    static let responsecode = "code"
    static let data = "data"
    static let message = "msg"
    static let params = "params"
}

//Global null check

func ifnull(value : Any?) -> String? {
    if value is NSNull || value == nil {
        return ""
    } else {
        return value as? String
    }
}
