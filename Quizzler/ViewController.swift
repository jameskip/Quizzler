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
    var score: Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
    }

    func displayAlert() {
        let alert = UIAlertController(title: "Awesome!", message: "You have finished! Do you want to start over?", preferredStyle: .actionSheet)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(_) in self.startOver()})
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }

    func nextQuestion() {
        if questionNumber <= 12 {
            updateUI()
        } else {
            displayAlert()
        }
    }

    func checkAnswer(tag: Int, correctAnswer: Bool) {
        if tag == 1 {
            pickedAnswer = true
        } else if tag == 2 {
            pickedAnswer = false
        }

        if pickedAnswer == correctAnswer {
            score += 100
            ProgressHUD.showSuccess("Correct!")
            updateUI()
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }

    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
    }

}
