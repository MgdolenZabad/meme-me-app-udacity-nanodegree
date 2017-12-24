//
//  MemeTableViewController.swift
//  PickingImage
//
//  Created by Mgdolen Zabad on 9/25/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    
var memes = [Meme]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
