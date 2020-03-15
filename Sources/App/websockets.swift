

import Vapor

public func sockets(_ websockets: NIOWebSocketServer) {
    websockets.get("echo-test") { (ws, req) in
        print("ws connected")
        ws.onText { (ws, text) in
            print("ws received: \(text)")
            ws.send("echo - \(text)")
        }
    }
}
