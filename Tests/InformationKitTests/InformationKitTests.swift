@testable import InformationKit
import Testing

@Suite("InformationKit Tests")
struct InformationKitTests {
    @Test("Example information is an update")
    func exampleInformationIsUpdate() {
        #expect(InformationModel.example.type == .update)
        #expect(InformationModel.example.build == "2.0")
    }
}
