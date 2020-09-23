//
//  ViewController.swift
//  TennisLiveDataAPISample
//
//  Created by AP Yauheni Levin on 22.09.20.
//

import UIKit

class ViewController: UIViewController {

    let infoService = TennisInfoService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoService.getRating(forTour: .ATP)
        infoService.getPlayerDetailsInfo(playerId: 95376)
        infoService.getTournamants(tour: .ATP)
    }
}

