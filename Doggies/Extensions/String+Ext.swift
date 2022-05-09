import Foundation

extension String {
    func capitalizedFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
