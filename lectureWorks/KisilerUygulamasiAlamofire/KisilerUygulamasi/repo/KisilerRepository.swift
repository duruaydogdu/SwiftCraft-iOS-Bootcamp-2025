//
//  KisilerRepository.swift
//  KisilerUygulamasi
//
//  Created by Duru Aydoğdu on 20.04.2025.
//

import Foundation
import RxSwift
import Alamofire

// veritabanı işlemlerini burada gerçekleştirmek istiyoruz, o yüzden de kisiKayit'taki kaydet fonksiyonunu buraya taşıdık.

class KisilerRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    func kaydet(kisi_ad:String, kisi_tel:String) {
        let url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php"
        let parameters:Parameters = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        
        AF.request(url,method: .post,parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func guncelle(kisi_id:Int, kisi_ad:String,kisi_tel:String){
        let url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php"
        let parameters:Parameters = ["kisi_id":kisi_id,"kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        
        AF.request(url,method: .post,parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func ara(aramaKelimesi:String) {
        let url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php"
        let parameters:Parameters = ["kisi_ad":aramaKelimesi]
        
        AF.request(url,method: .post,parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
                    if let liste = cevap.kisiler{
                        self.kisilerListesi.onNext(liste)
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sil(kisi_id:Int){
        let url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php"
        let parameters:Parameters = ["kisi_id":kisi_id]
        
        AF.request(url,method: .post,parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func kisileriYukle() {
        
         //    kisilerListesi.onNext(liste) // trigger - tetikleme, onNext kullanılıyorsa tetikleyerek listen etmiş oluyoruz!!
         let url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php"
         
         AF.request(url,method: .get).response { response in
             if let data = response.data {
                 do {
                     let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
                     if let liste = cevap.kisiler{
                         self.kisilerListesi.onNext(liste)
                     }
                 } catch{
                     print(error.localizedDescription)
                 }
             }
         }
     }
}
