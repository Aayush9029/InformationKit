import Foundation
import InformationKit

enum InformationDemoSamples {
    static let informations: [InformationModel] = [
        InformationModel(
            title: "Armed macOS",
            subtitle: "New app update v2",
            description: "A deterministic update banner with a newer build number.",
            image: placeholderImageURL,
            url: URL(string: "https://example.com/informationkit/update")!,
            type: .update,
            build: "2.0"
        ),
        InformationModel(
            title: "Release Notes",
            subtitle: "News card",
            description: "A news banner sample for the secondary call to action.",
            image: placeholderImageURL,
            url: URL(string: "https://example.com/informationkit/news")!,
            type: .news,
            build: "1.0"
        ),
        InformationModel(
            title: "Maintenance Window",
            subtitle: "Service notice",
            description: "A compact sample that keeps the same model shape.",
            image: placeholderImageURL,
            url: URL(string: "https://example.com/informationkit/notice")!,
            type: .news,
            build: "1.1"
        ),
    ]

    private static let placeholderImageURL = URL(string: "https://example.invalid/informationkit/icon.png")!
}
