import Combine
import InformationKit

@MainActor
final class InformationDemoModel: ObservableObject {
    let informations = InformationDemoSamples.informations

    @Published private(set) var selectedIndex = 0
    @Published var showsDescription = true
    @Published var showsBorder = true
    @Published var showsShadow = true

    var selectedInformation: InformationModel {
        guard informations.indices.contains(selectedIndex) else {
            return informations[0]
        }

        return informations[selectedIndex]
    }

    var bannerStyle: InformationBannerStyle {
        InformationBannerStyle(
            showDescription: showsDescription,
            showBorder: showsBorder,
            showShadow: showsShadow
        )
    }

    func informationSelected(at index: Int) {
        guard informations.indices.contains(index) else { return }
        selectedIndex = index
    }
}
