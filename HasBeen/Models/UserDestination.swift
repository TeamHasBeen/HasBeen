import Foundation
import ParseSwift

struct UserDestination: ParseObject {
    
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var user: Pointer<User>?
    var destination: Pointer<Destination>?
}
