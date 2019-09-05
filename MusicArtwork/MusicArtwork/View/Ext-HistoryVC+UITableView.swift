//
//  Ext-HistoryVC+UITableView.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        if let text = self.mainViewModel.history[indexPath.row].request {
            cell.requestLabel.text = text
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
        guard let text = cell.requestLabel.text else { return }
        mainViewModel.fetchData(request: text)
        performSegue(withIdentifier: "unwindSegueToMainVC", sender: self)
    }
    
    
}
