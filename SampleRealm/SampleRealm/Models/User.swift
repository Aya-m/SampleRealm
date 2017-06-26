//
//  User.swift
//  SampleRealm
//
//  Created by Aya-m on 2017/02/21.
//  Copyright © 2017年 Aya-m. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

// DBモデルにObjectとMappableを継承させる
class User : Object, Mappable  {
    
    // プロパティはdynamic varで宣言
    dynamic var number: String!
    dynamic var name: String!
    dynamic var nickname: String!
    dynamic var age = 0
    dynamic var isNew = false
    
    // initializer で mapping(map: Map) を呼び出す
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        number <- map["number"]
        name <- map["name"]
        // このような形でネスト化されたjsonオブジェクトもmappingできます
        nickname <- map["profile.nickname"]
        age <- map["profile.age"]
        isNew <- map["profile.new"]
    }
    
    // primaryKey設定
    override class func primaryKey() -> String {
        return "number"
    }
}
