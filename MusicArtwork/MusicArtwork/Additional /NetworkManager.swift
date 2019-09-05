//
//  NetworkManager.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    weak var mainViewModel: MainViewModel!
    
    let base = "https://theaudiodb.com/api/v1/json/1/searchalbum.php?"
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    func fetchData(request: String) {
        
        let array = separeteArtistFromAlbum(string: request)
        guard array.count > 1 else { self.mainViewModel.requestStatus.value = .failure; return }
        print(array)
        
        let urlString = "\(base)s=\(array[0])&a=\(array[1])"
        
        guard let url = URL(string: urlString) else { self.mainViewModel.requestStatus.value = .failure; return }
        print(url)
        
        Alamofire.request(url).responseJSON { (response) in
            print("Alamofire")
            
            guard let data = response.data else { self.mainViewModel.requestStatus.value = .failure; return }
            print(data)
            
            do {
                let parsedResult = try JSONDecoder().decode(ArtistData.self, from: data)
                if parsedResult.album.isEmpty {
                    print("parsedResult.album.isEmpty")
                    self.mainViewModel.requestStatus.value = .failure
                } else {
                    self.mainViewModel.artistData.value = parsedResult
                }
                
            } catch let error {
                print(error)
                self.mainViewModel.requestStatus.value = .failure
            }
        }
    }
    
    
    private func separeteArtistFromAlbum(string: String) -> [String] {
        var array = Array<Substring>()
        
        if string.contains("-") {
            array = string.split(separator: "-")
        } else if string.contains(":") {
            array = string.split(separator: ":")
        } else if string.contains("|") {
            array = string.split(separator: "|")
        } else if string.contains("\\") {
            array = string.split(separator: "\\")
        } else if string.contains("/") {
            array = string.split(separator: "/")
        } else if string.contains("~") {
            array = string.split(separator: "~")
        }
        
        var result = [String]()
        for s in array {
            let trimmedString = String(s.trimmingCharacters(in: .whitespacesAndNewlines))
            guard let trimmedUrlString = trimmedString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                return [String]()
            }
            
            result.append(trimmedUrlString)
        }
        return result
    }
    
    func fetchImage(urlString: String, closure: @escaping ()->()) {
        guard let url = URL(string: urlString) else {
            print("guard url fetching image error")
            self.mainViewModel.requestStatus.value = .failure
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let img = UIImage(data: data) {
                    self.mainViewModel.image = img
                    DispatchQueue.main.async {
                        closure()
                    }
                } else {
                    self.mainViewModel.requestStatus.value = .failure
                }
            } catch let error {
                self.mainViewModel.requestStatus.value = .failure
                print(error)
            }
        }
    }
}


// https://theaudiodb.com/api/v1/json/1/searchalbum.php?s=Coldplay&a=Parachutes&s=Coldplay&a=Parachutes

// Coldplay - Parachutes
