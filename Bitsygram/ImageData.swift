//
//  ImageData.swift
//  Bitsygram
//
//  Created by tbredemeier on 4/6/18.
//  Copyright © 2018 tbredemeier. All rights reserved.
//

import Foundation

class ImageData: Codable {

    var image: Data
    var like: Bool
    var text: String

    init(image: Data, like: Bool, text: String) {
        self.image = image
        self.like = like
        self.text = text
    }
}
