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
    
    func removeUserInfo(){
        defaults.removeObject(forKey: userImageKey)
        defaults.removeObject(forKey: userNicknameKey)
        defaults.removeObject(forKey: userJoinDateKey)
    }
    
    func saveOnBoarding(){
        defaults.set(true, forKey: "isOnboarding")
    }
    
    func removeOnBoarding(){
        defaults.set(false, forKey: "isOnboarding")
    }
    
    func getUserInfo() -> User{
        let imageName = defaults.string(forKey: userImageKey) ?? "-"
        let nickName = defaults.string(forKey: userNicknameKey) ?? "-"
        let userJoinDate = defaults.string(forKey: userJoinDateKey) ?? "-"
        
        return User(imageName: imageName, nickname: nickName, joinDate: userJoinDate)
    }
    
    func getJoinDate() -> String{
        return defaults.string(forKey: userJoinDateKey)!
    }
}
