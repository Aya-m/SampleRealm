//
//  ArrayTransform.swift
//  SampleRealm
//
//  Created by Aya-m on 2017/02/21.
//  Copyright © 2017年 Aya-m. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>
    
    // JsonからRealmのList<T: Object>型に変換
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let realmList = List<T>()
        if let jsonArray = value as? Array<Any> {
            for item in jsonArray {
                if let realmModel = Mapper<T>().map(JSONObject: item) {
                    realmList.append(realmModel)
                }
            }
        } else {
            if let realmModel = Mapper<T>().map(JSONObject: value) {
                realmList.append(realmModel)
            }
        }
        
        return realmList
    }
    
     // List<T: Object>型からJsonに変換(今回未使用)
    func transformToJSON(_ value: List<T>?) -> Array<AnyObject>? {
        guard let realmList = value, realmList.count > 0 else { return nil }
        var resultArray = Array<T>()
        for entry in realmList {
            resultArray.append(entry)
        }
        return resultArray
    }
}
