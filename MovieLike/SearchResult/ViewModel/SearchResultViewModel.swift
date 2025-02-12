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
    private var isEnd = false
    
    struct Input{
        let query: Observable<String?> = Observable(nil)
        let page: Observable<Int> = Observable(1)
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
        self.input.query.lazyBind { [weak self] text in
            self?.resetPage()
        }
        
        self.input.page.lazyBind { [weak self] page in
            self?.callRequest()
        }
    }
    
    private func callRequest() {
        if !self.isEnd{
            guard let query = input.query.value else { return }
            APIManager.shard
                .callRequest(api: .search(query: query), parameters: ["page": self.input.page.value]) { [weak self] (
                    response: SearchResponse
                ) in
                if self?.input.page.value == 1{
                    self?.output.searchResults.value = response.results
                }else{
                    self?.output.searchResults.value.append(contentsOf: response.results)
                }
                
                self?.isEnd = self?.input.page.value ?? 0 >= response.total_pages
                UserManager.shared.saveRecentSearchName(text: query)
                
                
            } failHandler: { error in
                print(error.localizedDescription)
            }
        }
    }
    
    private func resetPage(){
        self.input.page.value = 1
        self.isEnd = false
        self.first = false
    }
}
