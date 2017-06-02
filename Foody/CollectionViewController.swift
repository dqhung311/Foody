//
//  CollectionViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/29/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var btnLabel: UIButton!
    var collectionList  = [CollectionItem]()
    let collectionService = CollectionService()
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        
        collectionService.fetchAllCollection(query: ""){ [weak self] (collectionList, error) in
            self?.collectionList = collectionList
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
            }
        }
        
        
        
        
        if let password = UserDefaults.standard.value(forKey: "password") as? String{
            if (password == "ok"){
                print("Da dang nhap")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func disMist(_ sender: UIButton){
        /*DispatchQueue.main.async {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeStoryBoard")
        self.present(vc, animated: true, completion: nil)
        }*/
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionListCell", for: indexPath) as! CollectionListCell
        let dataCollection = collectionList[indexPath.row]
        cell.loadCell(data: dataCollection)
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
