//
//  ViewControllerExplicacionVideo.swift
//  proyectoFinal
//
//  Created by user178769 on 11/18/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class ViewControllerExplicacionVideo: UIViewController {

    @IBOutlet weak var lbRegla: UILabel!
    @IBOutlet weak var videoExplicativo: UIImageView!
    let listaDeReglas = ["Regla general", "Palabras en contexto", "Hiatos y diptongos"]
    let listaVideos = ["SEGA", "Contexto", "Hiato"]
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func payVideoSele(_ sender: UIButton) {
        var video:String
        if i == 0{
            video = "SEGA"
        }else if i == 1{
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
    @IBAction func seleccionarDerecha(_ sender: UIButton) {
        if i == listaDeReglas.count-1 {
            i = 0
        } else {
            i += 1
        }
        lbRegla.text = listaDeReglas[i]
        //tvExplicacion.text = listaDeExplicacion[i]
    }
    
    @IBAction func seleccionarizquierda(_ sender: UIButton) {
        if i == 0 {
            i = listaDeReglas.count-1
        } else {
            i -= 1
        }
            lbRegla.text = listaDeReglas[i]
            //tvExplicacion.text = listaDeExplicacion[i]
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
