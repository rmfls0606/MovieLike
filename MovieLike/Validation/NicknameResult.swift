//
//  NicknameResult.swift
//  MovieLike
//
//  Created by 이상민 on 1/28/25.
//

import Foundation

enum NicknameResult {
    case success
    case empty
    case rangeError
    case incorrectCharacterError
    case numberError
    
    // TODO: 앞 뒤 공백 처리하기
    func nickNameIsValid(nickname: String) -> NicknameResult{
        if nickname.isEmpty{
            return .empty
        }else if nickname.count < 2 || nickname.count >= 10{
            return .rangeError
        }else if nickname.contains(where: {"@#$%".contains($0)}){
            return .incorrectCharacterError
        }else if nickname.contains(where: {"0123456789".contains($0)}){
            return .numberError
        }else{
            return .success
        }
    }
    
    var resultDescription: String {
        switch self {
        case .success:
            return "사용할 수 있는 닉네임이에요"
        case .empty:
            return "닉네임을 입력해주세요."
        case .rangeError:
            return "2글자 이상 10글자 미만으로 설정해 주세요"
        case .incorrectCharacterError:
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        case .numberError:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}
