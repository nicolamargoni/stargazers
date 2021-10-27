# Stargazers iOS Application

This is a iOS project that includes:

- MVVM
- Cocoapods for dependency manager
- Dependency Injection
- Moya for easy and fast network request
- SwiftUI for interfaces
- Unit Test
- Integration Test
- UI Test


# What's inside.
This is a simple application that implement MVVM Clean architecture. The application allows you to view the list of users who have left a star on a Github repository, the so-called "Stargazers", by entering the owner and the name of the repository. 

# What do you need to start

All you need to start with this project is

- Xcode 
- Cocoapods

If you don't have cocoapods on your mac, or you don't know what cocoapod is, check this out https://cocoapods.org/

# Let's start

1  
After cloning project from Github, open terminal and navigate in project folder, then install all pods with command.

> pod install

When all pods are installed, open project by digit on terminal

> open Stargazers.xcworkspace


# External Library

These are the libraries used in project with github url and a very short description.

 LIBRARY| URL | DESCRIPTION
 -------- | --- | -----------
 Moya | https://github.com/Moya/Moya | An easy-to-use HTTP networking library
 # External resource

Github API (Stargazer List)(https://docs.github.com/en/rest/reference/activity#list-stargazers)
