//
//  BookModel.swift
//  ISBNSearchFramework
//
//  Created by Alican Karayelli on 17/09/2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

public struct BookModel {
    
    var name: String = ""
    var description: String = ""
    var isbn: String = ""
    var coverImage: String?
    var authors: [String]?
    var publishDate: String?
    var pageCount: String?

    
    init() {}
    
}
