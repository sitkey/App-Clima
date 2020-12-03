//
//  ClimaModelo.swift
//  Clima
//
//  Created by Mac15 on 24/11/20.
//  Copyright © 2020 Mac15. All rights reserved.
//

import Foundation

struct ClimaModelo{
    let condicionID: Int
    let nombreCiudad: String
    let temperaturaCelcius: Double
    let descripcionClima: String
    let temp_max: Double
    let temp_min: Double
    let sensacion: Double
    let viento: Double
    let humedad: Int
    let presion: Int
    
    var obtenerCondicionClima: String{
        switch condicionID {
        case 200...232:
            return "tormenta"
        case 300...531:
            return "lluvioso"
        case 600...622:
            return "nevado"
        case 800:
            return "despejado"
        default:
            return "nublado"
        }
    }
}
