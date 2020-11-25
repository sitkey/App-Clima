//
//  ViewController.swift
//  Clima
//
//  Created by Mac15 on 23/11/20.
//  Copyright © 2020 Mac15. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    func huboError(cualError: Error) {
        DispatchQueue.main.async {
            self.ciudadLabel.text = cualError.localizedDescription
            print(cualError.localizedDescription)
        }
    }
    
    func actualizaClima(clima: ClimaModelo) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(clima.temperaturaCelcius)
            self.ciudadLabel.text = clima.descripcionClima
            self.imagenFondo.image = UIImage(named: clima.obtenerCondicionClima)
        }
    }
    
    
    var climaManager = ClimaManager()

    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var buscarButton: UIButton!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        climaManager.delegado = self
        buscarTextField.delegate = self
    }
    
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

    @IBAction func buscarCiudadButton(_ sender: UIButton) {
        print(buscarTextField.text!)
        ciudadLabel.text = buscarTextField.text
        climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    
}

