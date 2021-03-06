//
//  RoutStartViewController.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Функционал переходов между экранами

class RoutStartViewController {
    static let shared = RoutStartViewController()
    weak var NavigationController: UINavigationController?
    
    //Переход к контролеру для начала работы с новым текстом
    
    func goToTextFieldController(){
        let textVC = TextFieldViewController()
        NavigationController?.pushViewController(textVC, animated: true)
    }
    
    //Переход к контроллеру с сохраненной базой слов из лексикона
    func goToTableViewWithLexicon(){
        let tableVC = TableViewController()
        tableVC.link = DataModel.shared.getLexiconWords()
        tableVC.pushedButtom = "lexicon"
        NavigationController?.pushViewController(tableVC, animated: true)
    }
    
    //Переход к контроллеру с сохраненной базой еще неизвестных слов
    func goToTableViewWithBadWords(){
        let tableVC = TableViewController()
        tableVC.link = DataModel.shared.getProblemWords()
        tableVC.pushedButtom = "problem"
        NavigationController?.pushViewController(tableVC, animated: true)
    }
    
    // Переход к Свайпу слов
    func goToSwipeController(){
        let array = DataModel.shared.getTextFieldData()
        if array.count == 0 {return}
        let swipeVC = SwipeViewController()
        swipeVC.array = array
        NavigationController?.pushViewController(swipeVC, animated: false)
    }
    
    //Переход в главное меню
    func goToMain(){
        NavigationController?.popToRootViewController(animated: false)
    }
    
    //Переход к TableView контролеру с текущими проблемными словами, сразу после Свайпов
    func goToListOfProblemWordsAfterSwipe(){
        goToMain()
        let data = DataModel.shared.convertStringToDictionary(SwipeDataModel.shared.problemWords)
        guard data.count != 0 else {return}
        let tableVC = TableViewController()
        tableVC.pushedButtom = "swipe"
        tableVC.link = data
        NavigationController?.pushViewController(tableVC, animated: true)
    }
}
