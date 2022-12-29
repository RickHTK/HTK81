import SwiftUI






struct SplashView: View {
    
    @State private var isContentReady = false
    
    var body: some View {
        ZStack {
            if self.isContentReady {
            
                //newviewcontroller()
                ContentView()
            } else {
                VStack(spacing: 0) {
                    Image("HTK-icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
                    Image("HTK Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 217,
                               height: 120)
                }
            }
        }
        .onAppear {
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 1) { // To control time on splashview
                    withAnimation(.easeInOut(duration: 1.0)) {
                    self.isContentReady.toggle()
            
                }
            }
        }
    }
}


/*
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
*/
