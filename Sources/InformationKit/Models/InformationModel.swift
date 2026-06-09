//
//  InformationModel.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import Foundation

public struct InformationModel: Codable, Equatable, Sendable {
    public let title: String
    public let subtitle: String
    public let description: String
    public let image: URL
    public let url: URL
    public let type: InformationType
    public let build: String

    public init(
        title: String,
        subtitle: String,
        description: String,
        image: URL,
        url: URL,
        type: InformationType,
        build: String
    ) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.image = image
        self.url = url
        self.type = type
        self.build = build
    }

    public static let example = InformationModel(
        title: "Armed macOS",
        subtitle: "New App Update v2",
        description: "Armed app has a brand new version update with tons of new features.",
        image: URL(string: "https://raw.githubusercontent.com/Aayush9029/Armed/gh-pages/news/assets/ArmedAppIcon.png")!,
        url: URL(string: "https://armed.aayush.art/download")!,
        type: .update,
        build: "2.0"
    )

    public static func fetchInformations(from url: URL) async throws -> [InformationModel] {
        try await APIService.fetchInformations(from: url)
    }
}

public enum InformationType: String, Codable, Equatable, Sendable {
    case news, update
}
