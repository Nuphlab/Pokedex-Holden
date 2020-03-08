//
//  MainScreenViewController.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/4/20.
//  Copyright © 2020 Wes. All rights reserved.
//

import UIKit

//Data models for json data received from api
struct PokeName: Decodable {
    let results: [info]
}

struct info: Decodable {
    let name: String
    let url: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokeArray = [info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Reloads data to MainScreenViewController
        downloadJSON {
            self.tableView.reloadData()
        }
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeArray.count
    }
    
    var cellUrl = ""
    
    //Displays 807 pokemon sorted by id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .systemPink
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = pokeArray[indexPath.row].name.capitalized
        
        //cellUrl = pokeArray[indexPath.row].url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    //Passes url from json data to PokemonViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PokemonViewController{
            vc.pokeUrl = pokeArray[(tableView.indexPathForSelectedRow?.row)!].url
            //print(vc.pokeUrl + " Is Lit")
        }
    }
    
    //Gathers name and url for all 807 pokemon
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=807")
        URLSession.shared.dataTask(with: url!) {(data, respone, error) in
            
            if error == nil {
                do {
                    var model = try JSONDecoder().decode(PokeName.self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                    if self.pokeArray.count == 0 {
                        for i in 0...model.results.count - 1 {
                            self.pokeArray.append(model.results[i])
                        }
                    }
                }catch {
                    print("JSON error")
                }
            }
        }.resume()
    }
}


