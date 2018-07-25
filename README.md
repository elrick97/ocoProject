# ocoProject
Take a 10 question cabron footprint quiz, and depending on your results you will get feedback in notification to help you shrink it.
​
## Audience
The app audience is targeted to all people who wants to make a difference with small actions.
​
## Experience
A user opens the app and the first thing he does is to make this questionary, after this the user will get feedback on his results and through the week you will get personalized notifications with little actions or tips that can help you make a difference. This way every sunday will show a summary of his progress and will recive an email with all of the users data together representing the total change.
​
# Technical
## Models
"User" Firebase
	- Name: String
	-email: String
	-[quizScore]: Int
	-quizAverage: Int
	-password: String
"Quiz" Struct
	-Questions: String
	-Answers: String
	-Result: Int
"Question" Struct
	-Question: String
	-Answer: Int
​
## Views
HomeStoryboard - Where you can see graphically how much is your footprint going 
 QuizStoryboard - Where you are going to solve the quiz
 LoginStoryboard - Login flow storyboard
 Profile - Where you can give feedback on what you have been doing
​
## Controllers
HomeViewController
QuizViewcontroller
LoginViewController
ProfileViewController
​
## Other
Not sure what framework to use, but we need graphs and something beautiful for the quiz
​
# Weekly Milestone
## Week 4 - Usable Build
List of tasks needed to be complete before you can start user testing
- Finish up the quiz flow
- Give you feedback on your result with graph
- Login flow
- [...]
​
## Week 5 - Finish Features
[Work on UI]
- colors
- logo
- email feature
- notifications
- [...]
​
## Week 6 - Polish
[Fix every bug]
- Run tests
- Submit to appstore
- Make necesarry changes
- [...]
