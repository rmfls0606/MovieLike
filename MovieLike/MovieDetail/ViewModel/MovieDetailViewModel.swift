//
//  MovieDetailViewModel.swift
//  MovieLike
//
//  Created by 이상민 on 2/12/25.
//

import Foundation

class MovieDetailViewModel: BaseViewModel{
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input{
        let detailItem: Observable<SearchMovieResult?> = Observable(nil)
    }
    
    struct Output{
        let selectedMovieTitle: Observable<String?> = Observable(nil)
    }
    
    init () {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        self.input.detailItem.lazyBind { [weak self] data in
            guard let data = data else {
                self?.output.selectedMovieTitle.value = "-"
                return }
            self?.output.selectedMovieTitle.value = data.title
        }
    }
}
