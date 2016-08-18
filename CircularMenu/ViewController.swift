//
//  ViewController.swift
//  CircularMenu
//
//  Created by Admin on 8/17/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let images = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CircularCollectionViewCell
        cell.imageName = images[indexPath.row]
        return cell
    }


}

