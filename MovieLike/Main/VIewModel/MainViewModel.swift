//
//  MainViewModel.swift
//  MovieLike
//
//  Created by 이상민 on 2/12/25.
//

import Foundation

class MainViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input{
        
    }
    
    struct Output{
        let recentSearchData: Observable<[String]> = Observable([])
        let trendingMovieData: Observable<[SearchMovieResult]> = Observable([])
    }
    
    init () {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        callTrendingImageRequset()
    }
    
    private func callTrendingImageRequset(){
        APIManager.shard.callRequest(api: TheMovieDBRequest.trending) { (response: SearchResponse) in
            self.output.trendingMovieData.value = response.results
        } failHandler: { error in
            print(error.localizedDescription)
        }
    }
}
