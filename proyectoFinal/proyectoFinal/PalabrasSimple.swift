//
//  PalabrasSimple.swift
//  proyectoFinal
//
//  Created by user178769 on 11/3/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class PalabrasSimple: NSObject {
   
    var word: String
    var arraySeparado: [String]
    var posicion: Int
    var acento: Bool
    init(word: String, arraySeparado:[String], pos:Int, acento: Bool){
        self.word = word
        self.arraySeparado = arraySeparado
        self.posicion = pos
        self.acento = acento
    }
}
