//
//  DataManager.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let fetch:DataManager = {
        let instance = DataManager()
        return instance
    }()

    private init() {}
  
    
    /*
     * This method will save ArtistList into Core data
     */
    
    func saveArtistList(albumList:[Album],completion: @escaping (_ isSaved:Bool?) -> Void) {
        
        DispatchQueue.main.async {
            
            for(index,_) in albumList.enumerated() {
                let currentAlbum:Album = albumList[index]
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                var listArray:Array<Any> = Array()
                
                //Check For Duplicate
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY)
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                        var dataDict:Dictionary<String,Any> = Dictionary()
                        dataDict[ATTR_id] = data.value(forKey: ATTR_id) as! String
                        listArray.append(dataDict)
                    }
                }
                catch {
                    print("Failed")
                }
                var isFound:Bool = false
                for(index,_) in listArray.enumerated() {
                    let currentDict:Dictionary<String,Any> =  listArray[index] as! Dictionary<String, Any>
                    if currentDict[ATTR_id] as! String == currentAlbum.id!.label! {
                        isFound = true
                        break
                    }
                }
                
            if isFound == false {
                let entity = NSEntityDescription.entity(forEntityName: ENTITY, in: context)
                let newTerm = NSManagedObject(entity: entity!, insertInto: context)
                newTerm.setValue(currentAlbum.id!.label!, forKey: ATTR_id)
                newTerm.setValue(currentAlbum.name!.label!, forKey: ATTR_name)
                newTerm.setValue(currentAlbum.title!.label!, forKey: ATTR_title)
                newTerm.setValue(currentAlbum.image![0].label!, forKey: ATTR_image)
                newTerm.setValue(currentAlbum.link![0].attributes!.href!, forKey: ATTR_link)
                newTerm.setValue(currentAlbum.price!.label!, forKey: ATTR_price)
                newTerm.setValue(currentAlbum.releaseDate!.label!, forKey: ATTR_releaseDate)
                newTerm.setValue(currentAlbum.artist!.attributes!.href!, forKey: ATTR_artistLink)

                    do {
                        try context.save()
                        completion(true)
                    } catch {
                        print("Failed saving")
                        completion(false)
                    }
                }
            }
        }
        completion(false)
    }
    
    /*
     * This method will fetch ArtistList from Core data
     */
    func getArtistList(completion: @escaping (_ savedList:[SavedArtistList]?) -> Void) {
        
        var savedList:[SavedArtistList]?
        DispatchQueue.main.async {
            var listArray:Array<Any> = Array()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:ENTITY)
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    var dataDict:Dictionary<String,Any> = Dictionary()
                    dataDict[ATTR_id] = data.value(forKey: ATTR_id) as! String
                    dataDict[ATTR_name] = data.value(forKey: ATTR_name) as! String
                    dataDict[ATTR_title] = data.value(forKey: ATTR_title) as! String
                    dataDict[ATTR_image] = data.value(forKey: ATTR_image) as! String
                    dataDict[ATTR_price] = data.value(forKey: ATTR_price) as! String
                    dataDict[ATTR_releaseDate] = data.value(forKey: ATTR_releaseDate) as! String
                    dataDict[ATTR_artistLink] = data.value(forKey: ATTR_artistLink) as! String
                    listArray.append(dataDict)
                }
                savedList = try! DictionaryDecoder().decode([SavedArtistList].self, from: listArray)
                completion(savedList)
            }
            catch {
                print("Failed")
                completion(nil)
            }
        }
        completion(nil)
    }
    
}
