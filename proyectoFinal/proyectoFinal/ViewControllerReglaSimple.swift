//
//  ViewControllerReglaSimple.swift
//  proyectoFinal
//
//  Created by user178769 on 11/2/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewControllerReglaSimple: UIViewController {
    
    //array de la clase de las palabras (mientras tanto tengo un array de puros strings para poder crear los botones)
    @IBOutlet weak var buttonStack : UIStackView!
    var myButtonArray : [String] = []
    //var de numero de aciertos
    @IBOutlet weak var numAciertos: UILabel!
    var num : Int!
    
    //var de tiempo
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //llenar el array
        num = 0
        for index in 0...5{
            myButtonArray.append("Button \(index)")
        }
        createButtons()
        //llamar funcion que crea los botones
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
        //logica de acertado o no
        
        //randomizar el array de nuevo
        
        //borrar botones actuales del stack view y volver a crear con el nuevo array
        
        //todo dentro de un if que cheque en que numero de cosa vamos
        numAciertos.text = "\(num + 1)/10"
    }
    
    //funcion para reload los botones con algo random
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
