//
//  ViewController.swift
//  Pokedex
//
//  Created by Ezra Kiteck on 11/12/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    //IB Outlets
    @IBOutlet weak var pokemonNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet var mainView: UIView!
    
    //Base URL for request
    let pokemonAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    let imageAPIBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    let typeAPIBaseURL = "https://pokeapi.co/api/v2/type/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        //Takes Keyboard away
        pokemonNameTextField.resignFirstResponder()
        
        //Checks against the Pokemon name being nil
        guard let pokemonName = pokemonNameTextField.text else {
                return
        }
        
        //Clears text field
        pokemonNameTextField.text = ""
        
        //Replaces any spaces with plus signs for URL usage
        let pokemonNameURL = pokemonName.replacingOccurrences(of: " ", with: "+")
        
        //Building our complete request URL with pokemon
        let requestURL = pokemonAPIBaseURL + pokemonNameURL
        
        //The Alamofire thread that gets the info of the pokemon via the PokeAPI
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Displays the name and ID of the pokemon
                self.descriptionTextView.text = "Name: \(json["name"])\nID: \(json["id"])"
                //Uses the base URL + the pokemons ID# + .png to get and display the default sprite
                self.pokemonImageView.sd_setImage(with: URL(string: self.imageAPIBaseURL + json["id"].stringValue + ".png"), completed: nil)
                let pokemonType = (json["types"].arrayValue)[0]["type"]["name"].stringValue
                print(pokemonType)
                switch pokemonType {
                case "normal":
                    self.mainView.backgroundColor = UIColor(red: 168 / 255, green: 167 / 255, blue: 122 / 255, alpha: 1)
                case "fire":
                    self.mainView.backgroundColor = UIColor(red: 238 / 255, green: 128 / 255, blue:  59 / 255, alpha: 1)
                case "fighting":
                    self.mainView.backgroundColor = UIColor(red: 190 / 255, green:  49 / 255, blue:  45 / 255, alpha: 1)
                case "water":
                    self.mainView.backgroundColor = UIColor(red: 106 / 255, green: 146 / 255, blue: 237 / 255, alpha: 1)
                case "flying":
                    self.mainView.backgroundColor = UIColor(red: 168 / 255, green: 147 / 255, blue: 237 / 255, alpha: 1)
                case "grass":
                    self.mainView.backgroundColor = UIColor(red: 123 / 255, green: 198 / 255, blue:  87 / 255, alpha: 1)
                case "poison":
                    self.mainView.backgroundColor = UIColor(red: 159 / 255, green:  68 / 255, blue: 158 / 255, alpha: 1)
                case "electric":
                    self.mainView.backgroundColor = UIColor(red: 247 / 255, green: 206 / 255, blue:  67 / 255, alpha: 1)
                case "ground":
                    self.mainView.backgroundColor = UIColor(red: 223 / 255, green: 191 / 255, blue: 110 / 255, alpha: 1)
                case "psychic":
                    self.mainView.backgroundColor = UIColor(red: 246 / 255, green:  91 / 255, blue: 137 / 255, alpha: 1)
                case "rock":
                    self.mainView.backgroundColor = UIColor(red: 183 / 255, green: 159 / 255, blue:  65 / 255, alpha: 1)
                case "ice":
                    self.mainView.backgroundColor = UIColor(red: 154 / 255, green: 216 / 255, blue: 215 / 255, alpha: 1)
                case "bug":
                    self.mainView.backgroundColor = UIColor(red: 168 / 255, green: 182 / 255, blue:  49 / 255, alpha: 1)
                case "dragon":
                    self.mainView.backgroundColor = UIColor(red: 112 / 255, green:  67 / 255, blue: 244 / 255, alpha: 1)
                case "ghost":
                    self.mainView.backgroundColor = UIColor(red: 112 / 255, green:  90 / 255, blue: 150 / 255, alpha: 1)
                case "dark":
                    self.mainView.backgroundColor = UIColor(red: 112 / 255, green:  88 / 255, blue:  73 / 255, alpha: 1)
                case "steel":
                    self.mainView.backgroundColor = UIColor(red: 184 / 255, green: 184 / 255, blue: 207 / 255, alpha: 1)
                case "fairy":
                    self.mainView.backgroundColor = UIColor(red: 236 / 255, green: 154 / 255, blue: 172 / 255, alpha: 1)
                default:
                    print("This should never appear")
                }
            case.failure(let error):
                //Displays an error if it fails
                self.descriptionTextView.text = "Pokemon not found!"
                print(error.localizedDescription)
            }
        }
    }

}

