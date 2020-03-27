//
//  NetworkManager.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//


import Foundation

final class Fetcher {

  var shows: [Show] = []
  private let domainUrlString = "https://unogsng.p.rapidapi.com/search?country_andorunique=unique&limit=100&countrylist=78&offset=0&type=series&start_rating=7&end_rating=10"
  
  func fetchShows(completionHandler: @escaping ([Show]) -> Void) {
    let url = URL(string: domainUrlString)!
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.addValue("unogsng.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    request.addValue("cb1bb20187msha88ad05fac42946p199f13jsne675ffd85911", forHTTPHeaderField: "x-rapidapi-key")
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
      
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(response)")
        return
      }

      if let data = data {
        if let jsonString = String(data: data, encoding: .utf8) {
            let res = try? JSONDecoder().decode(ShowData.self, from: jsonString.data(using: .utf8)!)
            completionHandler(res?.results ?? [])
        }
      }
    })
    task.resume()
  }

}
 
