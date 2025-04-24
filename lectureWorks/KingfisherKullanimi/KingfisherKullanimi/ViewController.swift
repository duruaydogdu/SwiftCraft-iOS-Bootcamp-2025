//
//  ViewController.swift
//  KingfisherKullanimi
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resimGoster(resimAdi: "ruj.png")
    }

    
    @IBAction func buttonResim1(_ sender: Any) {
        resimGoster(resimAdi: "saat.png")
    }
    
    @IBAction func buttonResim2(_ sender: Any) {
        resimGoster(resimAdi: "sapka.png")
    }
    
    func resimGoster(resimAdi:String){
        if let url = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(resimAdi)") {
            DispatchQueue.main.async {
                self.imageView.kf.setImage(with: url)
            }
        }
    }
    
}
