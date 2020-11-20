//
//  ViewControllerScore.swift
//  proyectoFinal
//
//  Created by user178769 on 11/18/20.
//  Copyright © 2020 Nina. All rights reserved.
//

import UIKit
class customTableViewCell: UITableViewCell{
    
    @IBOutlet weak var lbfecha: UILabel!
    @IBOutlet weak var lbtiempo: UILabel!
    @IBOutlet weak var lbpuntaje: UILabel!
    @IBOutlet weak var lbaciertos: UILabel!
}
class ViewControllerScore: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var scoresimple = [scoreSimple]()
    var scorecontexto = [scoreContexto]()
    var scorehiatos = [scoreHiatos]()
    var i = 0
    var pathFinal = "Game"
    var tipo = 0
    let listaDeReglas = ["Regla general", "Palabras en contexto", "Hiatos y diptongos"]
    var pathSimple = "GameSimple.json"
    var pathContexto = "GameContexto.json"
    var pathHiatos = "GameHiato.json"
    @IBOutlet weak var tbScores: UITableView!
    @IBOutlet weak var lbSeleccionRegla: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonSimple()
        loadJsonHiato()
        loadJsonContexto()
        // Do any additional setup after loading the view.
    }
    
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override var supportedInterfaceOrientations:  UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool{
        return false
    }
    
    func loadJsonSimple()
        {
           // if let fileLocation = Bundle.main.url(forResource: path, withExtension: "json")
            let path = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(pathSimple)
            //print((path?.path)!)
            
            if(!FileManager.default.fileExists(atPath: (path?.path)!))
            {
                FileManager.default.createFile(atPath: (path?.path)!, contents: nil, attributes: nil)
            }
            
                do{
                    let data = try Data(contentsOf: path!)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([scoreSimple].self,from: data)
                    
                    self.scoresimple = dataFromJson
                    
                    //print(scoresimple)
                }catch{
                    print("file not exist")
                }
            //tbScores.reloadData()
        }
        func loadJsonContexto()
        {
           // if let fileLocation = Bundle.main.url(forResource: path, withExtension: "json")
            let path = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(pathContexto)
            //print((path?.path)!)
            
            if(!FileManager.default.fileExists(atPath: (path?.path)!))
            {
                FileManager.default.createFile(atPath: (path?.path)!, contents: nil, attributes: nil)
            }
            
                do{
                    let data = try Data(contentsOf: path!)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([scoreContexto].self,from: data)
                    
                    self.scorecontexto = dataFromJson
                    
                    //print(scorecontexto)
                }catch{
                    print("file not exist")
                }
            //tbScores.reloadData()
        }
    func loadJsonHiato()
    {
       // if let fileLocation = Bundle.main.url(forResource: path, withExtension: "json")
        let path = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(pathHiatos)
        //print((path?.path)!)
        
        if(!FileManager.default.fileExists(atPath: (path?.path)!))
        {
            FileManager.default.createFile(atPath: (path?.path)!, contents: nil, attributes: nil)
        }
        
            do{
                let data = try Data(contentsOf: path!)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([scoreHiatos].self,from: data)
                
                self.scorehiatos = dataFromJson
                
                //print(scorehiatos)
            }catch{
                print("file not exist")
            }
        //tbScores.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - table view functions
    
    @IBAction func seleccionDerecha(_ sender: UIButton) {
        if i == listaDeReglas.count-1 {
            i = 0
        } else {
            i += 1
        }
        lbSeleccionRegla.text = listaDeReglas[i]
        tbScores.reloadData()
    }
    
    @IBAction func seleccionIzquierda(_ sender: UIButton) {
        if i == 0 {
            i = listaDeReglas.count-1
        } else {
            i -= 1
        }
        lbSeleccionRegla.text = listaDeReglas[i]
        tbScores.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if i == 0{
           return scoresimple.count
        }else if i == 1{
            return scorecontexto.count
        }else{
            return scorehiatos.count
        }
         //scoreArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! customTableViewCell
        if i == 0 && scoresimple.count > 0{
            celda.lbfecha.text = scoresimple[indexPath.row].date
            celda.lbtiempo.text = scoresimple[indexPath.row].time
            celda.lbpuntaje.text = scoresimple[indexPath.row].score
            celda.lbaciertos.text = scoresimple[indexPath.row].aciertos
        }else if i == 1 && scorecontexto.count > 0{
            celda.lbfecha.text = scorecontexto[indexPath.row].date
            celda.lbtiempo.text = scorecontexto[indexPath.row].time
            celda.lbpuntaje.text = scorecontexto[indexPath.row].score
            celda.lbaciertos.text = scorecontexto[indexPath.row].aciertos
        }else if i == 2 && scorehiatos.count > 0{
            celda.lbfecha.text = scorehiatos[indexPath.row].date
            celda.lbtiempo.text = scorehiatos[indexPath.row].time
            celda.lbpuntaje.text = scorehiatos[indexPath.row].score
            celda.lbaciertos.text = scorehiatos[indexPath.row].aciertos
        }else{
            celda.lbfecha.text = ""
            celda.lbtiempo.text = ""
            celda.lbpuntaje.text = ""
            celda.lbaciertos.text = ""
        }
        return celda
            
    }

}
struct scoreSimple: Codable
{
    var date: String
    var score : String
    var aciertos: String
    var time: String
}
struct scoreContexto: Codable
{
    var date: String
    var score : String
    var aciertos: String
    var time: String
}
struct scoreHiatos: Codable
{
    var date: String
    var score : String
    var aciertos: String
    var time: String
}

