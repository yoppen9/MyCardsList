//
//  CollectionViewCell.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/09/07.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CardsImageCell: UIImageView!
    @IBOutlet weak var CardsName: UILabel!
    @IBOutlet weak var CardsTelephoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CardsImageCell.layer.cornerRadius = 12
    }

}
