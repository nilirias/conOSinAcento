//
//  ViewController.swift
//  proyectoFinal
//
//  Created by Nina on 14/10/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbSeleccionRegla: UILabel!
    @IBOutlet weak var bttnDerecha: UIButton!
    @IBOutlet weak var bttnIzquierda: UIButton!
    
    var i = 0
    var seleccion : Int!
    
    let listaDeReglas = ["Regla general y su aplicación", "¡Manos a la obra!", "La fuerza de la tilde"]
    override var supportedInterfaceOrientations:  UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func seleccionDerecha(_ sender: UIButton) {
        if i == listaDeReglas.count-1 {
            i = 0
        } else {
            i += 1
        }
        lbSeleccionRegla.text = listaDeReglas[i]
    }
    
    @IBAction func seleccionIzquierda(_ sender: UIButton) {
        if i == 0 {
            i = listaDeReglas.count-1
        } else {
            i -= 1
        }
        lbSeleccionRegla.text = listaDeReglas[i]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let destinationController = segue.destination as! ViewControllerVideoExplicatorio
            destinationController.seleccion = i
        }
    }
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        
    }
    
}

