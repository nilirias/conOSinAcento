//
//  PalabrasContexto.swift
//  proyectoFinal
//
//  Created by user178769 on 11/4/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class PalabrasContexto: NSObject {
    
    var word: String
    var arrayPalabras: [String]
    var posicion: Int
    var contexto:String
    
    init(word: String, arrayPalabras:[String], pos:Int, contexto: String){
        self.word = word
        self.arrayPalabras = arrayPalabras
        self.posicion = pos
        self.contexto = contexto
    }
}
