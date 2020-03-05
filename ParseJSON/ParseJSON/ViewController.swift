//
//  ViewController.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/4/20.
//  Copyright © 2020 Wes. All rights reserved.
//

import UIKit

struct InitialScreenData {
    var name: String
    var id: Int
}

struct DetailScreenData {
    var name: String
    var id: Int
    var height: Int
    var weight: Int
    var type: String
}





struct PokeTraits: Decodable {
    struct PokeHIW: Decodable{
        let forms: [PokemonName]
        let height: Int
        let id: Int
        let weight: Int
        let types: [PokeType]
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
}


class ViewController: UIViewController {
    var pokeArray: [InitialScreenData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://pokeapi.co/api/v2/pokemon/1"
        let urlObj = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObj!) {(data, respone, error) in
            do {
                var model = try JSONDecoder().decode(PokeTraits.PokeHIW.self, from: data!)
                var obj = InitialScreenData(name: model.forms[0].name, id: model.id)
                self.pokeArray.append(obj)
                
                print(self.pokeArray[0].name)
                
                print(model.forms[0].name)
                print(model.height)
                print(model.id)
                print(model.weight)
                if model.types.count > 1 {
                    print(model.types[1].type.name + "/" + model.types[0].type.name)
                }
                else {
                    print(model.types[0].type.name)
                }
                //print(model.types[0].type)
            }catch {
                print("error")
            }
        }.resume()
    }
}




/*struct PokeArray: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://pokeapi.co/api/v2/pokemon"
        let urlObj = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            do {
                var model = try JSONDecoder().decode(PokeArray.self, from: data!)
                for Pokemon in model.results {
                    print(Pokemon.name.uppercased() + " " + Pokemon.url)
                }
            
            }catch {
                print("error thrown")
            }
        }.resume()
    }
} */



/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
} */


