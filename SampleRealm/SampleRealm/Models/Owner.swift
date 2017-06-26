//
//  Owner.swift
//  SampleRealm
//
//  Created by Aya-m on 2017/02/21.
//  Copyright © 2017年 Aya-m. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

// DBモデルにObjectとMappableを継承させる
class Owner : Object, Mappable  {
    
    // プロパティはdynamic varで宣言
    dynamic var id: String!
    dynamic var name: String!
    
    // List<T: Object>型はletで宣言
    var pets = List<Pet> ()
    
    // initializer で mapping(map: Map) を呼び出す
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        
        // NSArrayをRLMObjectのプロパティとしてサポートしてないため、List<T: Object>型に変換する必要がある
        pets <- (map["pet"], ArrayTransform<Pet>())
    }
    
    // primary key設定
    override class func primaryKey() -> String {
        return "id"
    }
}
