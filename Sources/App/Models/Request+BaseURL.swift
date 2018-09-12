import Vapor

/// Extend the request to create the baseURL.
extension Request {
    var baseUrl: String {
        // get the host information directly from the headers
        var host = http.headers["Host"].first ?? ""
        host = host.finished(with: "/")
        let scheme = http.remotePeer.scheme ?? "http"
        return "\(scheme)://\(host)todos/"
    }
}
