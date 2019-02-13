//
//  StorageManager.swift
//  ImagePicker
//
//  Created by Joe Black on 13/02/2019.
//  Copyright © 2019 iOS Ninja. All rights reserved.
//

import Foundation


class StorageManager {
    
    private static let COLLECTION = "collection"
    
    class func fetchLocalCollection() -> [ImageData]? {
        
        guard let data = UserDefaults.standard.object(forKey: COLLECTION) as? Data else {
            return .none
        }
        
        guard let collection = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [ImageData] else {
            return .none
        }
        
        return collection
    }
    
    class func storeCollection(_ data: [ImageData]) {
        
        guard let archive = try? NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false) else {
            print("Cannot archive data")
            return
        }
        
        UserDefaults.standard.set(archive, forKey: COLLECTION)
        UserDefaults.standard.synchronize()
        print("Collection saved")
    }
}
