import Foundation

public protocol NetworkLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?)
    func log(error: Data?)
}

public final class DefaultNetworkLogger: NetworkLogger {
    public init() { }
    
    public func log(request: URLRequest) {
        printIfDebug("-------------")
        printIfDebug("📒 [REQUEST] : \(request.url!)")
        printIfDebug("📒 [HEADERS]: \(request.allHTTPHeaderFields!)")
        printIfDebug("📒 [METHOD]: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("📒 Body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("📒 Body: \(String(describing: resultString))")
        }
    }
    
    public func log(responseData data: Data?) {
        guard let data = data else { return }
        printIfDebug("📗 [REST RESPONSE]:\n \(data.prettyJSON)")
    }
    
    public func log(error: Data?) {
        printIfDebug("📕 [FAILED REQUEST]:\n \(error?.prettyJSON ?? "")")
    }
}

extension Data {
    var prettyJSON: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else {
                  return String(data: self, encoding: String.Encoding.utf8) ?? ""
              }
        return prettyPrintedString
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
        print(string)
    #endif
}
