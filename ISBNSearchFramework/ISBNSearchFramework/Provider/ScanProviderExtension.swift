//
//  ScanProviderExtension.swift
//  ISBNSearchFramework
//
//  Created by Alican Karayelli on 17/09/2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation


public extension ScanProvider {
    
    public func scanForProvider(controllerDelegate: ScanProviderDelegate) -> Search {
        
        let search: Search
        
        switch self {
        case .google:
            search = GoogleSearch(delegate: controllerDelegate)
            break
        case .amazon:
            search = GoogleSearch(delegate: controllerDelegate)
            break
        case .isbnplus:
            search = GoogleSearch(delegate: controllerDelegate)
            break
        }
        
        return search
    }
}
