//
//  ViewController.swift
//  Clima
//
//  Created by Mac15 on 23/11/20.
//  Copyright © 2020 Mac15. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var climaManager = ClimaManager()

    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var buscarButton: UIButton!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var tempmax: UILabel!
    @IBOutlet weak var tempmin: UILabel!
    @IBOutlet weak var humedad: UILabel!
    @IBOutlet weak var sensacion: UILabel!
    @IBOutlet weak var viento: UILabel!
    @IBOutlet weak var presion: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        climaManager.delegado = self
        buscarTextField.delegate = self
    }
    @IBAction func buscarCiudadButton(_ sender: UIButton) {
        print(buscarTextField.text!)
        ciudadLabel.text = buscarTextField.text
        climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    @IBAction func obtenerUbicacionButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Ubicación obtenida")
        if let ubicacion = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = ubicacion.coordinate.latitude
            let lon = ubicacion.coordinate.longitude
            print("lat: \(lat), lon: \(lon)")
            climaManager.fetchClima(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension ViewController : ClimaManagerDelegate {
    func huboError(cualError: Error) {
        DispatchQueue.main.async {
            if cualError.localizedDescription == "The data couldn’t be read because it is missing."{
                self.ciudadLabel.text = "Ciudad no encontrada"
            }
            print(cualError.localizedDescription)
        }
    }
    
    func actualizaClima(clima: ClimaModelo) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = "\(clima.temperaturaCelcius)°C"
            self.ciudadLabel.text = "En \(clima.nombreCiudad) hay \(clima.descripcionClima)"
            self.imagenFondo.image = UIImage(named: clima.obtenerCondicionClima)
            self.tempmax.text = "Temperatura Max: \(clima.temp_max)°C"
            self.tempmin.text = "Temperatura Min: \(clima.temp_min)°C"
            self.humedad.text = "Humedad: \(clima.humedad)%"
            self.sensacion.text = "Sensación Térmica: \(clima.sensacion)°C"
            self.presion.text = "Presión Atmosférica: \(clima.presion) hPa"
            self.viento.text = "Velocidad del viento: \(clima.viento) m/s"
        }
    }
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        buscarTextField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(buscarTextField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTextField.text != ""{
            return true
        }else{
            buscarTextField.placeholder = "Escribe una ciudad"
            print("Por favor escibe algo ...")
            return false
        }
    }
}
