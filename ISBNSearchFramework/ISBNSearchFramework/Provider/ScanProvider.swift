//
//  ScanProvider.swift
//  ISBNSearchFramework
//
//  Created by Alican Karayelli on 17/09/2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

public enum ScanProvider {
    case google
    case amazon
    case isbnplus
}

public protocol ScanProviderDelegate {
    func scanProvider(scanProvider: ScanProvider, didSucceed book: BookModel)
    func scanProvider(scanProvider: ScanProvider, didError error: Error)
}
