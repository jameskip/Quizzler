//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let allQuestions: QuestionBank = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstQuestion = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
        updateUI()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        checkAnswer(tag: sender.tag, correctAnswer: allQuestions.list[questionNumber].answer)
        questionNumber += 1
        nextQuestion()
    }

    func updateUI() {
        questionLabel.text = allQuestions.list[questionNumber].questionText
        progressLabel.text = "\(questionNumber + 1)/13"
    }

    func nextQuestion() {
        if questionNumber <= 12 {
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome!", message: "You have finished! Do you want to start over?", preferredStyle: .actionSheet)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }

    func checkAnswer(tag: Int, correctAnswer: Bool) {
        if tag == 1 {
            pickedAnswer = true
        } else if tag == 2 {
            pickedAnswer = false
        }

        if pickedAnswer == correctAnswer {
            print("you got it right!")
        } else {
            print("better luck next time")
        }
    }

    func startOver() {
        questionNumber = 0
        updateUI()
    }

}
