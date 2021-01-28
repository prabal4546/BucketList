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

struct Page:Codable {
    let page:Int
    let pageid:UUID
    let title:String
    let terms:[String:[String]]?
}
