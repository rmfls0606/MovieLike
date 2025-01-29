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
    
    private func formatDate(_ date: Date) -> String{
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
