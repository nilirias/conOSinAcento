//
//  ViewControllerReglaSimple.swift
//  proyectoFinal
//
//  Created by user178769 on 11/2/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit
//var de tiempo

class ViewControllerReglaSimple: UIViewController {
    
    //array de la clase de las palabras (mientras tanto tengo un array de puros strings para poder crear los botones)
    @IBOutlet weak var buttonStack : UIStackView!
    var myButtonArray : [String] = []
    //var de numero de aciertos
    @IBOutlet weak var lbTimer: UILabel!
    @IBOutlet weak var numAciertos: UILabel!
    var numAciertosInt : Int!
    var numPregunta : Int!
    var counterSecs = 0
    var counterMinutes = 0
    var timer: Timer!
    var index: Int!
    
    var arrayPalabras = [PalabrasSimple(word: "Parro", arraySeparado: ["Pe", "rro"], pos: 0, acento: false, contexto: "nil"), PalabrasSimple(word: "manzana", arraySeparado: ["man", "za", "na"], pos: 1, acento: false, contexto: "nil")]
    
    
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
        if counterSecs == 60{
            counterSecs = 0
            counterMinutes += 1
        }
        counterSecs += 1
        lbTimer.text = "\(String(counterMinutes)): \(String(counterSecs))"
        print("\(counterMinutes):\(counterSecs)")
        
    }
    //funcion que crea los botones
    func createButtons(){
        for (index,element) in myButtonArray.enumerated(){
            let oneBtn: UIButton = {
                let button = UIButton()
                button.setTitle(element, for: .normal)
                button.backgroundColor = UIColor.gray
                button.layer.borderColor = UIColor.black.cgColor
                button.setTitleColor(UIColor.black, for: .normal)
                button.contentHorizontalAlignment = .center
                button.contentVerticalAlignment = .center
                button.titleLabel?.font = UIFont(name: "Arial", size: 12)
                button.layer.cornerRadius = 5
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                button.tag = index
                
                return button
            }()
            buttonStack.addArrangedSubview(oneBtn)
            
        }
    }
    
    //funcion al darle click un boton
    @IBAction func buttonAction(sender: UIButton){
        print("Button tapped \(sender.tag)")
        numPregunta = numPregunta + 1
        if numPregunta <= 10{
            //hacer segue
            for button in buttonStack.arrangedSubviews{
                button.removeFromSuperview()
            }
            if sender.tag ==  arrayPalabras[0].posicion{
                numAciertosInt = numAciertosInt + 1
                numAciertos.text = "\(numAciertosInt!)/10"
            }
            cambiaPalabra()
            
        }else{
            //llamar al segue todo
            //parar el timer
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
