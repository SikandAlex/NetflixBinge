//
//  APIResponses.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import Foundation

// Response from UNOGS API is nested so we need two structures

struct ShowData: Codable {
    let results: [Show]?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case total
        case results
    }
}

struct Show: Codable {
    let title: String?
    let synopsis: String?
    let imdbid: String?
    let imgUrl: String?
    let avgRating: Float?
    let year: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case synopsis
        case imdbid
        case imgUrl = "img"
        case avgRating = "avgrating"
        case year
    }
}
