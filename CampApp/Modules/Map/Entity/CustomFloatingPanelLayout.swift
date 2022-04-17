//
//  CustomFloatingPanelLayout.swift
//  CampApp
//
//  Created by Nurullah Vural on 12.03.2022.
//

import Foundation
import FloatingPanel

public class CustomFloatingPanelLayout: FloatingPanelLayout {
    public let position: FloatingPanelPosition = .bottom
    public let initialState: FloatingPanelState = .tip
    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 25, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 75, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
