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
    var path = "Game"
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var lbPuntaje: UILabel!
    @IBOutlet weak var lbAciertos: UILabel!
    var game = [Game]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lbAciertos.text = "\(aciertosNum)/10"
        lbTiempo.text = String(format: "%d:%02d", counterMinutes, counterSecs)
        puntaje = aciertosNum * ((Int(counterMinutes)*60) + Int(counterSecs))
        lbPuntaje.text = "\(puntaje)"
        // Do any additional setup after loading the view.
        loadJson()
        saveInJson()
        loadJson()
    }
    
    func loadJson()
    {
        if let fileLocation = Bundle.main.url(forResource: path, withExtension: "json")
        {
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Game].self,from: data)
                
                self.game = dataFromJson
                
                print(game)
            }catch{
                print("error")
            }
        }
        else
        {
            print("error finding file")
        }
        
        
        
    }
    
    func saveInJson()
    {
        
        game.append(Game(date: "215",score: lbPuntaje.text! ,aciertos: lbAciertos.text!,time: lbTiempo.text!))
                
        do{
            let jsonData = try JSONEncoder().encode(game)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
                
                let pathWithFilename = documentDirectory.appendingPathComponent("\(path).json")
            
                    try jsonString.write(to: pathWithFilename,
                                         atomically: true,
                                         encoding: .utf8)
                
            }
        }
        catch {
            print("Error: \(error)")
            }
        
    
        
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

struct Game: Codable
{
    var date : String
    var score : String
    var aciertos : String
    var time : String
}

