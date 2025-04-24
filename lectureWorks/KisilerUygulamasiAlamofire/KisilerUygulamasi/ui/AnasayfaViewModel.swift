//
//  AnasayfaViewModel.swift
//  KisilerUygulamasi
//
//  Created by Duru Aydoğdu on 20.04.2025.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var kisilerRepository = KisilerRepository() // repository'nin nesnesini oluşturduk, erişim sağlayabilmek için.
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]()) // value -> varsayılan değerdir!! burada boş bir dizi oluşturduk çökmemesi için.
    
    init() {
        kisilerListesi = kisilerRepository.kisilerListesi // bağlantı kurduk.
    }
    
    func ara(aramaKelimesi:String) {
        kisilerRepository.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(kisi_id:Int){
        kisilerRepository.sil(kisi_id: kisi_id)
        kisileriYukle()
    }
    
    func kisileriYukle() {
        kisilerRepository.kisileriYukle()
    }
    
}
