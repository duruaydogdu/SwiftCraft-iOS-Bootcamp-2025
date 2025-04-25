//
//  Anasayfa.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//


import UIKit

class Anasayfa: UIViewController{
    
    @IBOutlet weak var gorevlerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var gorevlerListesi = [Gorevler]()
    var anasayfaViewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        gorevlerTableView.delegate = self
        gorevlerTableView.dataSource = self
        
        _ = anasayfaViewModel.gorevlerListesi.subscribe(onNext: { liste in
            
            self.gorevlerListesi = liste
            self.gorevlerTableView.reloadData()
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear çalıştı.")
        anasayfaViewModel.gorevleriYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            print("toDetay çalıştı")
            if let gorev = sender as? Gorevler {
                print ("Veri: \(gorev.gorev_ad!)")
                let gidilecekVC = segue.destination as! DetaySayfa
                gidilecekVC.gorev  = gorev
            }
        }
    }
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        anasayfaViewModel.ara(aramaKelimesi: searchText)
    }
}
// bu kısım çok önemli!!!
extension Anasayfa : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gorevlerListesi.count
    } // kaç tane satır oluşturacak
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // satır sayısına göre tekrarlı çalışacak.
        let hucre = tableView.dequeueReusableCell(withIdentifier: "gorevlerHucre") as! GorevlerHucre
        
        // 0,1,2 index şeklinde
        let gorev = gorevlerListesi[indexPath.row]
        
        hucre.labelGorevAd.text = gorev.gorev_ad
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gorev = gorevlerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: gorev)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // kaydırarak silme işlemi
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            contextualAction, view, bool in // closure
            
            let gorev = self.gorevlerListesi[indexPath.row] // self'e dikkat, erişim sıkıntısını ortadan kaldırmak için kullandık.
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(gorev.gorev_ad!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.anasayfaViewModel.sil(gorev_id: gorev.gorev_id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}

