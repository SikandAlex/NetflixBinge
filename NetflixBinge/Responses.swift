//
//  APIResponses.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import Foundation

struct ShowData: Codable {
    let results: [Show]?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        //case results
        case total = "total"
        case results = "results"
    }
}

struct Show: Codable {
    let title: String?
    let synopsis: String?
    let imdbid: String?
    let imgUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case synopsis
        case imdbid
        case imgUrl = "img"
    }
}
