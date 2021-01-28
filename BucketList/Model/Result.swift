//
//  Result.swift
//  BucketList
//
//  Created by PRABALJIT WALIA     on 28/01/21.
//

import Foundation
struct Result:Codable {
    let query:Query
}
struct Query: Codable {
    let pages:[Int:Page]
}

struct Page:Codable,Comparable {
    let pageid:UUID
    let title:String
    let terms:[String:[String]]?
    
    var description:String{
        terms?["description"]?.first ?? "no further info"
    }
    static func < (lhs:Page, rhs:Page)->Bool{
        lhs.title < rhs.title
    }
}
