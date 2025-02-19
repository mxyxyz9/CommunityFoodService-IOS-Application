import Foundation
import SwiftData
import CoreLocation

@Model
final class FoodPost {
    var id: UUID
    var title: String
    var foodDescription: String
    var imageURL: URL?
    var isVegetarian: Bool
    var servingSize: Int
    var location: Location
    var expirationDate: Date
    var createdAt: Date
    var updatedAt: Date
    var userId: String
    var isActive: Bool
    
    init(
        title: String,
        foodDescription: String,
        imageURL: URL? = nil,
        isVegetarian: Bool,
        servingSize: Int,
        location: Location,
        expirationDate: Date,
        userId: String
    ) {
        self.id = UUID()
        self.title = title
        self.foodDescription = foodDescription
        self.imageURL = imageURL
        self.isVegetarian = isVegetarian
        self.servingSize = servingSize
        self.location = location
        self.expirationDate = expirationDate
        self.userId = userId
        self.createdAt = Date()
        self.updatedAt = Date()
        self.isActive = true
    }
}

@Model
final class Location {
    var latitude: Double
    var longitude: Double
    var address: String
    
    init(latitude: Double, longitude: Double, address: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
