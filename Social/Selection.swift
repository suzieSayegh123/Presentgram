//
//  Selection.swift
//  Social
//
//  Created by User on 20/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import SwiftUI

enum Selection: Int, CaseIterable, Identifiable {
    case grid
    case table
    
    var id: UUID {
        return UUID()
    }
    
    var image: Image {
        switch self {
        case.grid:
            return Image(systemName: "square.grid.2x2.fill")
        case.table:
            return Image(systemName: "list.dash")
    }
}
}
