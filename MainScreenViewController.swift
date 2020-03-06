//
//  MainScreenViewController.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/4/20.
//  Copyright © 2020 Wes. All rights reserved.
//
//var collection: [InitialScreenData] = []

import UIKit

struct PokeName: Decodable {
    let results: [info]
}

struct info: Decodable {
    let name: String
    let url: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var pokeArray: [PokeName] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = pokeArray[indexPath.row].results[0].name.capitalized
        
        return cell
    }
    
        
    func downloadJSON(completed: @escaping () -> ()) {
        let url = "https://pokeapi.co/api/v2/pokemon/?limit=807"
        let urlObj = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObj!) {(data, respone, error) in
            if error == nil {
                do {
                    var model = try JSONDecoder().decode(PokeName.self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    for i in 0...806 {
                        //print(model.results[i].name)
                    }
                }catch {
                    print("JSON error")
                }
        }
        }.resume()
    }
}


