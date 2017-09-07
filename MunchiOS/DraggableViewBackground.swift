//
//  DraggableViewBackground.swift
//  TinderSwipeCardsSwift
//
//  Created by Gao Chao on 4/30/15.
//  Copyright (c) 2015 gcweb. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import YelpAPI

class DraggableViewBackground: UIView, DraggableViewDelegate {
    var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    var location: CLLocationManager!
    var parentController: UIViewController!

    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = (UIScreen.main.bounds.height) * 0.75
    let CARD_WIDTH: CGFloat = (UIScreen.main.bounds.width) * 0.8

    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    var menuButton: UIButton!
    var messageButton: UIButton!
    var checkButton: UIButton!
    var xButton: UIButton!
    var settingsButton: UIButton!
    
    var businesses: [YelpCard]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        
//        let str_location = String((location.location?.coordinate.latitude)!) + String((location.location?.coordinate.longitude)!)
        
        YelpCard.searchWithTerm(term: "Thai", completion: { (businesses: [YelpCard]?, error: Error?) -> Void in
            self.exampleCardLabels = []
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    self.exampleCardLabels.append(business.name!)
                }
                self.loadCards()
            }
            
        }
        )
        
//        exampleCardLabels = ["first", "second", "third", "fourth", "last"]
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
    }

    func setupView() -> Void {
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1)

        xButton = UIButton(frame: CGRect(x: (self.frame.size.width - CARD_WIDTH)/2 + 35, y: self.frame.size.height/2 + CARD_HEIGHT/2 + 10, width: 59, height: 59))
        xButton.setImage(UIImage(named: "xButton"), for: UIControlState())
        xButton.addTarget(self, action: #selector(DraggableViewBackground.swipeLeft), for: UIControlEvents.touchUpInside)

        checkButton = UIButton(frame: CGRect(x: self.frame.size.width/2 + CARD_WIDTH/2 - 85, y: self.frame.size.height/2 + CARD_HEIGHT/2 + 10, width: 59, height: 59))
        checkButton.setImage(UIImage(named: "checkButton"), for: UIControlState())
        checkButton.addTarget(self, action: #selector(DraggableViewBackground.swipeRight), for: UIControlEvents.touchUpInside)
        
        settingsButton = UIButton(frame: CGRect(x: 5, y: 5, width: 59, height: 59))
        settingsButton.setImage(UIImage(named: "checkButton"), for: UIControlState())

        self.addSubview(xButton)
        self.addSubview(checkButton)
        self.addSubview(settingsButton)
    }

    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRect(x: (self.frame.size.width - CARD_WIDTH)/2, y: (self.frame.size.height - CARD_HEIGHT)/2, width: CARD_WIDTH, height: CARD_HEIGHT))
        draggableView.information.text = exampleCardLabels[index]
        draggableView.delegate = self
        return draggableView
    }

    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }

            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    self.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }

    func cardSwipedLeft(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)

        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }

    func swipeRight() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }

    func swipeLeft() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
}
