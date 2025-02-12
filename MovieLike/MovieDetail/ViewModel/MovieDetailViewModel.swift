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
        let backdropImages: Observable<[String]> = Observable([])
        let syopsisText: Observable<String> = Observable("-")
        let moreAvaliable: Observable<Bool> = Observable(true)
        let castList: Observable<[Cast]> = Observable([])
        let posterList: Observable<[String]> = Observable([])
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
            self?.output.syopsisText.value = data.overview
            self?.callImageRequest()
            self?.callCastRequest()
        }
    }
    
    private func callImageRequest(){
        guard let detailItem = input.detailItem.value else { return }
        APIManager.shard.callRequest(api: TheMovieDBRequest.image(id: detailItem.id)) { [weak self] (response: BackDropResponse) in
            if response.backdrops.isEmpty{ return }
            self?.output.backdropImages.value = response.backdrops.prefix(5).map{ "https://image.tmdb.org/t/p/w400/\($0.file_path!)" }
            self?.output.posterList.value = response.posters.map{"https://image.tmdb.org/t/p/w400/\($0.file_path!)"}
        } failHandler: { error in
            print(error.localizedDescription)
        }
    }
    
    private func callCastRequest(){
        guard let detailItem = input.detailItem.value else { return }
        APIManager.shard.callRequest(api: TheMovieDBRequest.credit(id: detailItem.id)) { [weak self] (response: CastResponse) in
            self?.output.castList.value = response.cast
        } failHandler: { error in
            print(error.localizedDescription)
        }
    }
}
