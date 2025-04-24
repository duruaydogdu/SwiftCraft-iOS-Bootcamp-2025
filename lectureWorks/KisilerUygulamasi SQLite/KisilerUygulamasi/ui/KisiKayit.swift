//
//  KisiKayit.swift
//  KisilerUygulamasi
//
//  Created by Duru Aydoğdu on 13.04.2025.
//

import UIKit
// Inheritance - Kalıtım
// KisiKayit : Subclass
// UIViewController : Superclass
// self : bulunduğumuz sınıf
// super : kalıtım ile bir üst sınıf
class KisiKayit: UIViewController {

    @IBOutlet weak var tfKisiAd: UITextField!
    @IBOutlet weak var tfKisiTel: UITextField!
    var kisiKayitViewModel = KisiKayitViewModel() // viewModel'a erişiyoruz.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func buttonKaydet(_ sender: Any) {
        if let ad = tfKisiAd.text, let tel = tfKisiTel.text { // if let optional binding
            kisiKayitViewModel.kaydet(kisi_ad: ad, kisi_tel: tel)
        }
    }
}
