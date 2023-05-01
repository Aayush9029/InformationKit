//
//  InformationModel.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import Foundation

public struct InformationModel: Codable {
    let title: String
    let subtitle: String
    let description: String
    let image: URL
    let url: URL
    let type: InformationType
    let build: Double

    public static let example = InformationModel(
        title: "Armed macOS",
        subtitle: "New App Update v2",
        description: "Armed app has a brand new version update with tons of new features.",
        image: URL(string: "https://raw.githubusercontent.com/Aayush9029/Armed/gh-pages/news/assets/ArmedAppIcon.png")!,
        url: URL(string: "https://armed.aayush.art/download")!,
        type: .update,
        build: 2.0
    )

    public static func fetchInformations(from url: URL) async throws -> [InformationModel] {
        try await APIService.fetchInformations(from: url)
    }
}

public enum InformationType: String, Codable {
    case news, update
}
