//
//  AnasayfaViewModel.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var gorevlerRepository = GorevlerRepository()
    var gorevlerListesi = BehaviorSubject<[Gorevler]>(value: [Gorevler]())
    
    init() {
        veritabaniKopyala()
        gorevlerListesi = gorevlerRepository.gorevlerListesi
    }
    
    func ara(aramaKelimesi:String) {
        gorevlerRepository.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(gorev_id:Int){
        gorevlerRepository.sil(gorev_id: gorev_id)
    }
    
    func gorevleriYukle(){
        gorevlerRepository.gorevleriYukle()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "gorevDB", ofType: "sqlite")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("gorevDB.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
    }
}
