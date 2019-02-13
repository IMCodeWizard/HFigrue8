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
        return UserDefaults.standard.object(forKey: COLLECTION) as? [ImageData]
    }
    
    class func storeCollection(_ data: [ImageData]) {
        UserDefaults.standard.set(data, forKey: COLLECTION)
        UserDefaults.standard.synchronize()
        print("Collection saved")
    }
}
