import Foundation

struct Locales {
    static let appLocale = localized("app_locale", fallback: "en_US")
    static let dogBreeds = localized("Dog breeds", fallback: "Dog breeds")
    static let ok = localized("ok", fallback: "Ok")
}
