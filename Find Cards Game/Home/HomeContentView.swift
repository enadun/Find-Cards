//
//  HomeContentView.swift
//  Find Cards Game
//
//  Created by nadun.eranga.baduge on 11/3/20.
//  Copyright © 2020 nadun.eranga.baduge. All rights reserved.
//

import UIKit

class HomeContentView: UIView {
    
    var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        //Home Content View
        backgroundColor = .white
        //Backgroun view
        let bgView = UIView()
        bgView.backgroundColor = .black
        bgView.alpha = 0.7
        addSubview(bgView)
        fill(childView: bgView, in: self)
        
        //Collection View
        collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.backgroundColor = .none
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        let margin: CGFloat = 8.0
        layout?.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout?.invalidateLayout()
        if let collectionView = collectionView {
            addSubview(collectionView)
            fillToSafeArea(childView: collectionView, in: self)
        }
        
    }
}
