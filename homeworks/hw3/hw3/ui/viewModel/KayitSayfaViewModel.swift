//
//  KayitSayfaViewModel.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import Foundation

class KayitSayfaViewModel {
    var gorevlerRepository = GorevlerRepository()
    
    func ekle(gorev_ad:String) {
        gorevlerRepository.ekle(gorev_ad: gorev_ad)
    }
}
