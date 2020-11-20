//
//  ViewControllerVideoExplicatorio.swift
//  proyectoFinal
//
//  Created by Nina on 04/11/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class ViewControllerVideoExplicatorio: UIViewController {

    @IBOutlet weak var btnContinuarSEGA: UIButton!
    @IBOutlet weak var btnContinuarContexto: UIButton!
    @IBOutlet weak var btnContinuarHiato: UIButton!
    
    var seleccion = 0

    @IBAction func playVideoSelec(_ sender: UIButton) {
        var video:String
        if seleccion == 0{
            video = "SEGA"
        }else if seleccion == 1{
            video = "Contexto"
        }else{
           video = "Hiato"
        }
        guard let path = Bundle.main.path(forResource: video, ofType: "mp4")else{return}
        let videoURL = URL(fileURLWithPath: path)
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }

    }
    override var supportedInterfaceOrientations:  UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //si selecciona SEGA
        if seleccion == 0{
            btnContinuarContexto.isHidden = true
            btnContinuarHiato.isHidden = true
        }
        
        //si selecciona Contexto
        if seleccion == 1{
            btnContinuarSEGA.isHidden = true
            btnContinuarHiato.isHidden = true
        
        }
        
        //si selecciona Hiato
        if seleccion == 2{
            btnContinuarSEGA.isHidden = true
            btnContinuarContexto.isHidden = true
        
        }

        // Do any additional setup after loading the view.
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
