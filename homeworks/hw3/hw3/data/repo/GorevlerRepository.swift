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
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniYolu = URL(fileURLWithPath: hedefYol).appendingPathComponent("rehber.sqlite")
        db = FMDatabase(path: veritabaniYolu.path)
    }
    
    func ekle(gorev_ad:String) {
        db?.open()
        
        do{
            try db!.executeQuery("INSERT INTO gorevler (gorev_ad,gorev_id) VALUES (?,?)", values: [gorev_ad, gorev_id])
        }catch{
            
        }
        
        
        db?.close()
    }
    
    func guncelle(gorev_id:Int, gorev_ad:String){
        db?.open()
        
        do{
            try db!.executeQuery("UPDATE gorevler SET gorev_ad=? WHERE gorev_id=?", values: [gorev_ad, gorev_id])
        }catch{
            
        }
        
        
        db?.close()
        
    }
    
    func ara(aramaKelimesi:String) {
        db?.open()

        do {
            var liste = [Gorevler]()
            
            let result = try db!.executeQuery("SELECT * FROM gorevler WHERE gorev_ad LIKE '%\(aramaKelimesi)%'", values: nil)
            
            while result.next() {
                let gorev_id = Int(result.string(forColumn: "gorev_id"))!
                let gorev_ad = result.string(forColumn: "gorev_ad")!
                
                let gorev = Gorevler(gorev_id: gorev_id, gorev_ad: gorev_ad)
                
                liste.append(gorev)
            }
            
            gorevlerListesi.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
        
        
        db?.close()
    }
    }
    
    func sil(gorev_id:Int){
        db?.open()
        
        do{
            try db!.executeQuery("DELETE FROM gorevler WHERE gorev_id=?", values: [gorev_id])
        }catch{
            
        }
        
        
        db?.close()
    }
    
    func gorevleriYukle(){
        db?.open()

        do {
            var liste = [Gorevler]()
            
            let result = try db!.executeQuery("SELECT * FROM gorevler", values: nil)
            
            while result.next() {
                let gorev_id = Int(result.string(forColumn: "gorev_id"))!
                let gorev_ad = result.string(forColumn: "gorev_ad")!
                
                let gorev = Gorevler(gorev_id: gorev_id, gorev_ad: gorev_ad)
                
                liste.append(gorev)
            }
            
            gorevlerListesi.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
        
        
        db?.close()
    }
}
