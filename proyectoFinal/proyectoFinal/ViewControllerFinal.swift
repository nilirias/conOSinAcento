//
//  ViewControllerFinal.swift
//  proyectoFinal
//
//  Created by user178769 on 11/16/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit

class ViewControllerFinal: UIViewController {

    var aciertosNum = 0
    //var tiempo: Timer!
    var puntaje = 0
    var counterSecs = 0
    var counterMinutes = 0
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var lbPuntaje: UILabel!
    @IBOutlet weak var lbAciertos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbAciertos.text = "\(aciertosNum)/10"
        lbTiempo.text = String(format: "%d:%02d", counterMinutes, counterSecs)
        puntaje = aciertosNum * 100
        lbPuntaje.text = "\(puntaje)"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func RegresarButton(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   

    @IBAction func regresarButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
}
