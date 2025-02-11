//
//  BaseViewModel.swift
//  MovieLike
//
//  Created by 이상민 on 2/12/25.
//

import Foundation

protocol BaseViewModel{
    associatedtype Input
    associatedtype Output
    
    func transform()
}
