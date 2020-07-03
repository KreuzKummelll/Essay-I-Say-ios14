//
//  EssayISay.swift
//  Essay I Say-ios14
//
//  Created by Smalli ARM on 7/1/20.
//

import Foundation


final class EssayISay: ObservableObject {
    
    @Published var inputString : String? = ""
    @Published var predictionOutput: String = ""
    
    public func clearPredictionOutput() {
        predictionOutput = ""
    }
    
    public func getResults(_ text: String, classifierType: Classifier) {
        
        
        
        switch classifierType {
        case .essays:
            let model_essay = EssayClassifier()
            do {
                let prediction = try model_essay.prediction(text: text)
                predictionOutput = prediction.label
            } catch {
                predictionOutput = "Problem classifying your essay."
            }
        case .openClosequestions:
            let model_questions = EndedQuestionClassifier()
            do {
                let prediction = try model_questions.prediction(text: text)
                //                print(prediction.label)
                predictionOutput = prediction.label
            } catch {
                predictionOutput = "Problem classifying your question."
            }
        case .aspects:
            let model_aspects = AspectClassifier()
            do {
                let prediction = try model_aspects.prediction(text: text)
                //                print(prediction.label)
                predictionOutput = prediction.label
                
            } catch {
                predictionOutput = "Problem classifying your question."
            }
        case .voices:
            let modelVoice = VoiceClassifier()
            do {
                let prediction = try modelVoice.prediction(text: text.lowercased())
                //                print(prediction.label)
                predictionOutput = prediction.label
                
            } catch {
                predictionOutput = "Problem classifying your question."
            }
        case .times:
            let modelTimes = TimeClassifier()
            do {
                let prediction = try modelTimes.prediction(text: text)
                //                print(prediction.label)
                predictionOutput = prediction.label
                
            } catch {
                predictionOutput = "Problem classifying your question."
            }
        }
    }
    
}
