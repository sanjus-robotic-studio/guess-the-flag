import SwiftUI
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var totalQuestions = 0
    @State private var GameOver = false
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("You have guessed all the flags correctly!", isPresented: $GameOver) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            if score == 8{
                GameOver = true
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        totalQuestions += 1
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame() {
        countries.shuffle()
        totalQuestions = 0
        GameOver = false
        score = 0
        correctAnswer = Int.random(in: 0...2)
    }
}
