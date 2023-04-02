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

extension Destination {
    static var destinationsArray: [Destination]  = [
        Destination(city: "London", country: "United Kingdom", continent: "Europe"),
        Destination(city: "Paris", country: "France", continent: "Europe"),
        Destination(city: "Madrid", country: "Spain", continent: "Europe"),
        Destination(city: "Berlin", country: "Germany", continent: "Europe"),
        Destination(city: "Rome", country: "Italy", continent: "Europe"),
        Destination(city: "Amsterdam", country: "Netherlands", continent: "Europe"),
        Destination(city: "Stockholm", country: "Sweden", continent: "Europe"),
        Destination(city: "Athens", country: "Greece", continent: "Europe"),
        Destination(city: "Prague", country: "Czechia", continent: "Europe"),
        Destination(city: "Milan", country: "Italy", continent: "Europe"),
        Destination(city: "Brussels", country: "Belgium", continent: "Europe"),
        Destination(city: "Copenhagen", country: "Denmark", continent: "Europe"),
        Destination(city: "Dublin", country: "Ireland", continent: "Europe"),
        Destination(city: "Lisbon", country: "Portugal", continent: "Europe"),
        Destination(city: "Barcelona", country: "Spain", continent: "Europe"),
        Destination(city: "Zurich", country: "Switzerland", continent: "Europe"),
        Destination(city: "Istanbul", country: "Turkey", continent: "Europe"),
        Destination(city: "Buenos Aires", country: "Argentina", continent: "South America"),
        Destination(city: "Santiago", country: "Chile", continent: "South America"),
        Destination(city: "Lima", country: "Peru", continent: "South America"),
        Destination(city: "Quito", country: "Ecuador", continent: "South America"),
        Destination(city: "Bogota", country: "Colombia", continent: "South America"),
        Destination(city: "Sao Paulo", country: "Brazil", continent: "South America"),
        Destination(city: "La Paz", country: "Bolivia", continent: "South America"),
        Destination(city: "Rio de Janeiro", country: "Brazil", continent: "South America"),
        Destination(city: "New York City", country: "United States", continent: "North America"),
        Destination(city: "Los Angeles", country: "United States", continent: "North America"),
        Destination(city: "Mexico City", country: "Mexico", continent: "North America"),
        Destination(city: "Guadalajara", country: "Mexico", continent: "North America"),
        Destination(city: "Panama City", country: "Panama", continent: "North America"),
        Destination(city: "Chicago", country: "United States", continent: "North America"),
        Destination(city: "Toronto", country: "Canada", continent: "North America"),
        Destination(city: "Montreal", country: "Canada", continent: "North America"),
        Destination(city: "Bangalore", country: "India", continent: "Asia"),
        Destination(city: "Tokyo", country: "Japan", continent: "Asia"),
        Destination(city: "Sydney", country: "Australia", continent: "Asia"),
        Destination(city: "Beijing", country: "China", continent: "Asia"),
        Destination(city: "Seoul", country: "South Korea", continent: "Asia"),
        Destination(city: "Singapore", country: "Singapore", continent: "Asia"),
        Destination(city: "Tel Aviv", country: "Israel", continent: "Asia"),
        Destination(city: "Dubai", country: "United Arab Emirates", continent: "Asia"),
        Destination(city: "Doha", country: "Qatar", continent: "Asia"),
        Destination(city: "Manila", country: "Philippines", continent: "Asia"),
        Destination(city: "Cape Town", country: "South Africa", continent: "Africa"),
        Destination(city: "Cairo", country: "Egypt", continent: "Africa"),
        Destination(city: "Casablanca", country: "Morocco", continent: "Africa"),
        Destination(city: "Nairobi", country: "Kenya", continent: "Africa"),
        Destination(city: "Kigali", country: "Rwanda", continent: "Africa"),
        Destination(city: "Tangier", country: "Morocco", continent: "Africa"),
        Destination(city: "Gaborone", country: "Botswana", continent: "Africa"),
        Destination(city: "Windhoek", country: "Namibia", continent: "Africa"),
        Destination(city: "Lusaka", country: "Zambia", continent: "Africa"),
        Destination(city: "Accra", country: "Ghana", continent: "Africa")
    ]
}
