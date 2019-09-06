//
//  MainViewController.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupBinging()
    }
    
    private func setupBinging() {
        
        mainViewModel.artistData.bind { [unowned self] in
            if $0.album.count > 0 {
                let urlString = $0.album[0].strAlbumThumb
                self.mainViewModel.fetchImage(urlString: urlString) {
                    self.imageView.image = self.mainViewModel.image
                    self.mainViewModel.requestStatus.value = .success
                }
            }
        }
        
        mainViewModel.requestStatus.bind { [unowned self] in
            switch $0 {
            case .none:
                break
            case .fetching:
                self.activityView.isHidden = false
                self.activityView.startAnimating()
            case .success:
                self.activityView.isHidden = true
                self.activityView.stopAnimating()
            case .failure:
                self.activityView.isHidden = true
                self.activityView.stopAnimating()
                self.textField.shake()
            }
        }
    }
    private func setupViews() {
        self.activityView.isHidden = true
        self.imageView.layer.cornerRadius = 3
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else { return }
        guard let request = textField.text else { return }
        print("textField = '\(request)'")
        
        mainViewModel.saveToCoreDataHistory(request: request)
        mainViewModel.fetchData(request: request)
    }
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        //mainViewModel.deleteAllData(entity: "CoreDataHistory")
        performSegue(withIdentifier: "segueFromMainVCToHistoryVC", sender: self)
    }
    
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HistoryViewController {
            let historyVC = segue.destination as? HistoryViewController
            historyVC?.mainViewModel = self.mainViewModel
        }
    }
    
}
