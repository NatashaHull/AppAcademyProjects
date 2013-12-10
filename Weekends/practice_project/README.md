Follower App/Authentication Practice Project
==============================
This is an application that I programmed in under 2 hours which has all the basic features of authentication as well as a handful of features relevant for following other users.

Features of this app include:

* Profile page
  * The profile page shows a list of people user is following and people who
    are following that user.
  * Each user can only see his/her own list of followers and followees.
* Sign-up
  * The submit button on the Sign-up page creates a name, username, and password on sign-up and a new user
* Sign-in
  * Sign-in is handled by the SessionsController
  * Sign-in requires a username and password
* FollowingsController
  * Each user sees buttons to follow, or unfollow, other users
    (depending on whether or not they are currently following that user).
  * The `follow` and `unfollow` actions are controlled by the `FollowingsController`
