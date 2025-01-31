//
//  MovieDetailViewController.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    private var currentPage: Int = 0{
        didSet{
            backDropView.pageControl.currentPage = currentPage
        }
    }
    private let backDropView = BackDropView()
    private let synopsisView = SynopsisView()
    
    var navigationTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        configure()
    }
    
    private func configure(){
        self.view.backgroundColor = .black
        view.addSubview(backDropView)
        view.addSubview(synopsisView)
        
        backDropView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.backDropView.backDropStackView)
        }
        backDropView.configureDelegate(delegate: self)
        
        synopsisView.snp.makeConstraints { make in
            make.top.equalTo(backDropView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(self.synopsisView.content.snp.bottom)
        }
    }
}

extension MovieDetailViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width + 0.5)
        currentPage = page
    }
    
}
