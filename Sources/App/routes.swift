

import Routing
import Vapor
import WebSocket
import Foundation

// MARK: For the purposes of this example, we're using a simple global collection.
// in production scenarios, this will not be scalable beyonnd a single server
// make sure to configure appropriately with a database like Redis to properly
// scale
let sessionManager = TrackingSessionManager()

public func routes(_ router: Router) throws {
    
    // MARK: Status Checks
    
    router.get("status") { _ in "ok \(Date())" }
    router.get("word-test") { request in
        return wordKey(with: request)
    }
    router.post("create", use: sessionManager.createTrackingSession)
    router.post("close", TrackingSession.parameter) { (req) -> HTTPStatus in
        let session = try req.parameters.next(TrackingSession.self)
        sessionManager.close(session)
        return .ok
    }
    router.post("update", TrackingSession.parameter) { (req) -> Future<HTTPStatus> in
        let session = try req.parameters.next(TrackingSession.self)
        return try Location.decode(from: req).map(to: HTTPStatus.self) { location in
            sessionManager.update(location, for: session)
            return .ok
        }
        
    }
}
