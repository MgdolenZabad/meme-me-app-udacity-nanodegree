//
//  DetailViewController.swift
//  PickingImage
//
//  Created by Mgdolen Zabad on 10/22/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = meme.memedImage
    }

}
