//
//  ViewControllerReglaHiato.swift
//  proyectoFinal
//
//  Created by user179423 on 11/4/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewControllerReglaHiato: UIViewController {

    var myButtonArray : [String] = []
    @IBOutlet weak var buttonStack: UIStackView!
    var arrayPalabras = [PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, contexto: "nill")]
    var numAciertosInt : Int!
    var numPregunta : Int!
    var tiempoTotal = 0
    var counterSecs = 0
    var counterMinutes = 0
    var timer: Timer!
    var index: Int!
    
    @IBOutlet weak var lbAciertos: UILabel!
    @IBOutlet weak var lbTimer: UILabel!
    
    // colores
    let colorFondo = UIColor(red:189/255, green: 213/255, blue: 235/255, alpha: 0)
    let colorTexto = UIColor(red: 73/255, green: 88/255, blue: 103/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numAciertosInt = 0
        numPregunta = 0
        index = 0
        for index in arrayPalabras[0].arraySeparado{
            myButtonArray.append(index)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        createButtons()
        //llamar funcion que crea los botones
    }
    

    @objc func updateCounter(){
        tiempoTotal += 1
        
        counterSecs = tiempoTotal % 60
        counterMinutes = tiempoTotal / 60

        print("\(counterMinutes):\(counterSecs)")
        
        lbTimer.text = String(format: "%d:%02d", counterMinutes, counterSecs)
    }
    
    //funcion que crea los botones
    func createButtons(){
        for (index,element) in myButtonArray.enumerated(){
            let oneBtn: UIButton = {
                let button = UIButton()
                button.setTitle(element, for: .normal)
                button.backgroundColor = colorFondo
                button.layer.borderWidth = 0
                button.setTitleColor(colorTexto, for: .normal)
                button.contentHorizontalAlignment = .center
                button.contentVerticalAlignment = .center
                button.titleLabel?.font = UIFont(name: "Arial", size: 40)
                button.layer.cornerRadius = 5
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                button.tag = index
                
                return button
            }()
            buttonStack.addArrangedSubview(oneBtn)
            
        }
    }
    @IBAction func buttonAction(sender: UIButton){
        numPregunta += 1
        if numPregunta <= 11{
            for button in buttonStack.arrangedSubviews{
                button.removeFromSuperview()
            }
            if sender.tag ==  arrayPalabras[index].posicion{
                numAciertosInt = numAciertosInt + 1
                lbAciertos.text = "\(numAciertosInt!)/10"
            }
            //esto va a ser una funcion
            cambiaPalabra()
        }else{
            timer?.invalidate()
            timer = nil
            print("aaaaaaaa")
        }
    }
    
    func cambiaPalabra(){
        index = index + 1
        if(index < arrayPalabras.count){
            myButtonArray.removeAll()
            
            for i in arrayPalabras[index].arraySeparado{
                myButtonArray.append(i)
            }
            createButtons()
        }
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
