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

class Anasayfa: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    var kisilerListesi = [Kisiler]() // veri kümesi, diğer kisilerListesi ile karıştırma!!
    var anasayfaViewModel = AnasayfaViewModel() // viewModel'a erişiyoruz.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Yaşam döngüsü metodu
        // Sayfa açıldığında 1 kere çalışır.
        print("viewDidLoad() metodu çalıştı")
        searchBar.delegate = self
        
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self

        _ = anasayfaViewModel.kisilerListesi.subscribe(onNext: { liste in  // listen etme kısmı, tetikleneni burada dinlemiş oluyoruz.
            self.kisilerListesi = liste
            self.kisilerTableView.reloadData()
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Sayfa her göründüğünde çalışır.
        // Sayfaya geri dönüldüğünü anlayabiliriz.
        print("viewWillAppear çalıştı")
        anasayfaViewModel.kisileriYukle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Sayfa her görünmez olduğunda çalışır.
        print("viewDidDisappear çalıştı")
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
    
}

// aramayla ilgili kısımları gruplamak için bu extension'ı oluşturdum.
extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        anasayfaViewModel.ara(aramaKelimesi: searchText)
    }
}

// bu kısım çok önemli!!!
extension Anasayfa : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListesi.count
    } // kaç tane satır oluşturacak
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // satır sayısına göre tekrarlı çalışacak.
        let hucre = tableView.dequeueReusableCell(withIdentifier: "kisilerHucre") as! KisilerHucre
        
        // 0,1,2 index şeklinde
        let kisi = kisilerListesi[indexPath.row]
        
        hucre.labelKisiAd.text = kisi.kisi_ad
        hucre.labelKisiTel.text = kisi.kisi_tel
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kisi = kisilerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: kisi)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // kaydırarak silme işlemi
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            contextualAction, view, bool in // closure
            
            let kisi = self.kisilerListesi[indexPath.row] // self'e dikkat, erişim sıkıntısını ortadan kaldırmak için kullandık.
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(kisi.kisi_ad!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.anasayfaViewModel.sil(kisi_id: kisi.kisi_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
