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
    
    func formatString(_ dateString: String?) -> String{
        guard let dateString = dateString, !dateString.isEmpty else {
            return "-"
        }
        
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: dateString)!
        
        dateFormatter.dateFormat = "yyyy. mm. dd"
        return dateFormatter.string(from: date)
    }
}
