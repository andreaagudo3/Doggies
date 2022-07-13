import SwiftUI

public extension View {

	/// Applies padding to the top and bottom of the view
	func verticalPadding(_ space: CGFloat) -> some View {
		self.padding(.vertical, space)
	}

	/// Applies padding to the sides of the view
	func horizontalPadding(_ space: CGFloat) -> some View {
		self.padding(.horizontal, space)
	}
}
