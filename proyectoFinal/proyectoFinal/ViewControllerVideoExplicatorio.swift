//
//  ViewControllerVideoExplicatorio.swift
//  proyectoFinal
//
//  Created by Nina on 04/11/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewControllerVideoExplicatorio: UIViewController {

    @IBOutlet weak var btnContinuarSEGA: UIButton!
    @IBOutlet weak var btnContinuarContexto: UIButton!
    @IBOutlet weak var btnContinuarHiato: UIButton!
    
    var seleccion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //si selecciona SEGA
        if seleccion == 0{
            btnContinuarContexto.isHidden = true
            btnContinuarHiato.isHidden = true
        }
        
        //si selecciona Contexto
        if seleccion == 1{
            btnContinuarSEGA.isHidden = true
            btnContinuarHiato.isHidden = true
        
        }
        
        //si selecciona Hiato
        if seleccion == 2{
            btnContinuarSEGA.isHidden = true
            btnContinuarContexto.isHidden = true
        
        }

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
