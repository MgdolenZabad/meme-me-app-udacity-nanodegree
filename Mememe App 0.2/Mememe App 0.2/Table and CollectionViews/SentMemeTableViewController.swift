//
//  SentMemeTableViewController.swift
//  PickingImage
//
//  Created by Mgdolen Zabad on 10/2/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count 
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meme = self.memes[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        cell.textLabel?.text = "\(meme.topText) ... \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
        
        
    }
   
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
       
        
        
    }

    @IBAction func createMeme(_ sender: Any) {
        let MemeEditorViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as! MemeEditorViewController
        present(MemeEditorViewController, animated: true, completion: nil)
        }
    }
    


