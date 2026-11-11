//
//  TripDestinationLayout.swift
//  Wena
//
//  Created by Michelle Nathania on 11/11/26.
//

import SwiftUI
import WenaDesignSystem

struct TripDestinationLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        arrangement(width: proposal.width, subviews: subviews).size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangement(width: bounds.width, subviews: subviews)
        for (view, item) in zip(subviews, result.items) {
            view.place(at: CGPoint(x: bounds.minX + item.origin.x, y: bounds.minY + item.origin.y),
                       anchor: .topLeading, proposal: ProposedViewSize(item.size))
        }
    }

    private func arrangement(width: CGFloat?, subviews: Subviews) -> (size: CGSize, items: [CGRect]) {
        let limit = width ?? .greatestFiniteMagnitude
        let spacing = WenaSpacing.space8
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var usedWidth: CGFloat = 0
        var items: [CGRect] = []
        for view in subviews {
            let size = view.sizeThatFits(ProposedViewSize(width: width, height: nil))
            if x > 0 && x + size.width > limit {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            items.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            usedWidth = max(usedWidth, x + size.width)
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        return (CGSize(width: width ?? usedWidth, height: y + rowHeight), items)
    }
}
