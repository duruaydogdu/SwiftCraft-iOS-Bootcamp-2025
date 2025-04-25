//
//  KayitSayfa.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import UIKit

class KayitSayfa: UIViewController {
    
    @IBOutlet weak var tfGorevAd: UITextField!
    var kayitSayfaViewModel = KayitSayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func buttonEkle(_ sender: Any) {
        if let ad = tfGorevAd.text { // if let optional binding
            kayitSayfaViewModel.ekle(gorev_ad: ad)
        }
    }
    
   
}

