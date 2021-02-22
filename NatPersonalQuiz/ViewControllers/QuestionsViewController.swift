//
//  QuestionsViewController.swift
//  NatPersonalQuiz
//
//  Created by HappyLiya on 10.02.2021.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionsProgressView: UIProgressView!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answersCount = Float(currentAnswers.count - 1)
            rangedSlider.value = answersCount / 2
            rangedSlider.maximumValue = answersCount
        }
    }
    
    @IBOutlet var singeStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var sinleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    @IBOutlet var rangedLabels: [UILabel]!
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var chosenAnswers: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.answers = chosenAnswers
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = sinleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        chosenAnswers.append(currentAnswer)
        nextQuestions()
    }
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip (multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                chosenAnswers.append(answer)
            }
        }
       nextQuestions()
    }
    @IBAction func rangedAnwerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        chosenAnswers.append(currentAnswers[index])
        nextQuestions()
        
    }
    


}

// MARK: - Private Methods
 
extension QuestionsViewController {
    private func updateUI() {
        for stackView in [singeStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.text
        
        let totalProgress = Float (questionIndex) / Float (questions.count)
        
        questionsProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1)  из \(questions.count)"
        showCurrentAnswers(for: currentQuestion.type)
    }
    private func showCurrentAnswers(for type: ResponceType) {
        switch type {
        
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singeStackView.isHidden = false
        
        for (button, answer) in zip(sinleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = currentAnswers.first?.text
        rangedLabels.last?.text = currentAnswers.last?.text
    }
    
    private func nextQuestions() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}

