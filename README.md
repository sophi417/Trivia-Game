# Project 5 - *Trivia Game*

Submitted by: **Sophia Sartor**

**Trivia Game** is an app that lets users play trivia using the Open Trivia Database. Users pick their options, answer questions on cards, and get a score at the end.

Time spent: **5** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App launches to an Options screen where user can modify the types of questions presented when the game starts. Users should be able to choose:
  - [x] Number of questions
  - [x] Category of questions
  - [x] Difficulty of questions
  - [x] Type of questions (Multiple Choice or True False)
- [x] User can tap a button to start trivia game, this presents questions and answers in a List or Card view.
  - Hint: For Card view visit your FlashCard app. List view is an equivalent to UITableView in UIKit. Much easier to use!
- [x] Selected choices are marked as user taps their choice (but answered is not presented yet!)
- [x] User can submit choices and is presented with a score on trivia game
 
The following **optional** features are implemented:

- [x] User has answer marked as correct or incorrect after submitting choices (alongside their score).
- [x] Implement a timer that puts pressure on the user! Choose any time that works and auto submit choices after the timer expires. 

The following **additional** features are implemented:

- [x] Each card shows the question number and category
- [x] Timer turns red in the last 10 seconds

## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://youtube.com/shorts/AW9TgU6As-4?feature=share

## Notes

The API sent special characters as codes like &quot; so I used encode=url3986 and decoded the text in the app. I also had to add import Combine for the timer to work.

## License

    Copyright 2026 Sophia Sartor

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
