//
//  Interest.swift
//  Carousel
//
//  Created by Артем Иревлин on 25.06.2021.
//

import UIKit

class Service {
    var title = ""
    var image: UIImage
    var color: UIColor
    
    init(title: String, image: UIImage, color: UIColor) {
        self.title = title
        self.image = image
        self.color = color
    }
    
    static func fetchInterest() -> [Service] {
        return [
            Service(title: "Fishing with friends", image: UIImage(named: "fishFriend")!, color: UIColor(red: 86/255.0, green: 110/255.0, blue: 92/255.0, alpha: 0.4)),
            Service(title: "Fishing rod", image: UIImage(named: "fishRod")!, color: UIColor(red: 93/255.0, green: 87/255.0, blue: 80/255.0, alpha: 0.4)),
            Service(title: "Boats run a lake", image: UIImage(named: "boatRun")!, color: UIColor(red: 18/255.0, green: 12/255.0, blue: 64/255.0, alpha: 0.4))
        ]
    }
}
