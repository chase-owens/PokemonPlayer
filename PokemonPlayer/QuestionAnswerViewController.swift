//
//  QuestionAnswerViewController.swift
//  PokemonPlayer
//
//  Created by Chase Owens on 12/8/17.
//  Copyright © 2017 Chase Owens. All rights reserved.
//

import UIKit

class QuestionAnswerViewController: UIViewController {
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    @IBOutlet weak var questionLabel: UILabel!
    
    //Range Stack Outlets
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangeLabel1: UILabel!
    @IBOutlet weak var rangeLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    

    //Single Stack Outlets
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    //Multiple Stack Outlets
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    
    @IBOutlet weak var multipleSwitch1: UISwitch!
    @IBOutlet weak var multipleSwitch2: UISwitch!
    @IBOutlet weak var multipleSwitch3: UISwitch!
    @IBOutlet weak var multipleSwitch4: UISwitch!

    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    
    var questions = [
        Question(text: "What is your favorite holiday?", responseType: .single, answers: [
            Answer(text: "Christmas", type: .Abomasnow),
            Answer(text: "Halloween", type: .Bronzon),
            Answer(text: "4th of July", type: .Blissy),
            Answer(text: "Your Birthday", type: .Zygarde)]),
        
        Question(text: "Where would you rather live?", responseType: .single, answers: [
            Answer(text: "Las Vegas", type: .Bronzon),
            Answer(text: "Silicon Valley", type: .Abomasnow),
            Answer(text: "Marfa, TX", type: .Blissy),
            Answer(text: "Washington, D.C.", type: .Zygarde)]),
        
        Question(text: "What is your drink of choice?", responseType: .multiple, answers: [
            Answer(text: "Wine", type: .Blissy),
            Answer(text: "Beer", type: .Bronzon),
            Answer(text: "Whiskey", type: .Abomasnow),
            Answer(text: "Water", type: .Zygarde)]),
        
        Question(text: " What are your feelings on Climate Change?", responseType: .range, answers: [
            Answer(text: "It should be every nations top concern", type: .Zygarde),
            Answer(text: "Very important", type: .Abomasnow),
            Answer(text: "I'm more concerned for my kids and grandkids than anything", type: .Blissy),
            Answer(text: "It's a Chinese Hoax", type: .Bronzon)]),
        
        Question(text: "What's your relationship with technology?", responseType: .range, answers: [
            Answer(text: "I'm a cybrog", type: .Zygarde),
            Answer(text: "I'm a minimalist", type: .Abomasnow)])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //update Q&A, progressView, NavigationTitle
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex)/Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.responseType {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .range:
            updateRangeStackView(using: currentAnswers)
        }

    }
    
    func updateSingleStackView(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStackView(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
        multipleSwitch1.isOn = false
        multipleSwitch2.isOn = false
        multipleSwitch3.isOn = false
        multipleSwitch4.isOn = false
    }
    
    func updateRangeStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangeLabel1.text = answers.first?.text
        rangeLabel2.text = answers.last?.text
        rangedSlider.setValue(0.5, animated: false)
    }
    
    //Button Actions sending answer type to answersChosen array, going to next question or results
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
        
    }
        
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multipleSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multipleSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multipleSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedResponseButtonPressed() {
        let currentAnsers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnsers.count - 1)))
        
        answersChosen.append(currentAnsers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let RVC = segue.destination as? ResultsViewController
            RVC?.responses = answersChosen
        }
    }
    

}
