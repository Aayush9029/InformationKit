import SwiftUI

@main
enum InformationKitDemoMain {
    static func main() {
        if CommandLine.arguments.contains("--smoke-test") {
            InformationKitDemoSmokeTest.run()
            return
        }

        InformationKitDemoApp.main()
    }
}
