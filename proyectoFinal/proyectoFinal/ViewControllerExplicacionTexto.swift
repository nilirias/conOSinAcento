//
//  ViewControllerExplicacionTexto.swift
//  proyectoFinal
//
//  Created by Nina on 04/11/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewControllerExplicacionTexto: UIViewController {
    
    @IBOutlet weak var lbSeleccionRegla: UILabel!
    @IBOutlet weak var tvExplicacion: UITextView!
    
     var i = 0
       
    let listaDeReglas = ["Regla general", "Palabras en contexto", "Hiatos y diptongos"]
    let listaDeExplicacion = ["La regla general también es conocida como SEGA, la palabra se tiene que dividir en sílabas. Empezando de derecha a izquierda: La palabra es aguda si la sílaba tónica recae en la última sílaba. La palabra es grave si la sílaba tónica recae en la penúltima sílaba. La palabra es esdrújula si la sílaba tónica recae en la antepenúltima sílaba. La palabra es sobresdrújula si la sílaba tónica recae antes de la antepenúltima sílaba. Las palabras agudas llevan tilde si acaban en n, s, o vocal. Las palabras graves llevan tilde si no acaban en n, s, o vocal. Las palabras esdrújulas y sobresdrújulas siempre llevan tilde.",
        "Dependiendo de la enunciación de las palabras, la sílaba tónica cambia. Para saber la forma correcta de agregar la tilde tenemos que conocer el contexto.",
        "Un hiato es la secuencia de dos vocales que se encuentran juntas, pero están en diferentes sílabas. Los hiatos existen ya que a la hora de tener diptongos (dos vocales en una sílaba). El diptongo se rompe cuando el acento recae en la vocal débil. Las vocales pueden ser divididas en dos, las vocales fuertes y las vocales débiles. Las vocales fuertes (o abiertas) son a, e, o; las vocales débiles (o cerradas) son i, u."]
       
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
        tvExplicacion.text = listaDeExplicacion[i]
    }

    @IBAction func seleccionIzquierda(_ sender: UIButton) {
        if i == 0 {
            i = listaDeReglas.count-1
        } else {
            i -= 1
        }
            lbSeleccionRegla.text = listaDeReglas[i]
            tvExplicacion.text = listaDeExplicacion[i]
    }
    
}
