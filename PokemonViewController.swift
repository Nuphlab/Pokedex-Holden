//
//  PokemonViewController.swift
//  ParseJSON
//
//  Created by Westley Holden on 3/5/20.
//  Copyright © 2020 Wes. All rights reserved.
//

import UIKit

    extension UIImageView {
        func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                }
            }.resume()
        }
        func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }

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
    var image = ""
    
    
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
        let front_default: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor.red
        view.backgroundColor = .systemIndigo
        
        self.downloadJSON {
        self.downloadJSON {
            self.nameLabel.text = self.name.uppercased()
            self.typeLabel.text = "TYPE: \(self.type.uppercased())"
            self.heightLabel.text = "HEIGHT: \(self.height) dm"
            self.weightLabel.text = "WEIGHT: \(self.weight) lbs"
            let urlString = self.image
            let url = URL(string: urlString)
            self.imageView.downloaded(from: url!)
            
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
                    self.image = model.sprites.front_default
                    self.name = model.forms[0].name
                    if model.types.count < 2 {
                        self.type = "\(model.types[0].type.name)"
                    }else {
                        self.type = "\(model.types[1].type.name) - \(model.types[0].type.name)"
                    }
                    self.height = model.height
                    self.weight = model.weight
                    
                }catch {
                    print("Pokemon View JSON Error")
                }
            }
        }.resume()
    }
}
