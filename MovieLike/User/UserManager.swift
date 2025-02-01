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
    private let userRecentSearchNameKey = "userRecentSearchName"
    private let userlikedMovieKey = "userLikedMovie"
    
    private var likeMovieList: Set<Int> {
        get{
            let savedMovies = defaults.array(forKey: userlikedMovieKey) as? [Int] ?? []
            return Set(savedMovies)
        }
        
        set {
            defaults.set(Array(newValue), forKey: userlikedMovieKey)
        }
    }
    
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
    
    func saveRecentSearchName(text: String){
        if var searchData = defaults.stringArray(forKey: userRecentSearchNameKey){
            if searchData.contains(text){
                searchData.remove(at: searchData.firstIndex(of: text)!)
            }
            searchData.insert(text, at: 0)
            defaults.set(searchData, forKey: userRecentSearchNameKey)
        }else{
            defaults.set([text], forKey: userRecentSearchNameKey)
        }
    }
    
    func getRecentSearchName() -> [String]{
        guard let searchData = defaults.stringArray(forKey: userRecentSearchNameKey) else { return [] }
        return searchData
    }
    
    func removeAllRecentSearchName(){
        defaults.removeObject(forKey: userRecentSearchNameKey)
    }
    
    func removeRecentSearchName(text: String){
        var searchData = getRecentSearchName()
        if let index = searchData.firstIndex(of: text){
            searchData.remove(at: index)
        }
        defaults.set(searchData, forKey: userRecentSearchNameKey)
    }
    
    func saveLikeMovie(movieID: Int){
        var likeMovieList = likeMovieList
        likeMovieList.insert(movieID)
        self.likeMovieList = likeMovieList
        
    }
    
    func removeLikedMovie(movieID: Int){
        var likeMovieList = likeMovieList
        likeMovieList.remove(movieID)
        self.likeMovieList = likeMovieList
    }
    
    func getLikedMovie() -> [Int]{
        return Array(likeMovieList)
    }
    
    func movieLikeContain(movieID: Int) -> Bool{
        return likeMovieList.contains(movieID)
    }
}
