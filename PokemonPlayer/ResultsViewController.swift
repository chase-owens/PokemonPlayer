//
//  ResultsViewController.swift
//  PokemonPlayer
//
//  Created by Chase Owens on 12/8/17.
//  Copyright © 2017 Chase Owens. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultsNameLabel: UILabel!
    @IBOutlet weak var resultsImage: UIImageView!
    @IBOutlet weak var resultsDescriptionLabel: UILabel!
    
    
    var responses: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        setImage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [PokemonCharacters:Int] = [:]
        let responseType = responses.map {$0.type}
        for response in responseType {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: { (pair1, pair2) -> Bool in return pair1.value > pair2.value})
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultsNameLabel.text = "Your Pokemon character is \(mostCommonAnswer)"
        resultsDescriptionLabel.text = mostCommonAnswer.description
        
    }
    
    func setImage() {
        if (resultsNameLabel.text?.contains("Abomasnow"))! {
            resultsImage.image = #imageLiteral(resourceName: "Abomasnow")
        } else if (resultsNameLabel.text?.contains("Zygarde"))! {
            resultsImage.image = #imageLiteral(resourceName: "Zygarde")
        } else if (resultsNameLabel.text?.contains("Blissy"))! {
            resultsImage.image = #imageLiteral(resourceName: "Blissey")
        } else {
            resultsImage.image = #imageLiteral(resourceName: "Bronzong")
        }
    }
    
    
}
