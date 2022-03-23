//
//  CardsCollectionViewCell.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/03.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardsImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(with cards: Cards) {
        cardsImageView.image = cards.image
        nameLabel.text = cards.name
    }
    
}
