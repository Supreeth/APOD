//
//  Picture.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import Foundation

///Model for the Prcture of the day
struct Picture: Codable {
    
    let copyright:String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

