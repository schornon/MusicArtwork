//
//  MainViewModel.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MainViewModel {
    
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    
    init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
}
