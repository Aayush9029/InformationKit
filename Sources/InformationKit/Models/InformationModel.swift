//
//  File.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import Foundation

public struct InformationModel {
    let title: String
    let subtitle: String
    let description: String
    let image: URL
    let url: URL
    let type: String
    let build: Double

    public static let example = InformationModel(
        title: "Armed macOS",
        subtitle: "New App Update v2",
        description: "Armed app has a brand new version update with tons of new features.",
        image: URL(string: "https://raw.githubusercontent.com/Aayush9029/Armed/gh-pages/news/assets/ArmedAppIcon.png")!,
        url: URL(string: "https://armed.aayush.art/download")!,
        type: InformationType.update.rawValue,
        build: 2.0
    )
}

public enum InformationType: String {
    case news, update
}
