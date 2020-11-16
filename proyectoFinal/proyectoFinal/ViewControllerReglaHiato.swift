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
    var arrayPalabras = [PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Ciudadania", arraySeparado: ["C","i","u","d","a","d","a","n","i","a"], pos: 8, acento: true, cantSilabas: 5),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "Sandia", arraySeparado: ["S","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3)
                         
    ]
    var numAciertosInt : Int!
    var numPregunta : Int!
    var tiempoTotal = 0
    var counterSecs = 0
    var counterMinutes = 0
    var timer: Timer!
    var index: Int!
    var indeicePalabras = 0
    @IBOutlet weak var lbAciertos: UILabel!
    @IBOutlet weak var lbTimer: UILabel!
    
    // colores
    let colorFondo = UIColor(red:240/255, green: 244/255, blue: 245/255, alpha: 0)
    let colorTexto = UIColor(red: 35/255, green: 2/255, blue: 46/255, alpha: 1)
    let colorOrilla = UIColor(red: 166/255, green: 52/255, blue: 70/255, alpha: 1)
    var alertasList = [UIAlertController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        numAciertosInt = 0
        numPregunta = 0
        index = 0
        for index in arrayPalabras[0].arraySeparado{
            myButtonArray.append(index)
        }
        lbAciertos.text = "0/10"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        createButtons()
        
        
        
        if(showAlertSilabas(i: indeicePalabras))
        {
            alertasList[0].dismiss(animated: true) {
                print("salio el dismiss")
            }
            print("es correcto")
            
            
        }
       
        
        
        //llamar funcion que crea los botones
    }
    
    
    
    func showAlertAcento(i: Int) ->Bool
    {
        var correcto = true
        let alert = UIAlertController(title: "Lleva tilde la silaba", message: "¿Lleva tilde la silaba?", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Sí", style: .default, handler:{_ in
            
        }))
                                        
        alert.addAction(UIAlertAction (title: "No", style: .default, handler:{ [self]_ in
            if(arrayPalabras[i].acento){
                correcto = false
                
            }
            else
            {
                numAciertosInt = numAciertosInt + 1
                lbAciertos.text = "\(numAciertosInt!)/10"
            }
            for button in buttonStack.arrangedSubviews{
                button.removeFromSuperview()
            }
            self.cambiaPalabra()
        }))
        present(alert,animated: true)
        
        return correcto
    }
    func showAlertSilabas(i: Int) -> Bool{
        var numerotextfield : UITextField?
        var correcto = true
        let alertController = UIAlertController(
            title: "Cantidad de silabas", message: "Cuantas silabas tiene la palabra\(arrayPalabras[i].word)", preferredStyle: .alert
        )
        alertasList.append(alertController)

        let actionSilabas = UIAlertAction(title: "Cantidad de silabas", style:.default)
        { [self] (action) -> Void in
            if let  numero = Int((numerotextfield?.text)!)
            {
                print(" numero = \(numero)")
                if(numero != self.arrayPalabras[i].cantSilabas)
                {
                    correcto = false
                }
                if(!self.showAlertAcento(i: i))
                {
                    correcto = false
                    print("es correcto")
                }
                
            }
            else
            {
                print("No number entered")
                correcto = false
                if(!self.showAlertAcento(i: i))
                {
                    correcto = false

                    print("es correcto")
                }
            }
            
        }
        
        
        alertController.addTextField {
               (txtNumero) -> Void in
            numerotextfield = txtNumero
            numerotextfield!.placeholder = "<Your number here>"
           }
        alertController.addAction(actionSilabas)
        present(alertController, animated: true, completion: nil)

        
        return correcto
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
        if numPregunta < 10{
            for button in buttonStack.arrangedSubviews{
                button.removeFromSuperview()
            }
            if sender.tag ==  arrayPalabras[index].posicion{
                numAciertosInt = numAciertosInt + 1
                lbAciertos.text = "\(numAciertosInt!)/10"
            }
            //esto va a ser una funcion
            cambiaPalabra()
        }
        
    }
    
    
    func cambiaPalabra(){
        index = index + 1
        numPregunta = numPregunta + 1
        if numPregunta < 10{
            if(index < arrayPalabras.count){
            myButtonArray.removeAll()
            
            for i in arrayPalabras[index].arraySeparado{
                myButtonArray.append(i)
            }
            createButtons()
        }
            
        if(showAlertSilabas(i: index))
        {
            alertasList[0].dismiss(animated: true) {
                print("salio el dismiss")
            }
            print("es correcto")
            
            
        }
        }else{
            timer?.invalidate()
            timer = nil
            self.performSegue(withIdentifier: "final", sender: self)

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "final"{
            let finalScene = segue.destination as! ViewControllerFinal
            finalScene.aciertosNum = numAciertosInt
            finalScene.counterSecs = counterSecs
            finalScene.counterMinutes = counterMinutes
        }
    }

}
