//
//  File.swift
//  
//
//  Created by edz on 2020/12/9.
//

import Foundation
import UIKit

public extension UIViewController {
    func addAlert(msg: String,sure: @escaping () -> Void) {
        let avc = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        avc.addAction(UIAlertAction(title: "sure_str".local , style: .default, handler: { (a) in
            sure()
        }))
        
        avc.addAction(UIAlertAction(title: "cancel_str".local, style: .cancel, handler: { (a) in
            avc.dismiss(animated: true, completion: nil)
        }))
        self.present(avc, animated: true, completion: nil)
    }
}
