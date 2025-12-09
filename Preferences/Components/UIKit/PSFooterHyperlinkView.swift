//
//  PSFooterHyperlinkView.swift
//  Preferences
//

import SwiftUI

struct PSFooterHyperlinkView: UIViewRepresentable {
    let footerText: String
    let linkText: String
    let linkURL: String = "pref://"
    let hideLinkPreview: Bool = true
    let onLinkTap: (() -> Void)?
    
    func makeUIView(context: Context) -> UIView {
        guard dlopen("/System/Library/PrivateFrameworks/Preferences.framework/Preferences", RTLD_NOW) != nil else {
            return UIView()
        }
        
        guard let specifierClass = NSClassFromString("PSSpecifier"),
              let specifier = specifierClass.alloc() as? NSObject else {
            return UIView()
        }
        
        specifier.perform(NSSelectorFromString("init"))
        
        let setPropertySelector = NSSelectorFromString("setProperty:forKey:")
        specifier.perform(setPropertySelector, with: footerText, with: "footerText")
        specifier.perform(setPropertySelector, with: URL(string: linkURL)!, with: "headerFooterHyperlinkButtonURL")
        
        if let range = footerText.range(of: linkText) {
            let nsRange = NSRange(range, in: footerText)
            specifier.perform(setPropertySelector, with: "{\(nsRange.location), \(nsRange.length)}", with: "footerHyperlinkRange")
        }
        
        if hideLinkPreview, let callback = onLinkTap {
            context.coordinator.callback = callback
            specifier.perform(setPropertySelector, with: NSStringFromSelector(#selector(Coordinator.customAction)), with: "footerHyperlinkAction")
            specifier.perform(setPropertySelector, with: NSValue(nonretainedObject: context.coordinator), with: "footerHyperlinkTarget")
        }
        
        guard let footerViewClass = NSClassFromString("PSFooterHyperlinkView"),
              let footerView = footerViewClass.alloc() as? UIView else {
            return UIView()
        }
        
        footerView.perform(NSSelectorFromString("initWithSpecifier:"), with: specifier)
        
        for subview in footerView.subviews {
            subview.directionalLayoutMargins = .zero
        }
        
        return FooterLayoutUIView(view: footerView)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject {
        var callback: (() -> Void)?
        
        @objc func customAction() {
            callback?()
        }
    }
}

final class FooterLayoutUIView: UIView {
    let view: UIView

    init(view: UIView) {
        self.view = view
        super.init(frame: .zero)
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = .zero
        view.layoutMargins = .zero
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    override var intrinsicContentSize: CGSize {
        let availableWidth = bounds.width > 0 ? bounds.width : (window?.windowScene?.screen.bounds.width ?? 320)
        
        return view.systemLayoutSizeFitting(
            CGSize(width: availableWidth, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
}
