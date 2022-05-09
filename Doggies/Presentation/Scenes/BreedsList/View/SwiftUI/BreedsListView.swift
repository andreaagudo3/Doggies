import Foundation
import SwiftUI

extension BreedsListItemViewModel: Identifiable { }

struct BreedsListView: View {
    @ObservedObject var viewModelWrapper: BreedsListViewModelWrapper
    
    var body: some View {
        ZStack {
            List(viewModelWrapper.items) { item in
                Button(action: {
                    self.viewModelWrapper.viewModel?.didSelect(item: item)
                }) {
                    Text(item.name.capitalizedFirst())
                        .font(.body)
                        .foregroundColor(Color(Colors.greyPrimary))
                }
            }
            .listStyle(PlainListStyle())
            .onAppear {
                self.viewModelWrapper.viewModel?.viewDidLoad()
            }
        }
        
        .navigationBarTitle(Text(self.viewModelWrapper.viewModel?.title ?? ""), displayMode: .large)
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
        BreedsListView(viewModelWrapper: previewViewModelWrapper)
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

