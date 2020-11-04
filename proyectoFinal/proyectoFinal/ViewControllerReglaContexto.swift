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
    
    @IBOutlet weak var tvContexto: UITextView!
    var arrayContexto = [PalabrasContexto(word: "ejercito", arrayPalabras: ["ejercito","ejeercito"], pos: 0, contexto: "En las maana yo me _____"), PalabrasContexto(word: "Publico", arrayPalabras: ["publico","publiico","publicoo"], pos: 0, contexto: "El ____ le aplaudio")]
    
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
        if counterSecs == 60{
            counterSecs = 0
            counterMinutes += 1
        }
        counterSecs += 1
        lbTimer.text = "\(String(counterMinutes)): \(String(counterSecs))"
        print("\(counterMinutes):\(counterSecs)")
        
    }
    
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
