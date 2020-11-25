// ----------------------------------------------------------------------------
//
//  UIViewExtension.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 25.11.2020.
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

private var indicatorView: UIView?

// Add function for start and stop activity indicator
extension UIView {
    func showActivityIndicator() {
        indicatorView = UIView(frame: self.bounds)
        indicatorView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = indicatorView!.center
            activityIndicator.startAnimating()
            indicatorView?.addSubview(activityIndicator)
            self.addSubview(indicatorView!)
    }

    func stopActivitiIndicator() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}
