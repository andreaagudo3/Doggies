import Foundation
import UIKit

enum LoadingLockType {
    case lockView
}

protocol LoadScene: AnyObject {
    func startLoading(_ lockType: LoadingLockType)
    func stopLoading(_ lockType: LoadingLockType)
}

// MARK: UIViewController
extension UIViewController {
    private static let association = ObjectAssociation<UIActivityIndicatorView>()

    var thisActivityIndicator: UIActivityIndicatorView {
        set { UIViewController.association[self] = newValue }
        get {
            if let indicator = UIViewController.association[self] {
                return indicator
            } else {
                UIViewController.association[self] = UIActivityIndicatorView.customIndicator(at: self.view.center)
                return UIViewController.association[self]!
            }
        }
    }

    // MARK: - Activity Indicator
    private func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.view.addSubview(self.thisActivityIndicator)
            self.thisActivityIndicator.startAnimating()
        }
    }

    private func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.thisActivityIndicator.removeFromSuperview()
            self.thisActivityIndicator.stopAnimating()
        }
    }
}

extension UIViewController {

    func startLoading(lockType: LoadingLockType) {
        switch lockType {
        case .lockView:
            DispatchQueue.main.async {
                self.startIndicatingActivity()
            }
        }
    }

    func stopLoading(lockType: LoadingLockType) {
        switch lockType {
        case .lockView:
            DispatchQueue.main.async {
                self.stopIndicatingActivity()
            }
        }
    }
}


// MARK: UIView
extension UIView {
    private static let association = ObjectAssociation<UIActivityIndicatorView>()

    var thisActivityIndicator: UIActivityIndicatorView {
        set { UIView.association[self] = newValue }
        get {
            if let indicator = UIView.association[self] {
                return indicator
            } else {
                UIView.association[self] = UIActivityIndicatorView.customIndicator(at: self.center)
                return UIView.association[self]!
            }
        }
    }

    func startLoading() {
        DispatchQueue.main.async {
            self.addSubview(self.thisActivityIndicator)
            self.thisActivityIndicator.startAnimating()
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.thisActivityIndicator.stopAnimating()
        }
    }
}

// MARK: CustomIndicator
extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        indicator.layer.cornerRadius = 0
        indicator.color = .gray
        indicator.center = center
        indicator.backgroundColor = .clear
        indicator.hidesWhenStopped = true
        return indicator
    }
}

public final class ObjectAssociation<T: AnyObject> {

    private let policy: objc_AssociationPolicy

    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {

        self.policy = policy
    }

    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {
        // swiftlint:disable:next force_cast
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}

