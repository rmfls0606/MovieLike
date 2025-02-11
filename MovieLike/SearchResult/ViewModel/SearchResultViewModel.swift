//
//  SearchResultViewModel.swift
//  MovieLike
//
//  Created by 이상민 on 2/12/25.
//

import Foundation

class SearchResultViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    private(set) var first: Bool = true
    
    struct Input{
        let query: Observable<String?> = Observable(nil)
    }
    
    struct Output{
        let searchResults: Observable<[SearchMovieResult]> = Observable([])
    }
    
    init () {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        self.input.query.lazyBind { text in
            self.first = false
            self.callRequest()
        }
    }
    
    private func callRequest() {
        guard let query = input.query.value else { return }
        APIManager.shard.callRequest(api: .search(query: query)) { [weak self] (response: SearchResponse) in
            self?.output.searchResults.value = response.results
            UserManager.shared.saveRecentSearchName(text: query)
        } failHandler: { error in
            print(error.localizedDescription)
        }
    }
}
