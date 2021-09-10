//
//  TitleCollectionViewCell.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/09/10.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                let shrink = CABasicAnimation(keyPath: "transform.scale")
                shrink.duration = 0.1
                shrink.fromValue = 1.0
                shrink.toValue = 0.95
                shrink.autoreverses = false
                shrink.repeatCount = 1
                shrink.isRemovedOnCompletion = false
                shrink.fillMode = CAMediaTimingFillMode.forwards
                self.layer.add(shrink, forKey: "shrink")
            } else {
                let shrink = CABasicAnimation(keyPath: "transform.scale")
                shrink.duration = 0.2
                shrink.fromValue = 1.0
                shrink.toValue = 0.95
                shrink.autoreverses = false
                shrink.repeatCount = 1
                shrink.isRemovedOnCompletion = false
                shrink.fillMode = CAMediaTimingFillMode.forwards
                self.layer.add(shrink, forKey: "shrink")
            }
        }
    }
}
