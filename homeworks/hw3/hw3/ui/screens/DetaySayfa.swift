//
//  DetaySayfa.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import UIKit

class DetaySayfa: UIViewController {

    @IBOutlet weak var tfGorevAd: UITextField!
    var detaySayfaViewModel = DetaySayfaViewModel()
    
    var gorev:Gorevler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tempGorev = gorev {
            tfGorevAd.text = tempGorev.gorev_ad
        }
    }
    
    @IBAction func buttonGuncelle(_ sender: Any) {
        if let ad = tfGorevAd.text, let guncellenecekGorev = gorev {
            detaySayfaViewModel.guncelle(gorev_id: guncellenecekGorev.gorev_id!, gorev_ad: ad)
            }
    }


}
