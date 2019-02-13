//
//  DataObjects.swift
//  ImagePicker
//
//  Created by Joe Black on 13/02/2019.
//  Copyright © 2019 High Lander Aviation LTD. All rights reserved.
//

import Foundation


class ImageData {
    let imgNumber, imgName: String
    var imgTitle: String
    
    init(_ number: String, _ name: String, _ title: String) {
        self.imgNumber = number
        self.imgName = name
        self.imgTitle = title
    }
}
