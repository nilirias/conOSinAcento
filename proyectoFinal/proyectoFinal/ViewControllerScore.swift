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
    var scoreArr = [score]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scoreArr = [score(Fecha: "12/12/12", Tiempo: "0:30", Puntaje: "20", Aciertos: "1/10"),score(Fecha: "12/12/12", Tiempo: "0:50", Puntaje: "150", Aciertos: "1/10"),score(Fecha: "12/12/12", Tiempo: "0:30", Puntaje: "400", Aciertos: "8/10"),score(Fecha: "12/12/12", Tiempo: "0:40", Puntaje: "20", Aciertos: "5/10")]
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! customTableViewCell
        celda.lbfecha.text = scoreArr[indexPath.row].Fecha
        celda.lbtiempo.text = scoreArr[indexPath.row].Tiempo
        celda.lbpuntaje.text = scoreArr[indexPath.row].Puntaje
        celda.lbaciertos.text = scoreArr[indexPath.row].Aciertos
        return celda
    }

}
struct score: Codable
{
    var Fecha: String
    var Tiempo : String
    var Puntaje: String
    var Aciertos: String
}
