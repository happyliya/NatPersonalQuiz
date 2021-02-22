//
//  ResultViewController.swift
//  NatPersonalQuiz
//
//  Created by HappyLiya on 10.02.2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateResult()
    }
}

// MARK: Private methods
extension ResultViewController {
    private func updateResult() {
        var  rateOfAnimals: [ AnimalType: Int ] = [:]
        let animals = answers.map { $0.type }
        
        for animal in animals {
            if let animalTypeCount = rateOfAnimals[animal] {
                rateOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                rateOfAnimals[animal] = 1
            }
        }
        let sortedRateAnimals = rateOfAnimals.sorted { $0.value > $1.value }
        guard let mostRateAlimal = sortedRateAnimals.first?.key else { return }
        
        updateUI(with: mostRateAlimal)
    }
     
    
    
    private func updateUI(with animal: AnimalType?) {
        resultLabel.text = "Вы - \(animal?.rawValue ?? "🐶")!"
        descriptionLabel.text = animal?.definition ?? ""
    }
}

