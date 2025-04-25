//
//  GorevlerRepository.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import Foundation
import RxSwift

class GorevlerRepository {
    var gorevlerListesi = BehaviorSubject<[Gorevler]>(value: [Gorevler]())
    
    func ekle(gorev_ad:String) {
        print("Görev Ekle: \(gorev_ad)")
    }
    
    func guncelle(gorev_id:Int, gorev_ad:String){
        print("Görev Güncelle : \(gorev_id) - \(gorev_ad)")
        
    }
    
    func ara(aramaKelimesi:String) {
        print("Görev Ara : \(aramaKelimesi)")
    }
    
    func sil(gorev_id:Int){
        print("Görev Sil : \(gorev_id)")
    }
    
    func gorevleriYukle(){
        var liste = [Gorevler]()
        let g1 = Gorevler(gorev_id: 1, gorev_ad: "Sunum hazırla.")
        let g2 = Gorevler(gorev_id: 2, gorev_ad: "Market alışverişi yap.")
        liste.append(g1)
        liste.append(g2)
        
        gorevlerListesi.onNext(liste)
    }
}
