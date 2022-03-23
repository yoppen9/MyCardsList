//
//  CardsListViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/02.
//

import UIKit

class CardsListViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    
    }
    
}


