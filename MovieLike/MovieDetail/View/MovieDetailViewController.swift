//
//  MovieDetailViewController.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController, UIScrollViewDelegate{
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .black
        view.alwaysBounceVertical = true
        view.isDirectionalLockEnabled = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private let backDropView = BackDropView()
    private let synopsisView = SynopsisView()
    private let castView = CastView()
    private let posterView = PosterView()
    
    let viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLikeMovieList), name: Notification.Name("likeButtonClicked"), object: nil)
        setUI()
        setLayout()
        setLogic()
        setBind()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUI(){
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let isLiked = UserManager.shared.movieLikeContain(
            movieID: viewModel.input.detailItem.value?.id ?? 0
        )
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: isLiked ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.backgroundColor = .black
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(backDropView)
        
        stackView.addSubview(synopsisView)
        stackView.addSubview(castView)
        stackView.addSubview(posterView)
    }
    
    private func setLayout(){
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(scrollView)
        }
        
        backDropView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.backDropView.backDropStackView)
        }
        
        synopsisView.snp.makeConstraints { make in
            make.top.equalTo(backDropView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.synopsisView.content.snp.bottom)
        }
        
        castView.snp.makeConstraints { make in
            make.top.equalTo(synopsisView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.castView.collectionView.snp.bottom)
        }
        
        posterView.snp.makeConstraints { make in
            make.top.equalTo(castView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setLogic(){
        synopsisView.MoreButton.addTarget(self, action: #selector(textWideButtonTapped), for: .touchUpInside)
        castView.configureDelegate(delegate: self, dataSource: self)
        posterView.configureDelegate(delegate: self, dataSource: self)
        
        //        if let result{
        //            callCastRequest(id: result.id)
        //            backDropView.configureBackDropInfo(data: result)
        //        }
    }
    
    private func setBind(){
        viewModel.output.selectedMovieTitle.bind { [weak self] text in
            self?.navigationItem.title = text
        }
        
        viewModel.output.syopsisText.bind { [weak self] text in
            self?.synopsisView.content.text = text
        }
        
        viewModel.output.backdropImages.lazyBind { [weak self] imageNames in
            self?.backDropView.insertImage(images: imageNames)
        }
        
        viewModel.output.moreAvaliable.lazyBind { [weak self] status in
            if status{
                self?.synopsisView.MoreButton.setTitle("More", for: .normal)
                self?.synopsisView.MoreButton.setTitle("More", for: .highlighted)
                self?.synopsisView.content.numberOfLines = 3
            }else{
                self?.synopsisView.content.numberOfLines = 0
                self?.synopsisView.MoreButton.setTitle("Hide", for: .normal)
                self?.synopsisView.MoreButton.setTitle("Hide", for: .highlighted)
            }
        }
        
        viewModel.output.castList.lazyBind { [weak self] cast in
            self?.castView.collectionView.reloadData()
        }
        
        viewModel.output.posterList.lazyBind { [weak self] poster in
            self?.posterView.collectionView.reloadData()
        }
    }
    
    @objc
    private func updateLikeMovieList(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let movieID = userInfo["movieID"] as? Int else { return }
        
        // 현재 보고 있는 영화가 변경된 영화라면 UI 업데이트
        if self.viewModel.input.detailItem.value?.id == movieID {
            let isLiked = UserManager.shared.movieLikeContain(movieID: movieID)
            
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: isLiked ? "heart.fill" : "heart")
        }
    }
    
    @objc
    private func rightBarButtonTapped(){
        
        guard let movieID = viewModel.input.detailItem.value?.id else { return }
        
        if UserManager.shared.movieLikeContain(movieID: movieID) {
            UserManager.shared.removeLikedMovie(movieID: movieID)
        } else {
            UserManager.shared.saveLikeMovie(movieID: movieID)
        }
        
        let isLiked = UserManager.shared.movieLikeContain(movieID: movieID)
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: isLiked ? "heart.fill" : "heart")
        
        NotificationCenter.default.post(name: Notification.Name("likeButtonClicked"), object: nil, userInfo: ["movieID": movieID])
    }
    
    //    private func callRequest(id: Int){
    //        APIManager.shard.callRequest(api: TheMovieDBRequest.image(id: id)) { (response: BackDropResponse) in
    //            if response.backdrops.isEmpty{ return }
    //            self.backdropImages = response.backdrops.prefix(5).map{ "https://image.tmdb.org/t/p/w400/\($0.file_path!)" }
    //            self.posterImages = response.posters.map{"https://image.tmdb.org/t/p/w400/\($0.file_path!)"}
    //            self.posterView.reloadData()
    //            self.backDropView.insertImage(images: self.backdropImages)
    //        } failHandler: { error in
    //            print(error.localizedDescription)
    //        }
    //    }
    
    //MARK: - Actions
    @objc
    private func textWideButtonTapped(_ sender: UIButton){
        viewModel.output.moreAvaliable.value.toggle()
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return self.viewModel.output.castList.value.count
        }else{
            return self.viewModel.output.posterList.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastActorCollectionViewCell.identifier, for: indexPath) as? CastActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            let data = self.viewModel.output.castList.value[indexPath.item]
            cell.configureData(data: data)
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
                return UICollectionViewCell()
            }
            let data = self.viewModel.output.posterList.value[indexPath.item]
            cell.configureInsertImage(imageName: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            let padding = 10.0
            let spacing = 12.0
            let width = (collectionView.bounds.width - (spacing * 2) - (padding * 2)) / 2
            let height = (collectionView.bounds.height - spacing) / 2
            return CGSize(width: width, height: height)
        }else{
            let padding = 10.0
            let spacing = 12.0
            let width = (UIScreen.main.bounds.width - (spacing * 3) - (padding * 2)) / 4
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }
    }
}
