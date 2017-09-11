////
////  YelpCard.swift
////  MunchiOS
////
////  Created by Eli Simmonds on 9/5/17.
////  Copyright © 2017 Eli Simmonds. All rights reserved.
////
//
//import Foundation
//import UIKit
//import YelpAPI
//
//
//class YelpCard: NSObject {
//    let name: String?
//    let address: String?
//    let imageURL: URL?
//    let categories: String?
//    let distance: String?
//    let ratingImageURL: URL?
//    let reviewCount: NSNumber?
//    
//    init(dictionary: YLPBusiness) {
//        name = dictionary.name
//        
//        let imageURL = dictionary.imageURL
////        if imageURLString != nil {
////            imageURL = URL(string: imageURLString!)!
////        } else {
////            imageURL = nil
////        }
//        
//        let location = dictionary.location
//        var address = ""
//        let addressArray = location.address
//        if addressArray.count > 0 {
//            address = addressArray[0]
//        }
//        self.address = address
//        
//        let categoriesArray = dictionary.categories
//            var categoryNames = [String]()
//            for category in categoriesArray {
//                let categoryName = category[0]
//                categoryNames.append(categoryName)
//            }
//            categories = categoryNames.joined(separator: ", ")
//        
//        let distanceMeters = dictionary["distance"] as? NSNumber
//        if distanceMeters != nil {
//            let milesPerMeter = 0.000621371
//            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
//        } else {
//            distance = nil
//        }
//        
//        let ratingImageURLString = dictionary.
//        if ratingImageURLString != nil {
//            ratingImageURL = URL(string: ratingImageURLString!)
//        } else {
//            ratingImageURL = nil
//        }
//        
//        reviewCount = dictionary.reviewCount as NSNumber
//    }
//    
//    class func businesses(array: [NSDictionary]) -> [YelpCard] {
//        var businesses = [YelpCard]()
//        for dictionary in array {
////            let business = YelpCard(dictionary: dictionary)
//            businesses.append(business)
//        }
//        return businesses
//    }
//    
////    class func searchWithTerm(term: String, completion: @escaping ([YelpCard]?, Error?) -> Void) {
////        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
////    }
////    
////    class func searchWithTermAndLocation(term: String, location: String, completion: @escaping ([YelpCard]?, Error?) -> Void) {
////        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
////    }
////    
////    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([YelpCard]?, Error?) -> Void) -> Void {
////        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, completion: completion)
////    }
//}
