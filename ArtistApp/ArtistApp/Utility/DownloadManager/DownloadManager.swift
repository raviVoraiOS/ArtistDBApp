//
//  DownloadManager.swift
//  DownloadManager
//
//  Created by Ravi Vora on 20/07/19.
//  Copyright © 2016 Ravi Vora. All rights reserved.
//

import UIKit

class DownloadManager: NSObject {

    static let sharedManager : DownloadManager = {
        let instance = DownloadManager()
        return instance
    }()

    private override init() {}
    
    
    func downloadImage(_ imageurl:String,placeHolderImage:String,completion: @escaping (_ imageToLoad:UIImage?) -> Void) {
        
        
        var imageLoad:UIImage = UIImage(named:placeHolderImage)!
        if imageurl.count==0 {
            completion(imageLoad)
            return
        }
        
        let url:String = imageurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let session: URLSession = self.prepareSessionForRequest()
        var request: URLRequest = URLRequest(url: URL(string:url)!)
        request.httpMethod = "GET"
        
        if let _ = URLCache.shared.cachedResponse(for: request as URLRequest) {
            
           // print(" cache found:)")
                let cachedResponse: CachedURLResponse = URLCache.shared.cachedResponse(for: request as URLRequest)!
            let response:HTTPURLResponse = cachedResponse.response as! HTTPURLResponse
            
            if response.statusCode == 200 {
                let newImage:UIImage? = UIImage(data: cachedResponse.data)
                
                if newImage != nil {
                    imageLoad = UIImage(data: cachedResponse.data)!
                    completion(imageLoad)
                }
                else {
                    completion(imageLoad)
                }
            }
            else
            {
                completion(imageLoad)
            }
        }
        else {
            
            print(" cache not found:")

            var dataTask: URLSessionDataTask
            dataTask = session.dataTask(with: request, completionHandler: {(data : Data?, response : URLResponse?, error :Error?) in
                
                if (error != nil && data != nil && data?.count != 0) {
                  //  imageLoaded = UIImage(named: "")!
                  //  completion(imageToLoad:imageLoaded)

                    self.getDataFromUrl(url) { data in
                        DispatchQueue.main.async {
                            
                            imageLoad = UIImage(data:data!)!
                            completion(imageLoad)
                        }
                    }
                }
            } );
            dataTask.resume()
        }
        
    }
    
    func getDataFromUrl(_ url:String, completion: @escaping ((_ data: Data?) -> Void)) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            completion(NSData(data: data!) as Data)
            }) .resume()
    }


    func setSharedCacheForImages() {
        let cashSize: Int = 250 * 1024 * 1024
        let cashDiskSize: Int = 250 * 1024 * 1024
        let imageCache: URLCache = URLCache(memoryCapacity: cashSize, diskCapacity: cashDiskSize, diskPath: "someCachePath")
        URLCache.shared = imageCache
    }
    
    func prepareSessionForRequest() -> URLSession {
        let sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: defaultConfigObject)
        return session
    }
}
