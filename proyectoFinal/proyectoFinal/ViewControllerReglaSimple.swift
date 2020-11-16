//
//  ViewControllerReglaSimple.swift
//  proyectoFinal
//
//  Created by user178769 on 11/2/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit
import Foundation
//var de tiempo

class ViewControllerReglaSimple: UIViewController {
    
    //array de la clase de las palabras (mientras tanto tengo un array de puros strings para poder crear los botones)
    @IBOutlet weak var buttonStack : UIStackView!
    var myButtonArray : [String] = []
    var palSimple = [PalSimp]()
    var palAleatorios = [PalSimp]()
     //var de numero de aciertos
    @IBOutlet weak var lbTimer: UILabel!
    @IBOutlet weak var numAciertos: UILabel!
    var numAciertosInt : Int!
    var numPregunta : Int!
    var tiempoTotal = 0
    var counterSecs = 0
    var counterMinutes = 0
    var timer: Timer!
    var index: Int!
    
    var arrayPalabras = [PalabrasSimple(word: "Parro", arraySeparado: ["Pe", "rro"], pos: 0, acento: false), PalabrasSimple(word: "manzana", arraySeparado: ["man", "za", "na"], pos: 1, acento: false)]
    
    // colores
    let colorFondo = UIColor(red:240/255, green: 244/255, blue: 245/255, alpha: 0)
    let colorTexto = UIColor(red: 35/255, green: 2/255, blue: 46/255, alpha: 1)
    let colorOrilla = UIColor(red: 166/255, green: 52/255, blue: 70/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        functionRandomize()
        numAciertosInt = 0
        numPregunta = 0
        index = 0
    
        for index in palAleatorios[0].palabraDiv{
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

            //print("\(counterMinutes):\(counterSecs)")
            
            lbTimer.text = String(format: "%d:%02d", counterMinutes, counterSecs)
        }
    
    //funcion que crea los botones
    func createButtons(){
        for (index,element) in myButtonArray.enumerated(){
            let oneBtn: UIButton = {
                let button = UIButton()
                button.setTitle(element, for: .normal)
                button.backgroundColor = colorFondo
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.init(red: 166/255, green: 52/255, blue: 70/255, alpha: 1).cgColor
                button.setTitleColor(colorTexto, for: .normal)
                button.contentHorizontalAlignment = .center
                button.contentVerticalAlignment = .center
                button.titleLabel?.font = UIFont(name: "Arial", size: 30)
                button.layer.cornerRadius = 5
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                // button.addTarget(self, action: Selector(("holdRelease:")), for: UIControl.Event.touchUpInside);
                // button.addTarget(self, action: Selector(("HoldDown:")), for: UIControl.Event.touchDown)
                button.tag = index
                
                return button
            }()
            buttonStack.addArrangedSubview(oneBtn)
            
        }
        
    }
    
    //Aleatorio
    func functionRandomize(){
        var listIndices = Set<Int>()
        for i in 0...9{
            var number = Int.random(in: 0..<palSimple.count)
            while(listIndices.contains(number)){
                number = Int.random(in: 0..<palSimple.count)
            }
            listIndices.insert(number)
        }
        
        for i in listIndices{
            palAleatorios.append(palSimple[i])
        }
        
    }
    //carga el struct
    func loadJson(){
        if let fileLocation = Bundle.main.url(forResource: "palabrasGeneral", withExtension: "json")
        {
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([PalSimp].self,from: data)
                
                self.palSimple = dataFromJson
                
                
            }catch{
                print("error")
            }
        }
        else
        {
            print("error finding file")
        }
        
    }
    
    //funcion al darle click un boton
    
    func doStuff(opcion: Bool,sender: UIButton)
    {
            print("Button tapped \(sender.tag)")
            numPregunta = numPregunta + 1
            if numPregunta <= 10{
                //hacer segue
                for button in buttonStack.arrangedSubviews{
                    button.removeFromSuperview()
                }
                var estado = false
                if palAleatorios[index].Tilde == "1"{
                    estado = true
                }
                if sender.tag ==  palAleatorios[index].Pos && opcion == estado{
                    
                    numAciertosInt = numAciertosInt + 1
                    numAciertos.text = "\(numAciertosInt!)/10"
                }
                cambiaPalabra()
                
            }
            
            else{
                //llamar al segue todo
                //parar el timer
                timer?.invalidate()
                timer = nil
                print("aaaaaaaa")
            }

    }
    
    @IBAction func buttonAction(sender: UIButton){
        
        let alert = UIAlertController(title: "Lleva tilde la silaba", message: "¿Lleva tilde la silaba?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction (title: "Sí", style: .default, handler:{
            action in self.doStuff(opcion: true, sender: sender)
        }))
                                        
        alert.addAction(UIAlertAction (title: "No", style: .default, handler:{
            action in self.doStuff(opcion: false, sender: sender)
        }))
        self.present(alert,animated: true)
    }
    
    
    func cambiaPalabra(){
        index = index + 1
        if(index < palAleatorios.count){
            myButtonArray.removeAll()
            
            for i in palAleatorios[index].palabraDiv{
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
struct PalSimp: Codable
{
    var Palabra: String
    var palabraDiv : [String]
    var Tilde: String
    var Pos: Int
}
