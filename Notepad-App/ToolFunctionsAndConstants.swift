//
//  ToolFunctionsAndConstants.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 27/11/20.
//

import Foundation
import UIKit

struct ToolFunctionsAndConstants {
    static func convertToUIColor(from stringValue : String) -> UIColor? {
        return UIColor(hexString: stringValue)
    }
}
