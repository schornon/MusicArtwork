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
    
    var mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else { return }
        guard let request = textField.text else { return }
        print("textField = '\(request)'")
        
        mainViewModel.saveToCoreDataHistory(request: request)
    }
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        mainViewModel.deleteAllData(entity: "CoreDataHistory")
    }
}
