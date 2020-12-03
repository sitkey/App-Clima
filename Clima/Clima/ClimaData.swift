//
//  ClimaData.swift
//  Clima
//
//  Created by Mac15 on 24/11/20.
//  Copyright © 2020 Mac15. All rights reserved.
//

import Foundation

struct ClimaData: Codable{
    let name: String
    let timezone: Int
    let main: Main
    let coord: Coord
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable{
    let temp: Double
    let feels_like: Double
    let temp_max: Double
    let temp_min: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable{
    let speed: Double
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}

struct Weather: Codable{
    let id: Int
    let description: String
}
