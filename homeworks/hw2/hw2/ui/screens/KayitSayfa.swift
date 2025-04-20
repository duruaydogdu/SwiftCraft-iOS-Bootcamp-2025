//
//  KayitSayfa.swift
//  hw2
//
//  Created by Duru Aydoğdu on 17.04.2025.
//

import UIKit

class KayitSayfa: UIViewController {
    
    @IBOutlet weak var tfGorevAd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func buttonEkle(_ sender: Any) {
        if let ad = tfGorevAd.text { // if let optional binding
            ekle(gorev_ad: ad)
        }
    }
    
    func ekle(gorev_ad:String) {
        print("Görev Ekle: \(gorev_ad)")
    }
    
}
