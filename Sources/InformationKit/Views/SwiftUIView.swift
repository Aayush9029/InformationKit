//
//  SwiftUIView.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import SwiftUI

public struct InformationBanner: View {
    @Environment(\.openURL) var openURL
    let information: InformationModel

    public var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: information.image) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                default:
                    Image("placeholderIcon", bundle: .module)
                        .resizable()
                }
            }
            .scaledToFit()
            .frame(maxWidth: 72)

            HStack {
                VStack(alignment: .leading) {
                    Text(information.title)
                        .bold()
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text(information.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                Spacer()
                VStack {
                    Button {
                        openURL(information.url)
                    } label: {
                        Text(
                            information.type == .update ? "GET" : "VIEW"
                        )
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.horizontal, 6)
                    }
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                    .padding(.horizontal)
                    Text("Build \(information.build, specifier: "%.1f")")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(height: 74)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

struct InformationBanner_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                Spacer()
                InformationBanner(information: .example)
            }

            VStack {
                Spacer()
                InformationBanner(information: .example)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
