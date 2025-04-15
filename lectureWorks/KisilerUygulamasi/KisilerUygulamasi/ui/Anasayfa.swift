//
//  ViewController.swift
//  KisilerUygulamasi
//
//  Created by Duru Aydoğdu on 13.04.2025.
//

import UIKit

// protocol = interface
// protocoller sınıflara özellik katar.
// bir sınıfa birden fazla protocol eklenebilir.
// önemli! -> kalıtımda bir sınıfa sadece bir adet sınıf eklenebilir.

class Anasayfa: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Yaşam döngüsü metodu
        // Sayfa açıldığında 1 kere çalışır.
        
        searchBar.delegate = self
    }
    
    
    @IBAction func butonDetay(_ sender: Any) {
        let kisi = Kisiler(kisi_id: 1, kisi_ad: "Duru", kisi_tel: "2222")
        performSegue(withIdentifier: "toDetay", sender: kisi)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("geçiş yapıldı")
        if segue.identifier == "toDetay" {
            print("toDetay çalıştı")
            // Any : bütün sınıfların üstündedir.
            if let kisi = sender as? Kisiler { // as? downcasting : Super class > Sub class dönüştürmektir.
                print("veri : \(kisi.kisi_ad!)")
                let gidilecekVC = segue.destination as! KisiDetay
                // as? : downcasting, hata olma ihtimali yüksekse bunu kullanıyoruz.
                // as! : downcasting, hata olma ihtimali düşükse bunu kullanıyoruz.
                gidilecekVC.kisi = kisi
            }
        }
    }
    
    extension Anasayfa : UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("Kişi Ara : \(searchText)")
        }
    }
    
}
