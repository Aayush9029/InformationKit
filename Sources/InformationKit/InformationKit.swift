//
//  InformationKit.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import SwiftUI

public enum InformationViewType {
    case index, random, prioritized
}

public class InformationKit: ObservableObject {
    @Published public var allInformations: [InformationModel] = []
    ///  Depending on the InformationViewType the main information is either the first one from list, random information or prioritized
    ///  Update is given more priority than news if build number > installed apps build number
    @Published public var mainInformation: InformationModel?

    public var informationViewType: InformationViewType = .index

    var sourceURL: URL?

    func fetchInformations() {
        guard let sourceURL else {
            print("Source URL not found in info.plist")
            return
        }
        Task {
            guard let fetchedInformations = try? await InformationModel.fetchInformations(from: sourceURL) else { return }
            allInformations = fetchedInformations
        }
    }

    @MainActor
    func prioritizeInformation() {
        if allInformations.count < 1 {
            mainInformation = allInformations.first
        }
        switch informationViewType {
        case .index:
            mainInformation = allInformations.first
        case .random:
            mainInformation = allInformations.randomElement()
        case .prioritized:
            for information in allInformations {
                if information.type == .update && information.build > readAppBuildNumber() {
                    mainInformation = information
                    return
                }
            }
            mainInformation = allInformations.first
        }
    }

    public func readInfoPlistValue(forKey key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }

    func loadSourceURL() {
        let urlString = readInfoPlistValue(forKey: "InformationSourceURL")
        guard let urlString else {
            fatalError("Update info.plist's InformationSourceURL, check docs")
        }
        guard let url = URL(string: urlString) else {
            fatalError("info.plist's InformationSourceURL needs a source .json URL")
        }
        sourceURL = url
    }

    func readAppBuildNumber() -> Double {
        return Double(readInfoPlistValue(forKey: "CFBundleVersion") ?? "0.0") ?? 0.0
    }
}
