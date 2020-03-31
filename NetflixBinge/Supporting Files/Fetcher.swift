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
    //test comment
   
    var api_key = "f8ae9a386c3c783ce0bd4eb3bfe9862b"
    
    var tmdb_url = "https://api.themoviedb.org/3"
    
    var search_endpt = "/search"
    
    var movie_suggestions = "/movie?"
    var show_suggestions = "/tv?"
    
    var movie_id_query = "/movie/"
    var show_id_query = "/tv/"
  
  
    func fetchShows(category: String, startRating: Int, endRating: Int, completionHandler: @escaping ([Show]) -> Void) {
        var cat = ""
        if category == "Movies" {
            cat = "movie"
        }
        else if category == "TV Shows" {
            cat = "series"
        }
        let domainUrlString = "https://unogsng.p.rapidapi.com/search?type=" + cat + "&orderby=date"
        print(domainUrlString)
    let url = URL(string: domainUrlString)!
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.addValue("unogsng.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    request.addValue("", forHTTPHeaderField: "x-rapidapi-key")
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
            print(jsonString)
            let res = try? JSONDecoder().decode(ShowData.self, from: jsonString.data(using: .utf8)!)
            completionHandler(res?.results ?? [])
        }
      }
    })
    task.resume()
  }
    
    func convertId(imdbId: String, completionHandler: @escaping (Int) -> Int?)  {
        //var mreq_url = tmdb_url + "/find" + show_id_query + String(show_id) + "?api_key=" + api_key
        var mreq_url = tmdb_url + "/find/" + imdbId + "?api_key=" + api_key + "&external_source=imdb_id"
        let session = URLSession.shared
        guard let url = URL(string: mreq_url) else {return}
        let task = session.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as! [String: Any]
                let results = jsonResponse["tv_results"] as! [[String: Any]]
                let id = results[0]["id"] as! Int
                completionHandler(id)
             } catch let parsingError {
                print("Error", parsingError)
           }
            
        }
        task.resume()
    }
    
    func getRuntime(tmdbId: Int, completionHandler: @escaping (Int, Int) -> (String)?) {
        var mreq_url = tmdb_url + show_id_query + String(tmdbId) + "?api_key=" + api_key
        let session = URLSession.shared
        guard let url = URL(string: mreq_url) else {return}
        let task = session.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as! [String: Any]
                let numEpisodes = jsonResponse["number_of_episodes"] as! Int
                let episodeRuntime = jsonResponse["episode_run_time"] as! [Int]
                let sumRuntime = episodeRuntime.reduce(0, +)
                let numSeasons = jsonResponse["number_of_seasons"] as! Int
                completionHandler(sumRuntime * numEpisodes, numSeasons)
                //completionHandler(id)
             } catch let parsingError {
                print("Error", parsingError)
           }
            
        }
        task.resume()
    }
    

    
    
}
 
