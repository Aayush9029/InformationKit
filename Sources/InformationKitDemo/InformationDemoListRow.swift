import InformationKit
import SwiftUI

struct InformationDemoListRow: View {
    var information: InformationModel
    var isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(information.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)

                Spacer()

                Text(typeLabel)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(typeColor)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(typeColor.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
            }

            Text(information.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(rowBackground, in: RoundedRectangle(cornerRadius: 8))
        .contentShape(RoundedRectangle(cornerRadius: 8))
    }

    private var typeLabel: String {
        switch information.type {
        case .news:
            return "NEWS"
        case .update:
            return "UPDATE"
        }
    }

    private var typeColor: Color {
        switch information.type {
        case .news:
            return .blue
        case .update:
            return .green
        }
    }

    private var rowBackground: Color {
        isSelected ? Color.accentColor.opacity(0.14) : Color.clear
    }
}
