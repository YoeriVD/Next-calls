//
//  CarplayList.swift
//  Next calls
//
//  Created by Yoeri Van Damme on 12/07/2024.
//

import Foundation
import CarPlay

struct CarplayList {
    let viewModel: NextCallListViewModel
    let controller: CPInterfaceController
    let scene: CPTemplateApplicationScene
    
    var template: CPListTemplate = CPListTemplate(title: "Next calls", sections: [])
    func update(){
        _ = viewModel.fetchReminders {
            template.updateSections([self.getSection(), CPListSection(items: [refresh])])
        }
    }
    
    var refresh : CPListItem {
        let item = CPListItem(text: nil, detailText: nil, image: UIImage(systemName: "arrow.clockwise.circle"))
        
        item.handler = { item, completion in
            _ = viewModel.fetchReminders {
                completion()
                update()
            }
        }
        return item
    }
    
    func getItems() -> [CPListItem] {
        return viewModel.calls.compactMap { call in
            let item = CPListItem(text: call.phone, detailText: call.reminder.title, image: UIImage(systemName: "phone"))
            item.handler = {item, completion in
                controller.pushTemplate(
                    CarplayDetail(
                        call: call,
                        viewModel: viewModel,
                        controller: controller,
                        scene: scene).template,
                    animated: true,
                    completion: nil
                )
                completion()
            }
            return item
        }
    }
    
    private func getSection() -> CPListSection {
        return CPListSection(items: getItems())
    }
}



