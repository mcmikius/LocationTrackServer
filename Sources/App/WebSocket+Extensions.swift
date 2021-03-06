//
//  WebSocket+Extensions.swift
//  App
//
//  Created by Mykhailo Bondarenko on 15.03.2020.
//

import Vapor
import WebSocket
import Foundation

extension WebSocket {
    func send(_ location: Location) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(location) else {
            return
        }
        
        send(data)
    }
}
