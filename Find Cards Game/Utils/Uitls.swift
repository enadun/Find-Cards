//
//  Uitls.swift
//  Find Cards Game
//
//  Created by nadun.eranga.baduge on 11/3/20.
//  Copyright © 2020 nadun.eranga.baduge. All rights reserved.
//

import UIKit

func fill(childView: UIView, in parentView: UIView) {
    childView.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
        childView.topAnchor.constraint(equalTo: parentView.topAnchor),
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
}

func fillToSafeArea(childView: UIView, in parentView: UIView) {
    childView.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
        childView.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
        childView.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
        childView.topAnchor.constraint(equalTo: parentView.topAnchor),
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
}

// Range startNumber ..< maximumNumber
func getRandomNumber(startNumber: Int, maximumNumber: Int) -> Int {
    return Int(arc4random_uniform(UInt32(maximumNumber - startNumber))) + startNumber
}

func getUniqueRandoms(numberOfRandoms: Int, startNumber: Int, maximumNumber: Int) -> [Int] {
    let numberCont = numberOfRandoms < maximumNumber ? numberOfRandoms : maximumNumber
    var uniqueNumbers = Set<Int>()
    while uniqueNumbers.count < numberCont {
        let randomNo = getRandomNumber(startNumber: startNumber, maximumNumber: maximumNumber)
        uniqueNumbers.insert(randomNo)
    }
    return uniqueNumbers.shuffled()
}

func getRandomPairNumbersforCards() -> [Int] {
    let pair1 = getUniqueRandoms(numberOfRandoms: Config.NO_OF_PAIRS, startNumber: 1, maximumNumber: 100)
    let pair2 = pair1.shuffled()
    return (pair1 + pair2).shuffled()
}
