/// InformationKit is a public class used to manage the fetching, prioritization, and display of information from a remote source.
/// It conforms to the ObservableObject protocol, allowing it to notify its subscribers of changes to its published properties.
///
/// - Note: Ensure that the required keys ("InformationSourceURL" and "InformationSortType") are added to the app's Info.plist file.
///

import os.log
import SwiftUI

public class InformationKit: ObservableObject {
    /// An instance of Logger to log events related to InformationKit.
    private lazy var logger = Logger(subsystem: Bundle.main.className, category: "ℹ️📦")

    /// A collection of InformationModel objects representing all the available information.
    @Published public var allInformations: [InformationModel] = []

    /// The mainInformation represents the most relevant piece of information based on the InformationViewType and other factors.
    /// Update information is prioritized over news if the build number is greater than the installed app's build number.
    @Published public var mainInformation: InformationModel = .example

    /// The sortType determines how the main information should be chosen from the available information.
    public var sortType: InformationSortType = .prioritized

    /// The sourceURL is the remote URL from which information is fetched.
    var sourceURL: URL?

    /// Initializes an instance of InformationKit.
    init() {
        loadSourceURL()
        loadViewType()
        fetchInformations()
    }

    /// Fetches the information from the sourceURL and updates the allInformations array.
    func fetchInformations() {
        guard let sourceURL = sourceURL else {
            logger.error("Source URL not found in info.plist")
            return
        }
        Task {
            do {
                allInformations = try await InformationModel.fetchInformations(from: sourceURL)
                prioritizeInformation()
            } catch {
                logger.error("Error:\(error) fetching Informations from \(sourceURL)")
            }
        }
    }

    /// Prioritizes the information based on the sortType and updates the mainInformation property.
    func prioritizeInformation() {
        logger.log("Prioritizing Informations")
        if allInformations.count < 1 {
            logger.log("Only one information found returning it.")
            mainInformation = allInformations.first ?? .example
        }
        switch sortType {
        case .index:
            logger.log("Returning first information")
            mainInformation = allInformations.first ?? .example
        case .random:
            logger.log("Returning random information")
            mainInformation = allInformations.randomElement() ?? .example
        case .prioritized:
            logger.log("Returning prioritized information")
            for information in allInformations {
                if information.type == .update && information.build > readAppBuildNumber() {
                    mainInformation = information
                    return
                }
            }
            mainInformation = allInformations.first ?? .example
        }
    }

    /// Reads a value from the app's Info.plist file.
    func readInfoPlistValue(forKey key: String) -> String? {
        logger.log("Reading info.plist value for \(key)")
        let value = Bundle.main.object(forInfoDictionaryKey: key) as? String
        logger.log("Got \(String(describing: value)) from info.plist for \(key)")
        return value
    }

    /// Loads the sourceURL from the app's Info.plist file.

    func loadSourceURL() {
        logger.log("Loading Source URL (InformationSourceURL) from info.plist")
        let urlString = readInfoPlistValue(forKey: "InformationSourceURL")
        guard let urlString else {
            logger.error("InformationSourceURL not found in info.plist")
            return
        }
        guard let url = URL(string: urlString) else {
            logger.error("InformationSourceURL is not a valid URL")
            return
        }
        sourceURL = url
    }

    /// Loads the sortType from the app's Info.plist file.
    func loadViewType() {
        logger.log("Loading sort type (InformationSortType) from info.plist")
        let value = readInfoPlistValue(forKey: "InformationSortType")
        guard let value else {
            logger.error("InformationSortType not found in info.plist")
            return
        }
        if let type = InformationSortType(rawValue: value) {
            sortType = type
        } else {
            logger.error("InformationSortType must be either (index, random, prioritized)")
        }
    }

    /// Reads the app's build number from the Info.plist file.
    ///
    /// - Returns: The app's build number as a String, or "0" if the key is not present.
    func readAppBuildNumber() -> String {
        return readInfoPlistValue(forKey: "CFBundleVersion") ?? "0"
    }

    /// InformationSortType is an enumeration used to specify the strategy for prioritizing and displaying information.
    public enum InformationSortType: String {
        case index, random, prioritized
    }
}
