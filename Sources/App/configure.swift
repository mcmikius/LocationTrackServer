

import Vapor

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
  _ config: inout Config,
  _ env: inout Environment,
  _ services: inout Services
  ) throws {
  // configure your application here
  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)
  
  let websockets = NIOWebSocketServer.default()
  sockets(websockets)
  services.register(websockets, as: WebSocketServer.self)
}
