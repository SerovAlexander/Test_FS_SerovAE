//
//  Alerts.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 23.11.2020.
//

import UIKit

class Alerts {

    static func presentAlert(view: UIView, viewController: UIViewController){
        let alert = UIAlertController(title: "Oops", message: "Something went wrong! Try again.", preferredStyle: .alert)
        alert.addAction((UIAlertAction(title: "OK", style: .cancel, handler: nil)))
        viewController.present(alert, animated: true, completion: nil)
    }

}
