//
//  PalabrasHiato.swift
//  proyectoFinal
//
//  Created by user179423 on 11/4/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class PalabrasHiato: NSObject {
    
    var word: String
    var arraySeparado: [String]
    var posicion: Int //posicion del hiato
    var acento: Bool
    var contexto:String
    
    init(word: String, arraySeparado:[String], pos:Int, acento: Bool, contexto: String){
        self.word = word
        self.arraySeparado = arraySeparado
        self.posicion = pos
        self.acento = acento
        self.contexto = contexto
    }


}
