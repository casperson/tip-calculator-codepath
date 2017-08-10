Tipped 💸
A tip calculator.

# Pre-work - Tipped 💸

Tipped 💸 is a tip calculator application for iOS.

Submitted by: Braden Casperson

Time spent: 13 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Added a history in the settings menu to be able to see past transactions. They are saved with a bar button.
- [x] Gradually shift colors for red with a low tip amount, to green with a higher tip amount.
- [x] Auto-layout to work in portrait on iPhone SE up through iPhone 7+

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src="http://imgur.com/V5t5L7Z" title='Region Change' width='' alt='Region Change' />

<img src="http://imgur.com/0STY0AW" title='Region Change' width='' alt='Region Change' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** iOS Development is pretty neat. Xcode makes things very easy with storyboards. An outlet is basically saving a UI element to a variable. That way you can simply edit the properties of the UI element object through the variable, while still being able to create the element through the storyboard. An action is similar, except it is a function that you want to run when you interact with an element on the UI. Under the hood, it's simply creating a new custom xml connection to a certain destination.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** ARC allocates a portion of memory for every new class instance. When you create a new variable and assign a class instance to it, then a strong reference is made, meaning that class instance will not be deallocated as long as that variable is still referencing the class instance. If there is only one variable that references a class instance and you set that variable to something else, then and only then will the memory being used to hold that class instance be deallocated.


## License

Copyright 2017 Braden Casperson

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
