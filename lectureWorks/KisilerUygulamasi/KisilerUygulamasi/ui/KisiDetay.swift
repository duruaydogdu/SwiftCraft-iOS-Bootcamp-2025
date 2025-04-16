//
//  KisiDetay.swift
//  KisilerUygulamasi
//
//  Created by Duru Aydoğdu on 13.04.2025.
//

import UIKit

class KisiDetay: UIViewController {
    
    @IBOutlet weak var tfKisiAd: UITextField!
    @IBOutlet weak var tfKisiTel: UITextField!
    
    var kisi:Kisiler? // henüz burada bir değer olup olmayacağını bilmediğimden soru işareti koydum.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tempKisi = kisi {
            tfKisiAd.text = tempKisi.kisi_ad
            tfKisiTel.text = tempKisi.kisi_tel
        }
    }
    

    @IBAction func buttonGuncelle(_ sender: Any) {
        if let ad = tfKisiAd.text, let tel = tfKisiTel.text, let tempKisi = kisi {
            guncelle(kisi_id: tempKisi.kisi_id!, kisi_ad: ad, kisi_tel: tel)
        }
        // Bir önceki sayfaya döner.
        // navigationController?.popViewController(animated: true)
        
        // En baştaki sayfaya döner.
        // navigationController?.popViewController(animated: true)
    }
    
    func guncelle(kisi_id:Int, kisi_ad:String,kisi_tel:String){
        print("Kişi Güncelle : \(kisi_id) - \(kisi_ad) - \(kisi_tel)")
        
    }
}
