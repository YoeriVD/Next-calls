//
//  Next_callsApp.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 09/07/2024.
//

import SwiftUI

let viewModel = NextCallListViewModel().fetchReminders();

@main
struct Next_callsApp: App {
    var body: some Scene {
        WindowGroup {
            NextCallList(viewModel: viewModel)
        }
    }
}

import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    
    var interfaceController: CPInterfaceController?
    var list : CarplayList?
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.list = CarplayList(viewModel: viewModel, controller: interfaceController, scene: templateApplicationScene);
        self.interfaceController = interfaceController
        self.interfaceController?.delegate = self
        self.interfaceController?.setRootTemplate(list!.template, animated: false, completion: nil)
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
}

