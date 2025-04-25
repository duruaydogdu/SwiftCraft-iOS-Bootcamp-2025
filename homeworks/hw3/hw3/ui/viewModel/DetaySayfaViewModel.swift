//
//  DetaySayfaViewModel.swift
//  hw3
//
//  Created by Duru Aydoğdu on 24.04.2025.
//

import Foundation

class DetaySayfaViewModel {
    var gorevlerRepository = GorevlerRepository()
    
    func guncelle(gorev_id:Int, gorev_ad:String){
        gorevlerRepository.guncelle(gorev_id: gorev_id, gorev_ad: gorev_ad)
    }
}
