//
//  Pet.swift
//  SampleRealm
//
//  Created by Aya-m on 2017/02/21.
//  Copyright © 2017年 Aya-m. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

// DBモデルにObjectとMappableを継承させる
class Pet : Object, Mappable  {
    
    // プロパティはdynamic varで宣言
    dynamic var type: String!
    dynamic var name: String!
    dynamic var age = 0
    
    // initializer で mapping(map: Map) を呼び出す
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        name <- map["name"]
        age <- map["age"]
    }
}

