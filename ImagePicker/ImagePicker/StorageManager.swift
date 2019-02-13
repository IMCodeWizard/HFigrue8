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
        
        guard let collection = try? [ImageData].self.decode(data: data) else {
            return .none
        }
        
        print("Local collection loaded")
        return collection
    }
    
    class func storeCollection(_ data: [ImageData]) {

        
        guard let encodedData = try? data.encode() else {
            print("Cannot encode data")
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: COLLECTION)
        UserDefaults.standard.synchronize()
        print("Collection saved")
    
    }
}
