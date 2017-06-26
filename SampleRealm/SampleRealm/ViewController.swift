//
//  ViewController.swift
//  SampleRealm
//
//  Created by Aya-m on 2017/02/21.
//  Copyright © 2017年 Aya-m. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        /* このパス先にdefault.realmが保存されています。ファイルはRealm Browserで開けます。
         ファイル名を好きにつけることも可能 */
        print("Realm File Path", path)
        
        requestUsers()
        requestOwners()
    }
    
    // users.jsonをRealmへ保存
    func requestUsers() {
        DataManager.requestUsers() { (error) in
            if let error = error {
                print("Error" ,error)
            } else {
                // 保存が成功した場合、Realmから全User取得
                fetchAllUsers()
            }
        }
    }
    
    // Realmから全User取得
    func fetchAllUsers() {
        DataManager.fetchAllUsers() { (result, error) in
            if let error = error {
                print("Error" ,error)
                return
            } else {
                guard let users = result else {
                    return
                }
                print("All users", users)
            }
        }
    }
    
    // owners.json読み込みをRealmへ保存
    func requestOwners() {
        DataManager.requestOwners() { (error) in
            if let error = error {
                print("Error" ,error)
            } else {
                // 保存が成功した場合、Realmから全Owner取得
                fetchAllOwners()
            }
        }
    }
    
    // Realmから全Owner取得
    func fetchAllOwners() {
        DataManager.fetchAllOwners() { (result, error) in
            if let error = error {
                print("Error" ,error)
                return
            } else {
                guard let owners = result else {
                    return
                }
                print("All owners" ,owners)
            }
        }
    }
}

