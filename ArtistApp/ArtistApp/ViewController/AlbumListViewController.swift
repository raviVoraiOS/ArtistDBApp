//
//  AlbumListViewController.swift
//  ArtistApp
//
//  Created by Admin on 20/07/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

struct AlbumListCellHeight {
    static let cellHeight = 110
}

class AlbumListViewController: UIViewController {

    ///Properties : -
    
    @IBOutlet weak var artistListTableView: UITableView!
    var artistArray:Array<SavedArtistList> = Array()
    
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
    }
    
    
    // MARK:- UI Methods

    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        self.getArtistList()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        self.title = "Artists"
    }
    
    func registerNibs() {
        let nib2 = UINib(nibName: TagIDConstant.cellIDs.ArtistListCell, bundle: nil)
        artistListTableView.register(nib2, forCellReuseIdentifier: TagIDConstant.cellIDs.ArtistListCell)
        artistListTableView.tableFooterView = UIView()
    }
    

    //********************
    // MARK:- WebService Methods
    //********************
    
    func callWSToArtistList() {
        
        ArtistManager.artist.getArtistList(vc: self, paramDict: nil, onSuccess: { [] (resultList) in
            
            DispatchQueue.main.async { [] in
                if resultList?.feed?.album! == nil {
                    return
                }
                var newartistArray:Array<Album> = Array()
                newartistArray = resultList!.feed!.album!
                self.saveArtistList(albumList:newartistArray)
            }
        }, onError: { (apiError) in
            
            DispatchQueue.main.async { [] in
                
                SharedClass.sharedInstance.showProgressHUD(false)
                switch apiError {
                case .AuthenticationError( _):
                    break
                case .UnknownError( _):
                    break
                case .NoDataFound(_):
                    break
                case .AlreadyExists(_):
                    break
                }
            }
        })
    }
    
    // MARK:- Core Data Save and Fetch Methods
    
    func saveArtistList(albumList:[Album]) {
        
        DataManager.fetch.saveArtistList(albumList:albumList) { (isSaved) in
            if isSaved == true {
                print("data saved")
            }
        }
        if artistArray.count == 0 {
            self.getArtistList()
        }
    }
    
    func getArtistList() {
        DataManager.fetch.getArtistList { (savedList) in
            if savedList != nil {
                self.artistArray.removeAll()
                self.artistArray = savedList!
                self.artistListTableView.reloadData()
            }
            else {
                self.callWSToArtistList()
            }
        }
    }
}


// MARK:- UITableView Delegate Methods

extension AlbumListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.artistArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AlbumListCellHeight.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.ArtistListCell, for: indexPath) as! ArtistListCell
        cell.setArtistDetails(currentArtist: artistArray[indexPath.row])
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objAlbumDetailViewController: AlbumDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: TagIDConstant.storyBoardIDs.kAlbumDetailViewController) as! AlbumDetailViewController
        objAlbumDetailViewController.objArtist = self.artistArray[indexPath.row]
        self.navigationController?.pushViewController(objAlbumDetailViewController, animated: true)
    }
}

