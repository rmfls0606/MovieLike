//
//  UserManager.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import Foundation

struct User{
    let imageName: String
    let nickname: String
    let joinDate: String
}

class UserManager{
    static let shared = UserManager()
    
    private let defaults = UserDefaults.standard
    private init() { }
    
    private let userImageKey = "userImage"
    private let userNicknameKey = "userNickname"
    private let userJoinDateKey = "userJoinDate"
    
    func saveUserInfo(user: User){
        defaults.set(user.imageName, forKey: userImageKey)
        defaults.set(user.nickname, forKey: userNicknameKey)
        defaults.set(user.joinDate, forKey: userJoinDateKey)
    }
}
