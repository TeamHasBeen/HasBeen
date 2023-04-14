import Foundation

struct PlaceResponse: Codable {
    let results: [Place]
}

struct Place: Codable {
    let name: String
    let formattedAddress: String
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}
