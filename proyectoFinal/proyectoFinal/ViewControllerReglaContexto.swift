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
    var palCont = [PalCont]()
    var palAleatorios = [PalCont]()
    override var supportedInterfaceOrientations:  UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool{
        return false
    }
    // colores
    let colorFondo = UIColor(red:240/255, green: 244/255, blue: 245/255, alpha: 0)
    let colorTexto = UIColor(red: 35/255, green: 2/255, blue: 46/255, alpha: 1)
    let colorOrilla = UIColor(red: 166/255, green: 52/255, blue: 70/255, alpha: 1)
    @IBOutlet weak var tvContexto: UITextView!
    //var arrayContexto = [PalabrasContexto(word: "ejercito", arrayPalabras: ["ejercito","ejército"], pos: 0, contexto: "En las mañana yo me _____."), PalabrasContexto(word: "Publico", arrayPalabras: ["público","publico","publicó"], pos: 0, contexto: "El ____ le aplaudió.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        functionRandomize()
        numPregunta = 0
        numAciertosInt = 0
        index = 0
        for index in palAleatorios[0].opciones{
            myButtonArray.append(index)
        }
        tvContexto.text = palAleatorios[0].contexto
        tvContexto.sizeToFit()
        tvContexto.layoutIfNeeded()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        createButtons()
        // Do any additional setup after loading the view.
    }
    
    @objc func updateCounter(){
        tiempoTotal += 1
        
        counterSecs = tiempoTotal % 60
        counterMinutes = tiempoTotal / 60

        //print("\(counterMinutes):\(counterSecs)")
        
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
            print(myButtonArray)
            
        }
    }
    
    func functionRandomize(){
        var listIndices = Set<Int>()
        for i in 0...9{
            var number = Int.random(in: 0..<palCont.count)
            while(listIndices.contains(number)){
                number = Int.random(in: 0..<palCont.count)
            }
            listIndices.insert(number)
        }
        
        for i in listIndices{
            palAleatorios.append(palCont[i])
        }
        
    }
    //carga el struct
    func loadJson(){
        if let fileLocation = Bundle.main.url(forResource: "palabrasContexto", withExtension: "json")
        {
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([PalCont].self,from: data)
                //print(dataFromJson)
                self.palCont = dataFromJson
                
                
            }catch{
                print(error)
            }
        }
        else
        {
            print("error finding file")
        }
        
    }
    
    @IBAction func buttonAction(sender: UIButton){
        numPregunta += 1
        if numPregunta < 10{
            for button in buttonStack.arrangedSubviews{
                button.removeFromSuperview()
            }
            if sender.tag ==  palAleatorios[index].pos{
               
                numAciertosInt = numAciertosInt + 1
                lbAciertos.text = "\(numAciertosInt!)/10"
            }
            //esto va a ser una funcion
            cambiaPalabra()
        }else{
            timer?.invalidate()
            timer = nil
            if sender.tag ==  palAleatorios[index].pos{
               
                numAciertosInt = numAciertosInt + 1
                lbAciertos.text = "\(numAciertosInt!)/10"
            }
            //print("aaaaaaaa")
            self.performSegue(withIdentifier: "final", sender: sender)
        }
    }
    
    func cambiaPalabra(){
        index = index + 1
        if(index < palAleatorios.count){
            myButtonArray.removeAll()
            
            for i in palAleatorios[index].opciones{
                myButtonArray.append(i)
            }
            tvContexto.text = palAleatorios[index].contexto
            tvContexto.sizeToFit()
            tvContexto.layoutIfNeeded()
            createButtons()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "final"{
            let finalScene = segue.destination as! ViewControllerFinal
            finalScene.tipo = 2
            finalScene.aciertosNum = numAciertosInt
            finalScene.counterSecs = counterSecs
            finalScene.counterMinutes = counterMinutes
        }
    }
    

}

struct PalCont: Codable
{
    var Palabra: String
    var opciones : [String]    
    var pos: Int
    var contexto: String
}
