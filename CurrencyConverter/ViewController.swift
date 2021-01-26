//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Asit Aslan on 26.01.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLBl: UILabel!
    @IBOutlet weak var usdLbl: UILabel!
    @IBOutlet weak var cadLbl: UILabel!
    @IBOutlet weak var audLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRateClicked(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=6db77d4e991de3d348a0138c41cf672d&format=1")
        
        let sesion = URLSession.shared
        
        let task = sesion.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                
                if data != nil{
                    do{
                        
                        let jsonResponse = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLbl.text = "CAD : \(cad)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                        self.tryLBl.text = "TRY: \(tr)"
                                }
                                if let usd = rates["USD"] as? Double {
                                        self.usdLbl.text = "USD : \(usd)"
                                }
                                if let aud = rates["AUD"] as? Double {
                                       self.audLbl.text = "AUD : \(aud)"
                                }
                             
                            }
                                                    
                        }
                        
                        
                    } catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
        
        
        
    }
    
}

