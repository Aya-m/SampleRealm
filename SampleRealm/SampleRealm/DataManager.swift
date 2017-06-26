//
//  DataManager.swift
//  SampleRealm
//
//  Created by Aya-m on 2017/02/21.
//  Copyright © 2017年 Aya-m. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

// ObjectMapperを介し、JsonデータをRealmへ保存
struct RealmManager<T :Mappable> where T :Object {
    static func saveContents(contents :Any) throws {
        let objects = Mapper<T>().mapArray(JSONObject: contents)
        guard let _objects = objects else { return }
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(_objects, update: true)
        try realm.commitWrite()
    }
}

class DataManager {
    
    // ローカルのusers.jsonファイルを読み込み
    static func requestUsers(completion: (NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "users", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)!
        var error: NSError?
        do {
            // jsonパース
            let json = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! NSDictionary
            if let contents = json["users"] as? NSArray {
                // ObjectMapperを介し、JsonデータをRealmへ保存
                try RealmManager<User>.saveContents(contents: contents)
            }
        } catch let exceptionError as NSError {
            error = exceptionError
            completion(error)
            return
        }
        completion(error)
    }
    
    // ローカルのowners.jsonファイルを読み込み
    static func requestOwners(completion: (NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "owners", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)!
        var error: NSError?
        do {
            // jsonパース
            let json = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! NSDictionary
            if let contents = json["owners"] as? NSArray {
                // ObjectMapperを介し、JsonデータをRealmへ保存
                try RealmManager<Owner>.saveContents(contents: contents)
            }
        } catch let exceptionError as NSError {
            error = exceptionError
            completion(error)
            return
        }
        completion(error)
    }
    
    // Realmから全User取得
    static func fetchAllUsers(completion: (Any?, NSError?) -> Void) {
        var error: NSError?
        var users: Any?
        do {
            // Realmファイル取得
            let realm = try Realm()
            // 全User取得
            users = realm.objects(User.self)
        } catch let exceptionError as NSError {
            error = exceptionError
        }
        completion(users, error)
    }
    
    
    // Realmから全Owner取得
    static func fetchAllOwners(completion: (Any?, NSError?) -> Void) {
        var error: NSError?
        var owners: Any?
        do {
            // Realmファイル取得
            let realm = try Realm()
            // 全Owner取得
            owners = realm.objects(Owner.self)
        } catch let exceptionError as NSError {
            error = exceptionError
        }
        completion(owners, error)
    }
}
