//
//  HistoryViewController.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    var mainViewModel : MainViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        setupViews()
    }
    
    private func setupViews() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.tableFooterView = UIView()
    }
    

    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegueToMainVC", sender: self)
    }
    
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        mainViewModel.deleteAllData(entity: "CoreDataHistory")
        self.historyTableView.reloadData()
    }
    
}
