//
//  SearchBookError.swift
//  ISBNSearchFramework
//
//  Created by Alican Karayelli on 17/09/2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

enum SearchBookError: Error {
    case unknownError
    case connectionError
    case bookNotFoundError
    case unknownStructureError
}
