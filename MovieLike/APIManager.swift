//
//  APIManager.swift
//  MovieLike
//
//  Created by 이상민 on 1/31/25.
//

import Alamofire
import Foundation

enum TheMovieDBRequest{
    case trending
    case search(query: String)
    case image(id: Int)
    case credit(id: Int)
    
    var baseURL: String{
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL{
        switch self{
        case .trending:
            return URL(string: baseURL + "trending/movie/day?language=ko-KR&page=1")!
        case .search(let query):
            return URL(string: baseURL + "search/movie?query=\(query)&include_adult=false&language=ko-KR")!
        case .image(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        case .credit(let id):
            return URL(string: baseURL + "movie/\(id)/credits?language=ko-KR")!
        }
    }
    
    var header: HTTPHeaders{
        
        return ["Authorization": "Bearer \(Bundle.main.infoDictionary?["ApiKey"] as! String)"]
    }
    
    var method: HTTPMethod{
        return .get
    }
}

class APIManager{
    //타입 프로퍼티
    static let shard = APIManager()
    
    private init() {}
    
    func callRequest<T: Decodable>(api: TheMovieDBRequest, parameters: [String: Any]? = nil, succesHandler: @escaping (T) -> Void, failHandler: @escaping (Error) -> Void){
        AF.request(api.endpoint, method: api.method, parameters: parameters, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self){ response in
//                print(response)
                switch response.result{
                case .success(let value):
                    succesHandler(value)
                case .failure(let error):
                    failHandler(error)
                }
                
            }
    }
}
