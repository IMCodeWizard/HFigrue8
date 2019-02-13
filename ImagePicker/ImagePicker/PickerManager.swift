//
//  PickerManager.swift
//  ImagePicker
//
//  Created by Joe Black on 13/02/2019.
//  Copyright © 2019 High Lander Aviation LTD. All rights reserved.
//

import Foundation


class PickerManager: NSObject {
    
    static let shared = PickerManager()
    
    private var collection = [ImageData]()
    
    func loadCollection() {
        
        /** Try to fetch stored collection if it fails let's genarate one */
        if let collection = StorageManager.fetchLocalCollection() {
            self.collection = collection
            return
        }
        
        self.collection = generateCollection()
    }
    
    private func generateCollection() -> [ImageData] {
        
        // 1. Generate
        var collectionData = [ImageData]()
        
        for index in 0...19 {
            let imageData = ImageData("\(index)", "image_\(index)", "N/A")
            collectionData.append(imageData)
        }
        // 2. Store data
        StorageManager.storeCollection(collectionData)
        
        return collectionData
    }
    
    func getRandomImageData() -> ImageData {
        
        // If collection is empty we should load it =)
        if collection.isEmpty {
            loadCollection()
        }
        
        let imageData = collection[Int.random(in: 0..<collection.count)]
        
        return imageData
    }
    
    func getCollection() -> [ImageData] {
        return self.collection
    }
    
    func saveCollection() {
        StorageManager.storeCollection(collection)
    }
    
}
