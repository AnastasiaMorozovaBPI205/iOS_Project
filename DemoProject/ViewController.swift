//
//  ViewController.swift
//  Demo
//
//  Created by Anastasia on 15.03.2022.
//

import UIKit
import Keyboard
import TestPackage

class ViewController: UIViewController {
    var taskView: TestPackage.TaskView = TestPackage.TaskView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskView = TestPackage.TaskView(frame: view.frame)
        initSubviews()
    }
    
    private func initSubviews() {
        taskView.setupTaskView(
            tasks: [
                TestPackage.TaskModel(text: "1 + 2", answer: "3"),
                TestPackage.TaskModel(text: "3 * 8", answer: "24"),
                TestPackage.TaskModel(text: "35 / 7", answer: "5"),
                TestPackage.TaskModel(text: "30 / 5 + 3", answer: "9"),
                TestPackage.TaskModel(text: "(2 + 5) / 7", answer: "1"),
                TestPackage.TaskModel(text: "33 * 2 / 11", answer: "6")
            ],
            textColor: UIColor.HEXColor(color: "9358F7"),
            buttonTextColor: UIColor.HEXColor(color: "9358F7"),
            layerColorModel: TestPackage.LayerColorsModel(
                top: UIColor.HEXColor(color: "2EC4E6").cgColor,
                mid: UIColor.HEXColor(color: "7B78F2").cgColor,
                bottom: UIColor.HEXColor(color: "9358F7").cgColor
            )
        )
        
        taskView.loadCheckViewDelegate = self
        
        view.addSubview(taskView)
        
        let symbolsNumbers: [UInt32] = [16, 10]
        let layerColor: Keyboard.LayerColorsModel = Keyboard.LayerColorsModel(
            colorTop: UIColor.HEXColor(color: "2EC4E6").cgColor,
            colorBottom: UIColor.HEXColor(color: "9358F7").cgColor
        )
        let layersColors: [Keyboard.LayerColorsModel] = [layerColor, layerColor, layerColor]

        let donut = UIDonutDialKeyboard(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200),
            layersNumber: 3,
            letterNumbers: symbolsNumbers,
            layerColors: layersColors,
            buttonTitleColor: UIColor.HEXColor(color: "9358F7")
        )

        //view.addSubview(donut)
        
        //donut.center.x = view.frame.minX + 187
        //donut.center.y = view.frame.minY + 350
        
        donut.isRotating = true
        donut.canKeystrokeByRotation = true

        donut.alphabetCircles.forEach{ circle in
            circle.typingDelegate = self
        }

        donut.symbolsCircles.forEach{ circle in
            circle.typingDelegate = self
        }

        taskView.userAnswer.inputView = donut
    }
}

extension ViewController: LoadCheckViewDelegate {
    func loadCheckView(checkViewController: CheckViewController) {
        navigationController?.pushViewController(
            checkViewController,
            animated: true
        )
    }
}

extension ViewController: KeyboardTypingDelegate {
    func symbolKeyWasTapped(character: String) {
        taskView.userAnswer.insertText(character)
    }

    func returnKeyWasTapped() {
        taskView.userAnswer.endEditing(true)
    }

    func eraseKeyWasTapped() {
        taskView.userAnswer.deleteBackward()
    }
}
