//
//  ContentView.swift
//  Essay I Say-ios14
//
//  Created by Smalli ARM on 7/1/20.
//

import SwiftUI


extension EssayISay {
    public enum Classifier: String, CaseIterable {
        case
            essays = "Essay Types",
            openClosequestions = "Open/Closed Question",
            aspects = "Aspects",
            voices = "Voices",
            times = "Times"
    }
}


struct ContentView: View {
    @ObservedObject var essayISay = EssayISay()
    
    @State private var inputString: String = "" {
        didSet {
            essayISay.inputString = inputString
        }
    }
    
    @State private var classificiationSelection: Int = 2
    
    @Namespace private var animations
    
    var options = EssayISay.Classifier.allCases.map{ $0 }
    
    @State private var textEditorGradientStops = Gradient.Stop.init(color: Color(.sRGB, red: 0.395, green: 0.762, blue: 0.38, opacity: 0.9), location: CGFloat.random(in: 0...1))
    
    @State private var scrollViewEditorGradient = Gradient.Stop.init(color: Color(.sRGB, red: 0.495, green: 0.662, blue: 0.78, opacity: 0.9), location: CGFloat.random(in: 0...1))
    
    @State private var userLog: [String] = [] {
        willSet {
            print(newValue.description)
            
        }
    }
    
    @State private var isShowingLog: Bool = false
    @State private var isLogAlertShowing = false
    @State private var scaleEffect: (CGFloat, CGFloat) = (0, 1)
    @State private var unreadLogs: Int = 0 {
        didSet {
            if self.unreadLogs > 0 {
                isLogAlertShowing = true
            }
            else if self.unreadLogs <= 0 {
                isLogAlertShowing = false
            }
        }
    }
    
    var isValidInput : Bool {
        let removedWhiteSpace = inputString.filter { char in
            char != " "
        }
        return removedWhiteSpace.count > 5 && inputString.split(separator: " ").count > 3
    }

    
    var body: some View {
        Group{
            
            
            ScrollView {
                
                RadialGradient(gradient: Gradient(stops: [textEditorGradientStops]), center: .center, startRadius: CGFloat.pi*2, endRadius: CGFloat.pi*0.2)
                    .cornerRadius(30)
                
                ZStack{
                    RadialGradient(gradient: Gradient(stops: [textEditorGradientStops]), center: .center, startRadius: CGFloat.pi*2, endRadius: CGFloat.pi*0.2)
                        .cornerRadius(30)
                    HStack{
                        
                        HStack {
                            VStack {
                                Button {
                                    // Code
                                } label: {
                                    // Label
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                
                                Button {
                                    // Code
                                } label: {
                                    // Label
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                            }
                        }
                        TextEditor(text: $inputString)
                            .frame(width: 300, height: 200, alignment: .center)
                            .font(.system(size: 17, weight: Font.Weight.medium, design: Font.Design.rounded))
                            .onChange(of: inputString) { value in
                                withAnimation{
                                    essayISay.clearPredictionOutput()
                                }
                            }
                            .padding(.all, 10)
                        VStack {
                            
                        }
                        HStack {
                            VStack {
                                Button {
                                    // Code
                                    clearTextEditor()
                                } label: {
                                    // Label
                                    Image.init(systemName: "clear")
                                        .foregroundColor(.red)
                                        .font(.title)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                               
                                
                                .offset(x: 0, y: -40)
                            
                                
                                Button {
                                    // Code
                                    self.isShowingLog.toggle()
                                } label: {
                                    // Label
                                    Image.init(systemName: "doc.text.magnifyingglass")
                                        .renderingMode(.original)
                                        .font(.title)
                                        .overlay(
                                            Circle()
                                                .fill(Color.red)
                                                .overlay(
                                                    Text("\(self.unreadLogs)")
                                                        .font(.system(size: 17, weight: Font.Weight.bold, design: Font.Design.serif))
                                                        .foregroundColor(Color.black)
                                                )
                                                .offset(CGSize(width: 15.0, height: -20.0))
                                                .scaleEffect((!self.isLogAlertShowing ? scaleEffect.0 : scaleEffect.1), anchor: .center)
                                        )
                                        
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                
                                .sheet(isPresented: self.$isShowingLog, onDismiss: {
                                    withAnimation {
                                        self.unreadLogs = 0
                                    }
                                }) {
                                    NavigationView {
                                        
                                        
                                        if self.userLog == [] {
                                            Text("EMPTY LOG")
                                                .font(.headline)
                                                .underline()
                                                .bold()
                                                .navigationBarTitle(Text("Log"))
                                        } else {
                                            
                                            List {
                                                ForEach(0..<self.userLog.count, id: \.self) { index in
                                                    
                                                    NavigationLink(
                                                        destination: Text("Read"),
                                                        label: {
                                                            
                                                            Text(self.userLog[index])
                                                            
                                                        })
                                                    
                                                }
                                            }.navigationBarTitle(Text("Log"))
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                }.padding(.all, 10)
                
                if essayISay.predictionOutput != "Type here!" {
                    VStack {
                        Text("Prediction:\n")
                            .font(.custom("Cochin", size: 20, relativeTo: Font.TextStyle.callout))
                            .matchedGeometryEffect(id: "PredictionTextLabel", in: animations)
                        Text(essayISay.predictionOutput)
                            .background(
                                Rectangle()
                                    .cornerRadius(3.0)
                                    .foregroundColor(.init(white: 0.8))
                                    .font(.system(size: 30, weight: Font.Weight.heavy, design: Font.Design.monospaced))
                                    .matchedGeometryEffect(id: "PredictionTextOutput", in: animations)
                            )}}
                
                
                Text("Choose Classification")
                    .underline()
                    .font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.serif))
                    .offset(x: 0, y: 30)
                
                Picker(selection: $classificiationSelection, label: Text("Classification Picker")) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(EssayISay.Classifier.allCases[index].rawValue).tag(index + 1)
                    }
                }
                .labelsHidden()
                .onChange(of: classificiationSelection) { value in
                    withAnimation{
                        self.hideKeyboard()
                        self.essayISay.clearPredictionOutput()
                    }
                }
                
                
                Button(action: {
                    withAnimation{
                        if isValidInput {
                            self.essayISay.getResults(self.inputString, classifierType: EssayISay.Classifier.allCases[classificiationSelection])
                        } else {
                            withAnimation {
                                self.userLog.append("\(self.unreadLogs). Try writing a full sentence!")
                                self.unreadLogs += 1
                            }
                        }
                        self.hideKeyboard()
                    }
                }, label: {
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(.green)
                        .overlay(
                            Text("Classify")
                                .font(.system(size: 24, weight: Font.Weight.medium, design: .serif))
                                .foregroundColor(.init(Color.RGBColorSpace.sRGB, white: 0, opacity: 0.7))
                        )
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 10)
                })
                .cornerRadius(10)
                .padding(.all,2)
                .background(Color.white)
            }
        }
        .background(Color.init(.sRGB, white: 0.1, opacity: 0.2))
        .onTapGesture {
            withAnimation{
                self.hideKeyboard()
            }
        }
        
        
    }
    
    
    func clearTextEditor() {
        withAnimation{
            inputString = ""
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




