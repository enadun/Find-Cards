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

func getUniqueRandoms(numberOfRandoms: Int, startNumber: Int, maximumNumber: Int) -> [Int] {
    var uniqueNumbers = Set<Int>()
    while uniqueNumbers.count < numberOfRandoms {
        uniqueNumbers.insert(Int(arc4random_uniform(UInt32(maximumNumber + 1 - startNumber))) + startNumber)
    }
    return uniqueNumbers.shuffled()
}

func getRandomPairNumbersforCards() -> [Int] {
    let pair1 = getUniqueRandoms(numberOfRandoms: Config.NO_OF_PAIRS, startNumber: 1, maximumNumber: 100)
    let pair2 = pair1.shuffled()
    return (pair1 + pair2).shuffled()
}
