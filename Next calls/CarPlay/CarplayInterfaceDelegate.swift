//
//  CarplayInterfaceDelegate.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 12/07/2024.
//

import Foundation
import CarPlay

extension CarPlaySceneDelegate : CPInterfaceControllerDelegate {
    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
        if aTemplate == self.list?.template {
                self.list?.update()
        }
    }
    func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }
    func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }
    func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }
}
