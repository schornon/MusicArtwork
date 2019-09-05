//
//  Box.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> ()
    
    private var listeners: [Listener] = []
    
    var value: T {
        didSet {
            for l in listeners {
                l(value)
            }
        }
    }
    
    func bind(l: @escaping Listener) {
        listeners.append(l)
    }
    
    init(_ v: T) {
        value = v
    }
}
