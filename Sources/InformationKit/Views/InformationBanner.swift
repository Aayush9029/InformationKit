//
//  InformationBanner.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import SwiftUI

public struct InformationBannerStyle {
    var showDescription: Bool
    var backgroundMaterial: Material
    var showBorder: Bool
    var showShadow: Bool

    public init(
        showDescription: Bool = true,
        backgroundMaterial: Material = .ultraThinMaterial,
        showBorder: Bool = false,
        showShadow: Bool = true
    ) {
        self.showDescription = showDescription
        self.backgroundMaterial = backgroundMaterial
        self.showBorder = showBorder
        self.showShadow = showShadow
    }
}

public struct InformationBanner: View {
    @Environment(\.openURL) var openURL
    @StateObject var infoKit: InformationKit = .init()
    var style: InformationBannerStyle

    public init(style: InformationBannerStyle = InformationBannerStyle()) {
        self.style = style
    }

    public var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: infoKit.mainInformation.image) { phase in
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
                    Text(infoKit.mainInformation.title)
                        .bold()
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text(infoKit.mainInformation.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    if style.showDescription {
                        Text(infoKit.mainInformation.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
                Spacer()
                VStack {
                    Button {
                        openURL(infoKit.mainInformation.url)
                    } label: {
                        Text(
                            infoKit.mainInformation.type == .update ? "GET" : "VIEW"
                        )
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.horizontal, 6)
                    }
#if os(iOS)
                    .buttonBorderShape(.capsule)
#else
                    .buttonBorderShape(.automatic)
#endif
                    .buttonStyle(.bordered)
                    .padding(.horizontal)
                    Text("Build \(infoKit.mainInformation.build)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(height: 74)
        .background(style.backgroundMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            Group {
                if style.showBorder {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary.opacity(0.125), lineWidth: 1)
                }
            }
        )
        .shadow(color: style.showShadow ? .primary.opacity(0.10) : .clear, radius: 8, y: 6)
    }
}

struct InformationBanner_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                Spacer()
                InformationBanner()
                    .padding(6)
            }
            .background(.blue)

            VStack {
                Spacer()
                InformationBanner().padding(6)
                    .preferredColorScheme(.dark)
            }.background(.black)
        }
    }
}
