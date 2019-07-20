//
//  AlbumManager.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//


import Foundation
import UIKit

class ArtistManager {
    
    static let artist = ArtistManager()
    
    
    // MARK:- get Artist List
    
    func getArtistList(vc:UIViewController?,paramDict:Dictionary<String,Any>?,onSuccess: ((ArtistResultList?) -> Void)? = nil, onError: ((LMAPIError) -> Void)? = nil) {
        
        //http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/l imit=25/xml
        
        let url = String(format: "%@%", k_APIHost)
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        api.request(url: urlString!, method: .get,parameters: nil) { response in
            
            if response.code == 200 {
                
                SharedClass.sharedInstance.showProgressHUD(false)
                
                var objResultList:ArtistResultList?
                
                var authInfo: Dictionary<String,Any> = Dictionary()
                authInfo[ResponseConstant.responsecode] = response.code
                
                if (response.body as? Dictionary<String,Any>) != nil {
                    
                    if let jsonData = response.jsonString?.data(using: .utf8) {
                        if let resultList = try? JSONDecoder().decode(ArtistResultList.self, from: jsonData){
                            objResultList = resultList
                        }
                    }
                }
                onSuccess!(objResultList)
            }
            else if response.code == 204 {
                onError!(ErrorManager.onerror.noDataFound)
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else if response.code == 401 {
                if let data = response.body as? Dictionary<String,Any> {
                    let message:String = data[ResponseConstant.message] as! String
                    //                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:message, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
                else {
                    SharedClass.sharedInstance.showProgressHUD(false)
                    SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
                }
            }
            else if response.code == 444 {
                SharedClass.sharedInstance.showProgressHUD(false)
            }
            else {
                SharedClass.sharedInstance.showProgressHUD(false)
                onError!(ErrorManager.onerror.unKnownError)
                
                SharedAlert.alert.displayAlertMessage(viewController: vc,strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: MessageConstant.commonButtonTitle.ok)
            }
        }
    }
}



