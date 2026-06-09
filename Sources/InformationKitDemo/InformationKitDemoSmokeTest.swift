import InformationKit

enum InformationKitDemoSmokeTest {
    static func run() {
        let informations = InformationDemoSamples.informations

        precondition(informations.count == 3)
        precondition(informations[0].type == .update)
        precondition(informations[1].type == .news)
        _ = InformationBanner(information: informations[0])

        print("InformationKitDemo smoke test passed: 3 deterministic samples")
    }
}
