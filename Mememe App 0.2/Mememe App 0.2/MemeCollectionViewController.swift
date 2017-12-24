//
//  MemeCollectionViewController.swift
//  PickingImage
//
//  Created by Mgdolen Zabad on 9/25/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {
    
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
       
    }

   
   

}
