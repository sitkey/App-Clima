//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac15 on 24/11/20.
//  Copyright © 2020 Mac15. All rights reserved.
//

import Foundation

protocol ClimaManagerDelegate {
    func actualizaClima(clima: ClimaModelo)
    func huboError(cualError: Error)
}

struct ClimaManager{
    
    var delegado: ClimaManagerDelegate?
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=e8f3b2b1c105f17993bb9365d1619b2f&units=metric&lang=es"
    
    func fetchClima(nombreCiudad: String){
        let urlString = "\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
        realizarSolicitud(urlString: urlString)
    }
    func fetchClima(lat: Double, lon: Double){
        let urlString = "\(climaURL)&lat=\(lat)&lon=\(lon)"
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String){
        //Crear url
        if let url = URL(string: urlString){
            //Crear obj URLSession
            let session = URLSession(configuration: .default)
            //Asigna una tarea a las sesion
            let tarea = session.dataTask(with: url){(data, respuesta, error) in
                if error != nil{
                    self.delegado?.huboError(cualError: error!)
                    return
                }
                
                if let datosSeguros = data{
                    if let clima = self.parseJSON(climaData: datosSeguros){
                        self.delegado?.actualizaClima(clima: clima)
                    }
                }
            }
            //Empezar tarea
            tarea.resume()
        }
    }
    
    func parseJSON(climaData: Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        
        do{
            let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
           
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let temperatura =  dataDecodificada.main.temp
            let temp_max = dataDecodificada.main.temp_max
            let temp_min = dataDecodificada.main.temp_min
            let presion = dataDecodificada.main.pressure
            let humedad = dataDecodificada.main.humidity
            let sensacion = dataDecodificada.main.feels_like
            let velocidad_viento = dataDecodificada.wind.speed
            
            let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, temperaturaCelcius: temperatura, descripcionClima: descripcion, temp_max: temp_max, temp_min: temp_min, sensacion: sensacion, viento: velocidad_viento, humedad: humedad, presion: presion )
            return ObjClima
            
        }catch{
            delegado?.huboError(cualError: error)
            return nil
        }
    }
    
}
