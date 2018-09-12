import Vapor

final class SecretMiddleware: Middleware, Service {
    let secret: String
    init(secret: String) {
        self.secret = secret
    }
    func respond(
        to req: Request,
        chainingTo next: Responder
        ) throws -> EventLoopFuture<Response> {
        guard let auth = req.http.headers.firstValue(name: .authorization) else {
            throw Abort.init(.unauthorized, reason: "Please include authorization header")
        }
        print(auth)
        guard auth == "Bearer secret" else {
            throw Abort.init(.unauthorized, reason: "Incorrect secret")
        }
        return try next.respond(to: req)
    }
}
