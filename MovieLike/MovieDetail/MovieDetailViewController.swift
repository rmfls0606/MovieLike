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
        
        backDropView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.backDropView.backDropStackView).offset(12)
        }
        
        backDropView.configureDelegate(delegate: self)
    }
}

extension MovieDetailViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width + 0.5)
        currentPage = page
    }
    
}
