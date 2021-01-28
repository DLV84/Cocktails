//
//  PresentAlertController.swift
//  Cocktails
//
//  Created by Daniel Villedrouin on 1/27/21.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        let alertController = UIAlertController(title: "ERROR!", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
