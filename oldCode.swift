//
//  oldCode.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/5/20.
//  Copyright © 2020 Wes. All rights reserved.
//

import Foundation

//
//  ViewController.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/4/20.
//  Copyright © 2020 Wes. All rights reserved.
//

/*
var collection: [InitialScreenData] = []

import UIKit

struct InitialScreenData {
    var name: String = ""
    var id: Int = 0
}

struct DetailScreenData {
    var name: String = ""
    var id: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var type: String = ""
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
        
        for i in 1...807 {
        
            let url = "https://pokeapi.co/api/v2/pokemon/\(i)"
            let urlObj = URL(string: url)
            
            URLSession.shared.dataTask(with: urlObj!) {(data, respone, error) in
                do {
                    var model = try JSONDecoder().decode(PokeTraits.PokeHIW.self, from: data!)
                    var obj = InitialScreenData(name: model.forms[0].name, id: model.id)
                    self.pokeArray.append(obj)
                    //print(obj.name)
                    //print(obj.id)
                    
                    collection.append(obj)
                    
                    print(collection.count)
                    
                    
                    //print(self.pokeArray[i].name)
                    //print(self.pokeArray[i].id)
                    
                    //print(model.forms[0].name)
                    //print(model.height)
                    //print(model.id)
                    //print(model.weight)
                    /*if model.types.count > 1 {
                        print(model.types[1].type.name + "/" + model.types[0].type.name)
                    }
                    else {
                        print(model.types[0].type.name)
                    }
                    //print(model.types[0].type) */
                }catch {
                    print("error")
                }
            }.resume()
        }
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

 */

