//
//  GoogleSearch.swift
//  ISBNSearchFramework
//
//  Created by Alican Karayelli on 17/09/2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

public class GoogleSearch: Search {
    
    var scanProviderDelegate: ScanProviderDelegate
    
    init(delegate: ScanProviderDelegate){
        scanProviderDelegate = delegate
    }

    public func startSearching(isbn: String) {
        
        print("Will Start Searching Book with Google Book API")
        
        let url = SearchConstants.Network.GoogleBookAPIUrl + isbn
        
        URLSession.shared.dataTask(with: URL(string: url)!) {(data, response, error) in
            
            guard error == nil else{
                print("****ERROR: Error occured while searching book. Exception: " + (error?.localizedDescription)!)
                self.scanProviderDelegate.scanProvider(scanProvider: .google, didError: SearchBookError.connectionError)
                return
            }
            
            let responseJson = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
            
            print("Response JSON is: " + responseJson.debugDescription)
            
            var bookModel = BookModel()
            
            if let items = responseJson[GoogleAPIResponseKeys.items.rawValue] as? [[String:AnyObject]]{
            
                if let item = items.first{
                
                    if let volumeInfo = item [GoogleAPIResponseKeys.volumeInfo.rawValue] as? [String:AnyObject] {
                        
                        bookModel.name = (volumeInfo [GoogleAPIResponseKeys.title.rawValue] as? String)!
                        
                        if let authors = volumeInfo [GoogleAPIResponseKeys.authors.rawValue] as? [String] {
                            bookModel.authors = []
                            
                            for (_,name) in authors.enumerated() {
                                bookModel.authors?.append(name)
                            }
                        }
                        
                        if let description = volumeInfo [GoogleAPIResponseKeys.description.rawValue] as? String {
                            bookModel.description = description
                        }
                        
                        if let imageLinks = volumeInfo [GoogleAPIResponseKeys.imageLinks.rawValue] as? [String:String] {
                            bookModel.coverImage = imageLinks[GoogleAPIResponseKeys.thumbnail.rawValue]!
                        }
                        
                        if let pageCount = volumeInfo [GoogleAPIResponseKeys.pageCount.rawValue] as? Int{
                            bookModel.pageCount = String(pageCount)
                        }
                        
                        if let publishedDate = volumeInfo [GoogleAPIResponseKeys.publishedDate.rawValue] as? String{
                            bookModel.publishDate = publishedDate
                        }
                        
                        self.scanProviderDelegate.scanProvider(scanProvider: .google, didSucceed: bookModel)
                    }else{
                        print("****ERROR: Google Book API structure changed. ")
                        self.scanProviderDelegate.scanProvider(scanProvider: .google, didError: SearchBookError.unknownStructureError)
                    }
                }
            }else{
                print("****ERROR: No book information found on GOOGLE BOOK API.")
                self.scanProviderDelegate.scanProvider(scanProvider: .google, didError: SearchBookError.bookNotFoundError  )
            }
            
        }.resume()
     
    }
}
