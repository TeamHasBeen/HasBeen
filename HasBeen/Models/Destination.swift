import ParseSwift
import Foundation

// Won't be involved with any API calls, only needs to conform to
// Parse protocol.

struct Destination: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var city: String?
    var country: String?
    var continent: String?
}
