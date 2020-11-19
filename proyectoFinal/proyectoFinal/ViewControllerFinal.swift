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
    var pathFinal = "Game"
    var tipo = 0
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
        
        if(tipo == 1)
        {
            pathFinal = pathFinal + "Simple.json"
            
        }
        else if(tipo == 2)
        {
            pathFinal = pathFinal + "Contexto.json"

        }
        else if(tipo == 3)
        {
            pathFinal = pathFinal + "Hiato.json"

        }
        else
        {
            print("sin ruta")
        }
        loadJson()
        saveInJson()
        loadJson()

    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
    func loadJson()
    {
       // if let fileLocation = Bundle.main.url(forResource: path, withExtension: "json")
        let path = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(pathFinal)
        //print((path?.path)!)
        
        if(!FileManager.default.fileExists(atPath: (path?.path)!))
        {
            FileManager.default.createFile(atPath: (path?.path)!, contents: nil, attributes: nil)
        }
        
            do{
                let data = try Data(contentsOf: path!)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Game].self,from: data)
                
                self.game = dataFromJson
                
                print(game)
            }catch{
                print("file not exist")
            }
        
        
        
        
        
    }
    
    func saveInJson()
    {
        
        game.append(Game(date: "215",score: lbPuntaje.text! ,aciertos: lbAciertos.text!,time: lbTiempo.text!))

        //encode data
        let encoder = JSONEncoder()
        let jsonEncodeData =  try! encoder.encode(game)
        
        var jsonString = String(data: jsonEncodeData, encoding: .utf8)
        

        let path = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(pathFinal)
        
        let data = Data(jsonString!.utf8)
        do
        {
            try data.write(to: path!,options: .atomic)
            try print(String(contentsOf: path!))
            
        }
        catch
        {
            print("error")
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

