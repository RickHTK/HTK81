
//import UIKit
import SwiftUI















// KEYBOARD
// View of the Harmonica being played recieves the note being played by the conductor (state object)
// Called by Tuner



//KEYBOARD Calls Button Array -- Called by Tuner View
func keyboardView (keyboardButtonArray: [[interfaceButton]]) -> some View {
    
    var body: some View {
        VStack (spacing: 3) {
            
            ForEach (keyboardButtonArray, id:\.self) { buttonRow in
                HStack (spacing: 3) {
                    ForEach(buttonRow, id:\.self) { buttonKey in
                        buttonKey
                    } // END OF INNER LOOP
                    
                }// END OF HSTACK

        } //END OF OUTER LOOP
            
    } //END OF VSTACK
        
    
}

return body

}

struct KeyboardView : View {
    
    var buttonArray: [[interfaceButton]]
    
    var body: some View {
        VStack (spacing: 3) {
            
            ForEach (buttonArray, id:\.self) { buttonRow in
                HStack (spacing: 3) {
                    ForEach(buttonRow, id:\.self) { buttonKey in
                        buttonKey
                    } // END OF INNER LOOP
                    
                }// END OF HSTACK

        } //END OF OUTER LOOP
            
    } //END OF VSTACK
        
    
}


}

