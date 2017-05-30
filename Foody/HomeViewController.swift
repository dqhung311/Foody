//
//  ViewControllerHome.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/23/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var homeTextSearch: UITextField!
    
    @IBOutlet weak var khamPhaImage: UIImageView!
    @IBOutlet weak var danhMucImage: UIImageView!
    @IBOutlet weak var boSuuTapImage: UIImageView!
    @IBOutlet weak var tinhThanhImage: UIImageView!
    
    @IBOutlet weak var khamPhaIcon: UIImageView!
    @IBOutlet weak var danhMucIcon: UIImageView!
    @IBOutlet weak var boSuuTapIcon: UIImageView!
    @IBOutlet weak var tinhThanhIcon: UIImageView!
    
    @IBOutlet weak var khamPhaView: UIView!
    @IBOutlet weak var tinhThanhView: UIView!
    @IBOutlet weak var danhMucView: UIView!
    
    var selectView: String = ""
    
    let tabProduct = Config().getTabProduct()
    let tabCategory = Config().getTabCategory()
    let tabProvince = Config().getTabProvince()
    
    //@IBOutlet weak var homeLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "home-body")!)
       
        self.homeLogo.layer.cornerRadius = self.homeLogo.frame.width/2.0
        self.homeLogo.clipsToBounds = true
        
        self.khamPhaIcon.layer.cornerRadius = self.khamPhaIcon.frame.width/2.0
        self.khamPhaIcon.layer.borderWidth = 1
        self.khamPhaIcon.layer.borderColor = UIColor.white.cgColor
        self.khamPhaIcon.clipsToBounds = true
        
        self.danhMucIcon.layer.cornerRadius = self.danhMucIcon.frame.width/2.0
        self.danhMucIcon.layer.borderWidth = 1
        self.danhMucIcon.layer.borderColor = UIColor.white.cgColor
        self.danhMucIcon.clipsToBounds = true
        
        self.boSuuTapIcon.layer.cornerRadius = self.boSuuTapIcon.frame.width/2.0
        self.boSuuTapIcon.layer.borderWidth = 1
        self.boSuuTapIcon.layer.borderColor = UIColor.white.cgColor
        self.boSuuTapIcon.clipsToBounds = true
        
        self.tinhThanhIcon.layer.cornerRadius = self.tinhThanhIcon.frame.width/2.0
        self.tinhThanhIcon.layer.borderWidth = 1
        self.tinhThanhIcon.layer.borderColor = UIColor.white.cgColor
        self.tinhThanhIcon.clipsToBounds = true
        
    
        khamPhaImage.layer.cornerRadius = 5
        khamPhaImage.layer.masksToBounds = true
        
        danhMucImage.layer.cornerRadius = 5
        danhMucImage.layer.masksToBounds = true
        
        boSuuTapImage.layer.cornerRadius = 5
        boSuuTapImage.layer.masksToBounds = true
        
        tinhThanhImage.layer.cornerRadius = 5
        tinhThanhImage.layer.masksToBounds = true
        
    
        let padding = 8
        let size = 15
    
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let searchImageView = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        let image = UIImage(named: "home-search")
        searchImageView.image = image
        outerView.addSubview(searchImageView)
        homeTextSearch.leftView = outerView
        homeTextSearch.leftViewMode = .always
        
        //homeTextSearch.leftView = searchImageView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.onTabToViewProductList))
        self.khamPhaView.isUserInteractionEnabled = true
        self.khamPhaView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.onTabToViewProductList))
        self.tinhThanhView.isUserInteractionEnabled = true
        self.tinhThanhView.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.onTabToViewProductList))
        self.danhMucView.isUserInteractionEnabled = true
        self.danhMucView.addGestureRecognizer(tap3)
        
        // Do any additional setup after loading the view.
    }
    
    
    func onTabToViewProductList(sender:UITapGestureRecognizer){
        if(sender.view === khamPhaView){
            self.selectView = tabProduct
        }
        if(sender.view === tinhThanhView){
            self.selectView = tabProvince
        }
        if(sender.view === danhMucView){
            self.selectView = tabCategory
        }
        
        self.performSegue(withIdentifier: "Main", sender: sender)
    }
    
    @IBAction func nextDemo(sender:UIButton){
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoard")
        self.present(vc, animated: true, completion: nil)
        
        //self.performSegue(withIdentifier: "LoginStoryBoard", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Ham lay screen moi .
       
        if let barViewControllers = segue.destination as? UITabBarController{
            let destinationViewController = barViewControllers.viewControllers?[0] as! ProductListViewController
            destinationViewController.viewCurrent = self.selectView
            
        }
    }
    
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
}
