//
//  PokemonViewController.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/5/20.
//  Copyright © 2020 Wes. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    var pokeUrl = ""
    var name = ""
    var type = ""
    var height = 0
    var weight = 0
    
    
    struct PokeHIW: Decodable{
        //Pokemon Name
        let forms: [PokemonName]
        let height: Int
        let id: Int
        let weight: Int
        let types: [PokeType]
        let sprites: pokeImage
    }
    struct PokemonName: Decodable {
        let name: String
    }
    struct PokeType: Decodable{
        let type: TypeName
    }
    struct TypeName: Decodable {
        let url: String
        let name: String
    }
    struct pokeImage: Decodable {
        let front_default: URL
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor.red
        view.backgroundColor = .systemIndigo
        
        self.downloadJSON {
        self.downloadJSON {
            self.nameLabel.text = self.name.uppercased()
            self.typeLabel.text = "TYPE: \(self.type.count)"
            self.heightLabel.text = "HEIGHT: \(self.height)"
            self.weightLabel.text = "WEIGHT: \(self.weight)"
            }
        }
        
        
        nameLabel.text = name
        typeLabel.text = type
        heightLabel.text = "\(height)"
        weightLabel.text = "\(weight)"
    }
        
        func downloadJSON(completed: @escaping () -> ()) {
            let url = URL(string: "\(pokeUrl)/")
                URLSession.shared.dataTask(with: url!) {(data, response, error) in
                    
                    if error == nil {
                        do {
                            var model = try JSONDecoder().decode(PokeHIW.self, from: data!)
                            
                            DispatchQueue.main.async {
                                completed()
                            }
                            
                            self.name = model.forms[0].name
                            if model.types.count == 1 {
                                print(model.types[0].type)
                                self.type = "\(model.types[0].type)"
                            }else {
                                self.type = "\(model.types[1].type) - \(model.types[0].type)"
                            }
                            self.height = model.height
                            self.weight = model.weight
                            
                        }catch {
                            print("Pokemon View JSON Error")
                        }
                    }
                    
                }.resume()
            }
        
        
        /*
        var pokeStats: PokeHIW?
        
        nameLabel.text = pokeStats?.forms[0].name
        weightLabel.text = "\(pokeStats?.weight)"
        heightLabel.text = "\(pokeStats?.height)"
        typeLabel.text = pokeStats?.types[0].type.name */
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

