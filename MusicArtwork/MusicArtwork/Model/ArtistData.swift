//
//  ArtistData.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct ArtistData: Decodable {
    var album = [Album]()
}

struct Album: Decodable {
    var strAlbumThumb : String = ""
}
