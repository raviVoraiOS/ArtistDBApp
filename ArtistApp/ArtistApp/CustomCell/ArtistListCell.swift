//
//  ArtistListCell.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ArtistListCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    func setArtistDetails(currentArtist:SavedArtistList?) {
        if currentArtist != nil {
            self.artistLabel.text = currentArtist?.name!
            
            if currentArtist?.image != nil {
                DownloadManager.sharedManager.downloadImage(currentArtist!.image!,placeHolderImage: UIConstant.Images.noImageMedium, completion: { (image:UIImage?) -> Void in
                    
                    self.artistImageView.image = image
                })
            }
            else {
                artistImageView?.image = UIImage(named: UIConstant.Images.noImageSmall)
            }
        }
    }
}
