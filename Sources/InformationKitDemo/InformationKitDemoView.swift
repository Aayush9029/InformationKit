import InformationKit
import SwiftUI

struct InformationKitDemoView: View {
    @StateObject private var model = InformationDemoModel()

    var body: some View {
        HStack(spacing: 0) {
            sidebar
            Divider()
            previewPane
        }
        .frame(minWidth: 820, minHeight: 460)
    }

    private var sidebar: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("InformationKit Demo")
                .font(.title2.bold())

            VStack(alignment: .leading, spacing: 8) {
                Text("Samples")
                    .font(.headline)

                ForEach(model.informations.indices, id: \.self) { index in
                    Button {
                        model.informationSelected(at: index)
                    } label: {
                        InformationDemoListRow(
                            information: model.informations[index],
                            isSelected: model.selectedIndex == index
                        )
                    }
                    .buttonStyle(.plain)
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("Banner style")
                    .font(.headline)

                Toggle("Description", isOn: $model.showsDescription)
                Toggle("Border", isOn: $model.showsBorder)
                Toggle("Shadow", isOn: $model.showsShadow)
            }

            Spacer()
        }
        .padding(24)
        .frame(width: 300, alignment: .topLeading)
    }

    private var previewPane: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Banner Preview")
                .font(.title3.bold())

            InformationBanner(
                information: model.selectedInformation,
                style: model.bannerStyle
            )
            .padding(16)

            Text(model.selectedInformation.description)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
