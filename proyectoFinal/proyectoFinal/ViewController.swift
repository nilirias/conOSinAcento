//
//  ViewController.swift
//  proyectoFinal
//
//  Created by Nina on 14/10/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfSeleccionDeRegla: UILabel!
    @IBOutlet weak var bttnDerecha: UIButton!
    @IBOutlet weak var bttnIzquierda: UIButton!
    
    var i = 0
    
    let listaDeReglas = ["Regla general", "Palabras en contexto", "Hiatos y diptongos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func swipeDerecha(_ sender: UISwipeGestureRecognizer) {
    }
    
    @IBAction func swipeIzquierda(_ sender: UISwipeGestureRecognizer) {
    }
    
    
    @IBAction func seleccionDerecha(_ sender: UIButton) {
        if i == listaDeReglas.count-1 {
            i = 0
        } else {
            i += 1
        }
        tfSeleccionDeRegla.text = listaDeReglas[i]
    }
    
    @IBAction func seleccionIzquierda(_ sender: UIButton) {
        if i == 0 {
            i = listaDeReglas.count-1
        } else {
            i -= 1
        }
        tfSeleccionDeRegla.text = listaDeReglas[i]
    }
}

