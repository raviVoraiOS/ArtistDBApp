//
//  AlbumDetailViewController.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

struct ArtistInfoCellHeight {
    static let cellHeight = 260
    static let similarCellHeight = 90
}

class AlbumDetailViewController: UIViewController {

    ///Properties : -
    
    //Banner View
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    //Artist Basic Info
    @IBOutlet weak var artbasicInfoView: UIView!
    @IBOutlet weak var subLabel: AttributedLabel!
    @IBOutlet weak var albumLinkTextView: UITextView!
    @IBOutlet weak var priceLabel: AttributedLabel!
    @IBOutlet weak var releaseDateLabel: AttributedLabel!
    
    var objArtist:SavedArtistList?
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    

    // MARK:- UI Methods
    
    func setupUI() {
        self.setupNavigationBar()
        self.setUpArtistbasicInfo()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        
        if self.objArtist != nil {
            self.title = objArtist?.name!
        }
        else {
            self.title = objArtist?.name!
        }
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named:UIConstant.Images.backIcon), for: .normal)
        button.addTarget(self, action: #selector(self.backClicked), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
   
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //**********To fill up artist basic info *************
    
    func setUpArtistbasicInfo() {
        self.subLabel.setAttributedTextColor(leadingText: "Artist : ", trailingText: self.objArtist?.title!)
        self.albumLinkTextView.text = self.objArtist?.artistLink!

        if objArtist?.image != nil {
            DownloadManager.sharedManager.downloadImage(objArtist!.image!,placeHolderImage: UIConstant.Images.noImageLarge, completion: { (image:UIImage?) -> Void in
                
                self.bannerImageView.image = image
            })
        }
        else {
            bannerImageView?.image = UIImage(named: UIConstant.Images.noImageLarge)
        }
        self.priceLabel.setAttributedTextColor(leadingText: "Price : ", trailingText: self.objArtist!.price!)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date = dateFormatter.date(from: self.objArtist!.releaseDate!)
        dateFormatter.dateFormat = "MMM,dd YYYY"
        let dateString:String = dateFormatter.string(from: date!)
        self.releaseDateLabel.setAttributedTextColor(leadingText: "Release Date : ", trailingText: dateString)
    }
}

// MARK:- TextView Delegate Methods

extension AlbumDetailViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
 }
