//
//  ResponseModel.swift
//  MovieLike
//
//  Created by 이상민 on 1/31/25.
//

import Foundation

struct SearchResponse: Decodable {
    let page: Int
    let results: [SearchMovieResult]
    let total_pages: Int
}

struct SearchMovieResult: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let backdrop_path: String?
    let release_date: String
    let overview: String
    let vote_average: Double?
    let genre_ids: [Int]
}

struct SearchResultImage: Decodable {
    let id: Int
    
}

//MARK: - Image API
struct BackDropResponse: Decodable {
    let backdrops: [BackDropsImage]
}

struct BackDropsImage: Decodable{
    let file_path: String?
}

//MARK: - Cast API

struct CastResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let id: Int
    let name: String
    let original_name: String
    let profile_path: String?
}
