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
    
    let db:FMDatabase? // veritabanına erişim nesnemiz.
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniYolu = URL(fileURLWithPath: hedefYol).appendingPathComponent("rehber.sqlite")
        db = FMDatabase(path: veritabaniYolu.path) // db, veritabanına erişime izin veriyor olacak.
    }
    
    func kaydet(kisi_ad:String, kisi_tel:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)", values: [kisi_ad, kisi_tel]) // soru işaretleri yerlerine values'da verdiğimiz değerle eşleşiyor.
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func guncelle(kisi_id:Int, kisi_ad:String, kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad=?, kisi_tel=? WHERE kisi_id=?", values: [kisi_ad, kisi_tel, kisi_id]) // soru işaretleri yerlerine values'da verdiğimiz değerle eşleşiyor.
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func ara(aramaKelimesi:String) {
        db?.open()
        
        do {
            var liste = [Kisiler]()
            
            let result = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad LIKE '%\(aramaKelimesi)'%", values: nil)
            
            while result.next() {  // bir sonraki satıra kadar çalışma anlamına geliyor.
                let kisi_id = Int(result.string(forColumn: "kisi_id"))! // sağdakiler veritabanında olan birebir isimler, soldaki de bizim tanımladığımız.
                let kisi_ad = result.string(forColumn: "kisi_ad") ?? "isim yok" // soru işaretinin solundaki çalışmazsa sağındaki çalışır.
                let kisi_tel = result.string(forColumn: "kisi_tel") ?? "tel yok"
                
                let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                
                liste.append(kisi)
            }
            
            kisilerListesi.onNext(liste) // trigger - tetikleme, onNext kullanılıyorsa tetikleyerek listen etmiş oluyoruz!!
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func sil(kisi_id:Int){
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id=?", values: [kisi_id]) // soru işaretleri yerlerine values'da verdiğimiz değerle eşleşiyor.
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func kisileriYukle() {
        db?.open()
        
        do {
            var liste = [Kisiler]()
            
            let result = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while result.next() {  // bir sonraki satıra kadar çalışma anlamına geliyor.
                let kisi_id = Int(result.string(forColumn: "kisi_id"))! // sağdakiler veritabanında olan birebir isimler, soldaki de bizim tanımladığımız.
                let kisi_ad = result.string(forColumn: "kisi_ad") ?? "isim yok" // soru işaretinin solundaki çalışmazsa sağındaki çalışır.
                let kisi_tel = result.string(forColumn: "kisi_tel") ?? "tel yok"
                
                let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                
                liste.append(kisi)
            }
            
            kisilerListesi.onNext(liste) // trigger - tetikleme, onNext kullanılıyorsa tetikleyerek listen etmiş oluyoruz!!
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
