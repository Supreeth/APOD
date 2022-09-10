//
//  Constants.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import Foundation

struct NetworkConstants {
    static let baseUrl = "https://api.nasa.gov/planetary/apod"
    static let apiKey = "Lxbac1pBaIQ2lmEh5vl7282kos9aQeLfcWJcu9Hl"
}

struct FileKeyConstants {
    static let pictureKey = "picture"
}

struct NavigationConstants{
    static let favouriteIcon = "hand.thumbsup"
    static let favouriteFillIcon = "hand.thumbsup.fill"
    static let calendarIcon = "calendar"
}

struct StorageConstants {
    static let recentPictureEntityName = "RecentPicture"
    static let dateKey = "date"
    static let explanationKey = "explanation"
    static let hdurlKey = "hdurl"
    static let titleKey = "title"
    static let mediaTypeKey = "mediaType"
    static let imageDataKey = "imageData"
}

struct LocalizeConstants {
    static let homeScreenTitle = "Home screen title"
    static let couldNotDelete = "Could not delete."
    static let couldNotFetch = "Could not delete."
}
