import Foundation
import UIKit

protocol AlertScene: AnyObject {
    func showErrorAlert(_ error: String, handler: ((UIAlertAction) -> Void)?)
}

protocol Alerter: AnyObject {
    func alert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
}

extension AlertScene {
    func showErrorAlert(_ error: String, handler: ((UIAlertAction) -> Void)? = nil) {
        guard !error.isEmpty else { return }
        showErrorAlert(error, handler: handler)
    }
}

extension UIViewController: Alerter {
    func alert(title: String = "",
               message: String,
               handler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            // Create the alert
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = Colors.greyPrimary
            alert.addAction(UIAlertAction(title: Locales.ok, style: .default, handler: handler))

            // Show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}
