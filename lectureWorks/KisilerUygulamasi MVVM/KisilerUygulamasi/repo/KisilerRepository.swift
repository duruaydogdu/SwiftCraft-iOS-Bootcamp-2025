//
//  KisilerRepository.swift
//  KisilerUygulamasi
//
//  Created by Duru Aydoğdu on 20.04.2025.
//

import Foundation
import RxSwift

// veritabanı işlemlerini burada gerçekleştirmek istiyoruz, o yüzden de kisiKayit'taki kaydet fonksiyonunu buraya taşıdık.

class KisilerRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    func kaydet(kisi_ad:String, kisi_tel:String) {
        print("Kişi kaydet : \(kisi_ad) - \(kisi_tel)")
    }
    
    func guncelle(kisi_id:Int, kisi_ad:String,kisi_tel:String){
        print("Kişi Güncelle : \(kisi_id) - \(kisi_ad) - \(kisi_tel)")
        
    }
    
    func ara(aramaKelimesi:String) {
        print("Kişi Ara : \(aramaKelimesi)")
    }
    
    func sil(kisi_id:Int){
        print("Kişi Sil : \(kisi_id)")
    }
    
    func kisileriYukle() {
        var liste = [Kisiler]()
        let k1 = Kisiler(kisi_id: 1, kisi_ad: "Duru", kisi_tel: "1111")
        let k2 = Kisiler(kisi_id: 2, kisi_ad: "Beyza", kisi_tel: "2222")
        let k3 = Kisiler(kisi_id: 3, kisi_ad: "İlknur", kisi_tel: "3333")
        liste.append(k1) // append ile ekleme işlevi
        liste.append(k2)
        liste.append(k3)
        
        kisilerListesi.onNext(liste) // trigger - tetikleme, onNext kullanılıyorsa tetikleyerek listen etmiş oluyoruz!!
    }
}
