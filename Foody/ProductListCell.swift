//
//  ProductListCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import AVFoundation

class ProductListCell: UITableViewCell {
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    @IBOutlet weak var picturePreview: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTotalComment: UILabel!
    @IBOutlet weak var labelTotalImage: UILabel!
    @IBOutlet weak var viewToolBox: UIView!
    @IBOutlet weak var viewTopTitle: UIView!
    @IBOutlet weak var btnViewComment: UIButton!
    
    @IBOutlet weak var viewCommentList: UIView!
    @IBOutlet weak var viewCommentList2: UIView!
    @IBOutlet weak var viewCommentList3: UIView!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var avatarImage2: UIImageView!
    @IBOutlet weak var commentText2: UILabel!
    @IBOutlet weak var avatarImage3: UIImageView!
    @IBOutlet weak var commentText3: UILabel!
    @IBOutlet weak var viewVideo: UIView!
    var player = AVPlayer()
   
    var productItem: ProductItem!
    var dataComment = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell( data: ProductItem){
        
        labelProductName.text = data.name
        labelProductAddress.text = data.address
        labelScore.text = data.score
        labelTotalImage.text = String(data.otherimage.count)
        labelTotalComment.text = String(data.total_comment)
        labelScore.layer.cornerRadius = labelScore.frame.width/2.0
        labelScore.clipsToBounds = true
        if(data.total_comment>0){
            btnViewComment.setTitle("Xem \(data.total_comment) bình luận >", for: .normal)
            btnViewComment.isHidden = false
        }else{
            btnViewComment.isHidden = true
        }
        /*
        if(data.urlvideo != ""){
            viewVideo.isHidden = false
            picturePreview.isHidden = true
            let videoURL = NSURL(string: data.urlvideo)
            player = AVPlayer(url: videoURL! as URL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
            viewVideo.layer.addSublayer(playerLayer)
            player.play()
            
            
            
        }else{
            viewVideo.isHidden = true
            picturePreview.isHidden = false
            
        }*/
        picturePreview.loadImage(urlString: data.urlphoto)
        if(data.total_comment == 1){
            createViewCommentUIView(dataComment: data.comment_list as [AnyObject] , avatar: [avatarImage], label: [commentText] )
        }
        if(data.total_comment == 2){
            createViewCommentUIView(dataComment: data.comment_list as [AnyObject] , avatar: [avatarImage,avatarImage2], label: [commentText,commentText2] )
        }
        if(data.total_comment >= 3){
            createViewCommentUIView(dataComment: data.comment_list as [AnyObject] , avatar: [avatarImage,avatarImage2,avatarImage3], label: [commentText,commentText2,commentText3] )
        }
        
        }
    
    
    func createViewCommentUIView (dataComment: [AnyObject], avatar: [UIImageView], label: [UILabel]){
        if(dataComment.count >= 1){
        for i in 0..<dataComment.count {
            if(i < 3){
                let arResult = dataComment[i].components(separatedBy: "@#!|")
                avatar[i].loadImage(urlString: arResult[1])
                avatar[i].layer.cornerRadius = avatar[i].frame.width/2.0
                avatar[i].clipsToBounds = true
    
            
            label[i].font = UIFont(name: commentText.font.fontName, size: 12)
            
            let comment = arResult[0]+": \(arResult[2])"  as NSString
            let attributedString = NSMutableAttributedString(string: comment as String, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12)])
            let boldFontAttribute = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]
            attributedString.addAttributes(boldFontAttribute, range: comment.range(of: arResult[0]+":"))
            label[i].attributedText = attributedString
            label[i].numberOfLines = 2
            }
        }
        }
    }
        

}
