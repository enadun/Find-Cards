//
//  CardViewCell.swift
//  Find Cards Game
//
//  Created by nadun.eranga.baduge on 11/3/20.
//  Copyright © 2020 nadun.eranga.baduge. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    static let cellId = "CardViewCell"
    private var frontView: UIView?
    private var backView: UIView?
    private var numberLabel: UILabel?
    
    //    private var hasMached = false
    //    private var isFront = true
    private var card: Card?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func update(with card: Card) {
        self.card = card
        backView?.isHidden = card.isFrontView
        frontView?.isHidden = !card.isFrontView
        numberLabel?.text = "\(card.number)"
        if card.hasPaired {
            backView?.backgroundColor = .green
        } else {
            backView?.backgroundColor = .red
        }
    }
    
    func flipCard(callbak: @escaping(_ card: Card?)->Void) {
        if let frontView = frontView, let backView = backView, let hasPaired = card?.hasPaired {
            if hasPaired { return }
            flipCard(fromView: frontView, toView: backView, with: callbak, option: .transitionFlipFromRight)
            card?.isFrontView = false
        }
    }
    
    func resetCard(with delay: Int = 1, callbak: @escaping(_ card: Card?)->Void) {
        if let frontView = frontView, let backView = backView, card?.isFrontView == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                [weak self] in
                self?.flipCard(fromView: backView, toView: frontView, with: callbak, option: .transitionFlipFromLeft)
                self?.card?.isFrontView = true
            }
        }
    }
    
    private func flipCard(fromView: UIView, toView: UIView, with callbak: @escaping(_ card: Card?)->Void, option: UIView.AnimationOptions) {
        
        UIView.transition(with: self, duration: 0.5, options: option, animations: {
            fromView.isHidden = true
            toView.isHidden = false
        }) { [weak self] _ in
            callbak(self?.card)
        }
    }
    
    private func setupViews() {
        //Front view
        frontView = UIView()
        if let frontView = frontView {
            frontView.backgroundColor = .blue
            frontView.clipsToBounds = true
            frontView.layer.cornerRadius = 10.0
            frontView.layer.borderColor = UIColor.white.cgColor
            frontView.layer.borderWidth = 2.0
            addSubview(frontView)
            fill(childView: frontView, in: self)
            let label = UILabel()
            label.textAlignment = .center
            label.text = "?"
            label.textColor = .white
            label.font = UIFont(name: "Helvetica", size: 50)
            frontView.addSubview(label)
            fill(childView: label, in: frontView)
        }
        //Back view
        backView = UIView()
        numberLabel = UILabel()
        if let backView = backView,
            let numberLabel = numberLabel {
            backView.backgroundColor = .red
            backView.clipsToBounds = true
            backView.layer.cornerRadius = 10.0
            addSubview(backView)
            fill(childView: backView, in: self)
            //Number Label
            numberLabel.textAlignment = .center
            numberLabel.textColor = .white
            numberLabel.font = UIFont(name: "Helvetica", size: 50)
            backView.addSubview(numberLabel)
            fill(childView: numberLabel, in: backView)
        }
    }
    
}
