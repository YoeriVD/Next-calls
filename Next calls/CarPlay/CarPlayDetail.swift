//
//  CarPlayDetail.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 12/07/2024.
//

import Foundation
import CarPlay

struct CarplayDetail {
    let call: Call
    let viewModel: NextCallListViewModel
    let controller: CPInterfaceController
    let scene: CPTemplateApplicationScene
    
    var template: CPGridTemplate {
        return CPGridTemplate(title: call.phone, gridButtons: [self.callButton, self.completeButton])
    }
    var callButton: CPGridButton {
        let button = CPGridButton(titleVariants: ["call"], image: UIImage(systemName: "phone")!, handler: { btn in
            guard let url = call.getPhoneUrl() else { return }
            scene.open(url, options: UIScene.OpenExternalURLOptions())
        })
        
        return button
    }
    var completeButton: CPGridButton {
        let button = CPGridButton(titleVariants: ["complete"], image: UIImage(systemName: "checkmark")!, handler: { btn in
            Task{
                await viewModel.complete(call:call)
            }
            controller.popTemplate(animated: true, completion: nil)
        })
        
        return button
    }
}
