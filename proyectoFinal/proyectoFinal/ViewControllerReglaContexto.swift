//
//  ViewControllerReglaContexto.swift
//  proyectoFinal
//
//  Created by user178769 on 11/4/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewControllerReglaContexto: UIViewController {

    
    @IBOutlet weak var lbAciertos: UILabel!
    @IBOutlet weak var lbTimer: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    var numAciertosInt : Int!
    var numPregunta : Int!
    var counterSecs = 0
    var counterMinutes = 0
    var timer: Timer!
    var myButtonArray : [String] = []
    var index: Int!
    var tiempoTotal = 0
    
    // colores
    let colorFondo = UIColor(red:240/255, green: 244/255, blue: 245/255, alpha: 0)
    let colorTexto = UIColor(red: 35/255, green: 2/255, blue: 46/255, alpha: 1)
    let colorOrilla = UIColor(red: 166/255, green: 52/255, blue: 70/255, alpha: 1)
    @IBOutlet weak var tvContexto: UITextView!
    var arrayContexto = [PalabrasContexto(word: "ejercito", arrayPalabras: ["ejercito","ejército"], pos: 0, contexto: "En las mañana yo me _____."), PalabrasContexto(word: "Publico", arrayPalabras: ["público","publico","publicó"], pos: 0, contexto: "El ____ le aplaudió.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numPregunta = 0
        numAciertosInt = 0
        index = 0
        for index in arrayContexto[0].arrayPalabras{
            myButtonArray.append(index)
        }
        tvContexto.text = arrayContexto[0].contexto
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        createButtons()
        // Do any additional setup after loading the view.
    }
    
    @objc func updateCounter(){
        tiempoTotal += 1
        
        counterSecs = tiempoTotal % 60
        counterMinutes = tiempoTotal / 60

        print("\(counterMinutes):\(counterSecs)")
        
        lbTimer.text = String(format: "%d:%02d", counterMinutes, counterSecs)
    }
    
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
        numPregunta += 1
        if numPregunta <= 11{
            for button in buttonStack.arrangedSubviews{
                button.removeFromSuperview()
            }
            if sender.tag ==  arrayContexto[index].posicion{
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
        if(index < arrayContexto.count){
            myButtonArray.removeAll()
            
            for i in arrayContexto[index].arrayPalabras{
                myButtonArray.append(i)
            }
            tvContexto.text = arrayContexto[index].contexto
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
