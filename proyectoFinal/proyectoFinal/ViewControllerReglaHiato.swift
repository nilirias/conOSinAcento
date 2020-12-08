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
    var arrP = [PalHiato]()
    var palAleatorios = [PalHiato]()
    var arrayPalabras = [PalabrasHiato(word: "sandia", arraySeparado: ["s","a","n","d","i","a"], pos: 4, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "ciudadania", arraySeparado: ["c","i","u","d","a","d","a","n","i","a"], pos: 8, acento: true, cantSilabas: 5),
                         PalabrasHiato(word: "Chihuahua", arraySeparado: ["C","h","i","h","u","a","h","u","a"], pos: 1, acento: false, cantSilabas: 3),
                         PalabrasHiato(word: "Maria", arraySeparado: ["M","a","r","i","a"], pos: 3, acento: true, cantSilabas: 3),
                         PalabrasHiato(word: "hielo", arraySeparado: ["H","i","e","l","o"], pos: 0, acento: false, cantSilabas: 2),
                          PalabrasHiato(word: "sonrio", arraySeparado: ["S","o","n","r","i","o"], pos: 4, acento: true, cantSilabas: 3),
                          PalabrasHiato(word: "bambues", arraySeparado: ["b","a","m","b","u","e","s"], pos: 4, acento: true, cantSilabas: 3),
                          PalabrasHiato(word: "pais", arraySeparado: ["p","a","i","s"], pos: 2, acento: true, cantSilabas: 2),
                          PalabrasHiato(word: "oimos", arraySeparado: ["o","i","m","o","s"], pos: 1, acento: true, cantSilabas: 3),
                          PalabrasHiato(word: "eucalipto", arraySeparado: ["e","u","c","a","l","i","p","t","o"], pos: 0, acento: false, cantSilabas: 4)
                         
    ]
    var numAciertosInt : Int!
    var numPregunta : Int!
    var tiempoTotal = 0
    var counterSecs = 0
    var counterMinutes = 0
    var timer: Timer!
    var index: Int!
    var estadoGlobal : Bool!
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
        loadJson()
        functionRandomize()
        numAciertosInt = 0
        numPregunta = 0
        index = 0
        for index in palAleatorios[0].palabraDiv{
            myButtonArray.append(index)
        }
        lbAciertos.text = "0/10"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        createButtons()
        
        
        estadoGlobal = showAlertSilabas(i: indeicePalabras)
        if(estadoGlobal)
        {
            alertasList[0].dismiss(animated: true) {
                print("salio el dismiss")
            }
            print("es correcto")
            
            
        }
       
        
        
        //llamar funcion que crea los botones
    }
    func functionRandomize(){
        var listIndices = Set<Int>()
        for i in 0...9{
            var number = Int.random(in: 0..<arrP.count)
            while(listIndices.contains(number)){
                number = Int.random(in: 0..<arrP.count)
            }
            listIndices.insert(number)
        }
        
        for i in listIndices{
            palAleatorios.append(arrP[i])
        }
        
    }
    func loadJson(){
        if let fileLocation = Bundle.main.url(forResource: "palabrasHiato", withExtension: "json")
        {
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([PalHiato].self,from: data)
                //print(dataFromJson)
                self.arrP = dataFromJson
                
                
            }catch{
                print(error)
            }
        }
        else
        {
            print("error finding file")
        }
        
    }
    
    override var supportedInterfaceOrientations:  UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool{
        return false
    }
    
    func showAlertAcento(i: Int, estado: Bool) ->Bool
    {
        var correcto = true
        let alert = UIAlertController(title: "Lleva tilde la silaba", message: "¿Lleva tilde la silaba?", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Sí", style: .default, handler:{_ in
            
            if(self.palAleatorios[i].posTilde == "0"){
                correcto = false
                
            }
        }))
                                        
        alert.addAction(UIAlertAction (title: "No", style: .default, handler:{ [self]_ in
            if(self.palAleatorios[i].posTilde == "1"){
                correcto = false
            }
            for button in self.buttonStack.arrangedSubviews{
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
            title: "Cantidad de silabas", message: "Cuantas silabas tiene la palabra \(palAleatorios[i].Palabra)", preferredStyle: .alert
        )
        alertasList.append(alertController)

        let actionSilabas = UIAlertAction(title: "Cantidad de silabas", style:.default)
        { [self] (action) -> Void in
            if let  numero = Int((numerotextfield?.text)!)
            {
                if(numero != self.palAleatorios[i].posSilaba)
                {
                    correcto = false
                }
                var estadoDeAcento = self.showAlertAcento(i: i, estado: correcto)
                
                if(estadoDeAcento && correcto)
                {
                    estadoGlobal = true
                    
                }
                else
                {
                    estadoGlobal = false
                }
            }
            else
            {
                print("No number entered")
                correcto = false
                if(!self.showAlertAcento(i: i, estado: correcto))
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
            print("estadoGlobal: \(estadoGlobal)")
            if sender.tag ==  palAleatorios[index].posLetra && estadoGlobal{
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
            if(index < palAleatorios.count){
            myButtonArray.removeAll()
            
            for i in palAleatorios[index].palabraDiv{
                myButtonArray.append(i)
            }
            createButtons()
        }
        estadoGlobal = showAlertSilabas(i: index)
        if(estadoGlobal)
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
            finalScene.tipo = 3
            finalScene.aciertosNum = numAciertosInt
            finalScene.counterSecs = counterSecs
            finalScene.counterMinutes = counterMinutes
        }
    }

}
struct PalHiato: Codable
{
    var Palabra: String
    var palabraDiv : [String]
    var posSilaba: Int
    var posTilde: String
    var posLetra: Int
}

