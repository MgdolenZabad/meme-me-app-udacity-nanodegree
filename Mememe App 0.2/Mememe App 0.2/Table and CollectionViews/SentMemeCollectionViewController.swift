//
//  SentMemeCollectionViewController.swift
//  PickingImage
//
//  Created by Mgdolen Zabad on 10/2/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit



class SentMemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView?.reloadData()
        self.navigationItem.title = "Sent Memes"
        self.collectionView?.backgroundColor = UIColor.white
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let meme = self.memes[indexPath.row]
        
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        cell.backgroundView = UIImageView(image: meme.memedImage)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func createMeme(_ sender: Any) {
        let MemeEditorViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as! MemeEditorViewController
        present(MemeEditorViewController, animated: true, completion: nil)
    }
    
}
