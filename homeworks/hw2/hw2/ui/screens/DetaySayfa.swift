//
//  DetaySayfa.swift
//  hw2
//
//  Created by Duru Aydoğdu on 17.04.2025.
//

import UIKit

class DetaySayfa: UIViewController {

    @IBOutlet weak var tfGorevAd: UITextField!
    
    var gorev:Gorevler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tempGorev = gorev {
            tfGorevAd.text = tempGorev.gorev_ad
        }
    }
    
    @IBAction func buttonGuncelle(_ sender: Any) {
        if let ad = tfGorevAd.text, let guncellenecekGorev = gorev {
                guncelle(gorev_id: guncellenecekGorev.gorev_id!, gorev_ad: ad)
            }
    }
    
    func guncelle(gorev_id:Int, gorev_ad:String){
        print("Görev Güncelle : \(gorev_id) - \(gorev_ad)")
        
    }

}
