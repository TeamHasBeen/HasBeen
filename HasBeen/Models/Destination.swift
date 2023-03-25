import ParseSwift
import Foundation

// Fields are tentative
// https://developers.skyscanner.net/docs/geo/overview

struct GeoInfo: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var entityId: String?
    var parentId: String?
    var name: String?
    var type: String?
    var iata: String?
    var latitude: Int?
    var longitude: Int?
}

struct Market: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var code: String?
    var name: String?
    var currency: String?
}
