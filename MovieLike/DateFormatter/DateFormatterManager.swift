//
//  DateFormatterManager.swift
//  MovieLike
//
//  Created by 이상민 on 1/30/25.
//

import Foundation

class DateFormatterManager{
    static let shared = DateFormatterManager()
    
    private let dateFormatter = DateFormatter()
    
    private init(){ }
    
    func formatDate(_ date: Date) -> String{
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    func formatString(_ dateString: String) -> String{
        if dateString.isEmpty{
            return "-"
        }else{
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)!
            
            dateFormatter.dateFormat = "yyyy. MM. dd"
            return dateFormatter.string(from: date)
        }
    }
}
