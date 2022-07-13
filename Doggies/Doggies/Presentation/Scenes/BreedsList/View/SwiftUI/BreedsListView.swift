import Foundation
import SwiftUI

extension BreedsListItemViewModel: Identifiable { }

struct BreedsListView: View {
    @ObservedObject var viewModelWrapper: BreedsListViewModelWrapper
    
	var body: some View {
		ZStack {
			UIColor.systemBackground.asColor().ignoresSafeArea()
			
			ScrollView(.vertical) {
				VStack(alignment: .leading, spacing: 8, content: {
					ForEach(viewModelWrapper.items) { item in
						Button(action: {
							self.viewModelWrapper.viewModel?.didSelect(item: item)
						}) {
							Row(title: item.name.capitalizedFirst())
						}
					}
				})
				.horizontalPadding(8)
				.verticalPadding(16)
			}
        }
		.navigationBarTitle(Text(self.viewModelWrapper.viewModel?.title ?? ""), displayMode: .large)
		
    }
}

extension BreedsListView {
	struct Row: View {
		let title: String
		
		var body: some View {
			ZStack(alignment: .leading, content: {
				RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
					.foregroundColor(Colors.lightBg.asColor())
				VStack(alignment: .leading, spacing: 35, content: {
					Text(title)
						.font(.body)
						.foregroundColor(Colors.greyPrimary.asColor())
				})
				.horizontalPadding(16)
				.verticalPadding(20)
			})
		}
	}
}

final class BreedsListViewModelWrapper: ObservableObject {
    var viewModel: BreedsListViewModel?
    @Published var items: [BreedsListItemViewModel] = []
    
    init(viewModel: BreedsListViewModel?) {
        self.viewModel = viewModel
        viewModel?.items.observe(on: self) { [weak self] values in self?.items = values }
    }
}

#if DEBUG
struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			BreedsListView(viewModelWrapper: previewViewModelWrapper)
				.preferredColorScheme(.light)
			BreedsListView(viewModelWrapper: previewViewModelWrapper)
				.preferredColorScheme(.dark)
		}
    }
    
    static var previewViewModelWrapper: BreedsListViewModelWrapper = {
        var viewModel = BreedsListViewModelWrapper(viewModel: nil)
        viewModel.items = [BreedsListItemViewModel(name: "Doggie breed 1"),
                           BreedsListItemViewModel(name: "Doggie breed 2")
        ]
        return viewModel
    }()
}
#endif

