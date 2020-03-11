//
//  ViewController.swift
//  Find Cards Game
//
//  Created by nadun.eranga.baduge on 11/3/20.
//  Copyright © 2020 nadun.eranga.baduge. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var contentView: HomeContentView?
    private let spacing:CGFloat = 8.0
    
    private var cards: [Card] = []
    private var flipCardsIndexPath: [IndexPath] = []
    
    private var completeCount = 0
    private var stepsCount = 0 {
        didSet {
            setStepLabel()
        }
    }
    
    private var counterLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Strings.APP_NAME
        self.view.backgroundColor = .white
        //Setup the veiws
        setupView()
        //Collection view setup
        contentView?.collectionView?.dataSource = self
        contentView?.collectionView?.delegate = self
        contentView?.collectionView?.register(CardViewCell.self, forCellWithReuseIdentifier: CardViewCell.cellId)
        
        reset()
    }
    
    private func setupView() {
        contentView = HomeContentView()
        if let contentView = contentView {
            view.addSubview(contentView)
            fill(childView: contentView, in: view)
        }
        //Left bar button
        let restartBtn = UIBarButtonItem(title: Strings.RE_START, style: .done, target: self, action: #selector(restartPressed))
        navigationItem.leftBarButtonItem = restartBtn
        //Right bar item
        counterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        if let counterLabel = counterLabel {
            counterLabel.textAlignment = .left
            counterLabel.textColor = .label
            counterLabel.font = UIFont(name: "Helvetica", size: 18)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: counterLabel)
            setStepLabel()
        }
    }
    
    @objc
    private func restartPressed() {
        if contentView?.collectionView?.isUserInteractionEnabled == true {
            reset()
        }
    }
    
    private func reset() {
        let pair1 = getUniqueRandoms(numberOfRandoms: Config.NO_OF_PAIRS)
        let pair2 = getUniqueRandoms(numberOfRandoms: Config.NO_OF_PAIRS)
        let pairs = pair1 + pair2
        cards = pairs.map { Card(number: $0) }
        flipCardsIndexPath = []
        
        if completeCount == 0 && stepsCount == 0 { return } //Avoid th reset animation in first load
        
        for indexPath in contentView?.collectionView?.indexPathsForVisibleItems ?? [] {
            if let cell = contentView?.collectionView?.cellForItem(at: indexPath) as? CardViewCell {
                cell.resetCard(with: 0){ [weak self]_ in //Pass the delay as 0 for resetting all visible cells.
                    self?.contentView?.collectionView?.reloadData()
                }
            }
        }
        completeCount = 0
        stepsCount = 0
    }
    
    private func hasMached() {
        //If fliped cads count is less than 2, do nothing.
        if flipCardsIndexPath.count < 2 {
            contentView?.collectionView?.isUserInteractionEnabled = true
            return
        }
        
        //Cheking wheather the flipped cards are matching
        let isCardsMatching = cards[flipCardsIndexPath[0].row].number ==
            cards[flipCardsIndexPath[1].row].number
        
        for indexPath in flipCardsIndexPath {
            var card = cards[indexPath.row]
            let cell = contentView?.collectionView?.cellForItem(at: indexPath) as? CardViewCell
            if isCardsMatching {
                card.hasPaired = true
                cell?.update(with: card)
                contentView?.collectionView?.isUserInteractionEnabled = true
            } else {
                card.isFrontView = true
                cell?.resetCard(callbak: { [weak self] _ in
                    self?.contentView?.collectionView?.isUserInteractionEnabled = true
                })
            }
            cards[indexPath.row] = card
            
        }
        flipCardsIndexPath = []
        if isCardsMatching { completeCount += 1 }
        if completeCount == Config.NO_OF_PAIRS { showCompletionDialog() }
    }
    
    private func setStepLabel() {
        if let stepLabel = counterLabel {
            let message = String.init(format: Strings.STEPS_COUNT, "\(stepsCount)")
            stepLabel.text = message
        }
    }
    
    private func showCompletionDialog() {
        let message = String.init(format: Strings.ALERT_MESSAGE, "\(stepsCount)")
        let alert = UIAlertController(title: Strings.ALERT_TITLE,
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Strings.TRY_AGAIN_BTN, style: .default) { [weak self] _ in
            self?.reset()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    //Data source methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Config.NO_OF_PAIRS * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.cellId, for: indexPath)
        if let cell = cell as? CardViewCell {
            cell.update(with: cards[indexPath.row])
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    //Delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardViewCell {
            collectionView.isUserInteractionEnabled = false
            cell.flipCard { [weak self] card in
                guard let card = card else {
                    collectionView.isUserInteractionEnabled = true
                    return
                }
                self?.stepsCount += 1
                self?.cards[indexPath.row] = card
                self?.flipCardsIndexPath.append(indexPath)
                self?.hasMached()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    //Flow layout delegate methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 3.0
        let spacingBetweenCells:CGFloat = 8.0
        
        //Amount of total spacing in a row
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8.0
    }
}

