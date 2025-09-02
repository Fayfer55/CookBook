//
//  ButtonedTextField.swift
//  CookBook
//
//  Created by Kirill Faifer on 21.07.2025.
//

import UIKit

class ButtonedTextField: UITextField {
    
    override var text: String? {
        didSet {
            onTextChange(self)
        }
    }
    
    // MARK: - UI Elements
    
    private let strokeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.systemBlue.cgColor
        layer.fillColor = nil
        layer.lineCap = .round
        layer.lineJoin = .round
        layer.lineWidth = 2
        return layer
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupParentView()
        
        layer.addSublayer(strokeLayer)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        addTarget(self, action: #selector(onTextChange), for: .editingChanged)
        addTarget(self, action: #selector(onTextFieldTap), for: .editingDidBegin)
        directionalLayoutMargins = .halfSafeArea
    }
    
    private func updateUnderline() {
        let text = text ?? ""
        let font = font ?? UIFont.systemFont(ofSize: 17)
        let textSize = text.size(withAttributes: [.font: font])
        
        strokeLayer.frame = bounds
        strokeLayer.path = underlinePath(width: textSize.width)
    }
    
    private func underlinePath(width: CGFloat) -> CGPath {
        guard width != .zero else { return UIBezierPath().cgPath }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: width, y: bounds.maxY))
        return path.cgPath
    }
    
    // MARK: - Actions
    
    @objc
    private func onTextFieldTap(_ textField: UITextField) {
        recignButton()
    }
    
    @objc
    private func onTextChange(_ textField: UITextField) {
        updateUnderline()
    }
    
    // MARK: - Helpers
    
    func becomeButton() {
        // TODO: - implement
    }
    
    func recignButton() {
        // TODO: - implement
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    let textField = ButtonedTextField()
    textField.placeholder = "New item"
    return textField
}
