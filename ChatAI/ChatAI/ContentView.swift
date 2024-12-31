//
//  ContentView.swift
//  ChatAI
//
//  Created by Nishanth on 30/07/24.
//

import SwiftUI
import GoogleGenerativeAI
struct ContentView: View {
    private let model = GenerativeModel(name: "gemini-pro", apiKey: AppKey.apiKey)
    @State private var textInput = ""
    @State private var aiResponse:LocalizedStringKey = "Hello! How can I help you today?"
    @State private var activityView: Bool = false
    var body: some View {
        ZStack{
            VStack {
                Image("AI2")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 200)
                
                
                ScrollView{
                    Text(aiResponse)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.white)
                        .shadow(color: .black,radius: 1, x: 1, y: 1)
                        .multilineTextAlignment(.center)
                }
                
                HStack(content: {
                    TextField(" Enter a message", text: $textInput)
                        .foregroundStyle(Color.black)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    Button(action: {
                        
                        self.sendMessage()
                    }, label: {
                       Image(systemName: "paperplane.fill")
                    })
                })
            }
            .foregroundStyle(Color.white)
            .padding()
            .background {
                ZStack(content: {
                   Image("AI2")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        
                    Color(.black)
                        .opacity(0.6)
                        .ignoresSafeArea()
                        .background(.ultraThinMaterial)
                })
                .ignoresSafeArea()
            }
            
            if(activityView){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                    .scaleEffect(2)
            }
        }
    }
    
    private func sendMessage(){
        self.activityView = true
        aiResponse = ""

        Task{
            do{
                let response = try await model.generateContent(textInput)
                guard let result = response.text else{
                    aiResponse = "Sorry some error happened"
                    return
                }
                
                textInput = ""
                self.activityView = false
                aiResponse = LocalizedStringKey(result)
            }
            catch{
                self.activityView = false
                aiResponse = "Something went wrong please try again"
            }
        }
    }
}

#Preview {
    ContentView()
}
