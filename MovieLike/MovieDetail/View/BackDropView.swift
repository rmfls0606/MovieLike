//
//  BackDropView.swift
//  MovieLike
//
//  Created by 이상민 on 2/1/25.
//

import UIKit
import SnapKit

final class BackDropView: BaseView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .clear
        pageControl.pageIndicatorTintColor = UIColor(named: "lightGrayColor")
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageControlPageTapped), for: .valueChanged)
        pageControl.allowsContinuousInteraction = false
        return pageControl
    }()
    
    private lazy var openDay: UILabel = {
        let label = UILabel()
        label.text = "2024-12-24"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private lazy var likePoint: UILabel = {
        let label = UILabel()
        label.text = "8.0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private lazy var genre: UILabel = {
        let label = UILabel()
        label.text = "액션, 스릴러, 역사, 전쟁"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "lightGrayColor")
        return label
    }()
    
    private(set) lazy var backDropStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [openDay, lineView(), likePoint, lineView(), genre])
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        self.addSubview(backDropStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.bottom).offset(-12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        backDropStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
  
    
    override func configureView() {
    }
    
    @objc private func pageControlPageTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let offsetX = CGFloat(page) * UIScreen.main.bounds.width
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    func configureDelegate(delegate: UIScrollViewDelegate){
        self.scrollView.delegate = delegate
    }
    
    private func lineView() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor(named: "lightGrayColor")
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        return view
    }
}
