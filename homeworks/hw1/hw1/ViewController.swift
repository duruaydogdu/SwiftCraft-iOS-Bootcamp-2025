//
//  ViewController.swift
//  hw1
//
//  Created by Duru Aydoğdu on 15.04.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Coffee"
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(named: "anaRenk1")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "yaziRenk1")!]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

    
        
    }
    


}

