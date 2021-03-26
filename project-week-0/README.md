# DD1349 Week 0
## Planning Your Project!
You still have some time left to get finished with Pallinda, but we are going to go through the project during the övning this week wether you like it or not!  

An important aspect of working on an actual project is that not all work is to write code, this is something you're all going to learn with this course (Because god forbid you learn this the hard way in MDI or MVK) and is the main focus of this weeks assignment.

![You guys](https://media.discordapp.net/attachments/683743508888420383/824768069137596436/FB_IMG_1614381517077.jpg)


## Assignment This Week
### Prepare your project
Yes! The task this week is only to prepare for the project. This is so that you can work on pallinda and the project in parallel while haveing time for both!

Keep on reading to find more detailed descriptions of some of these steps!

1. Find or create a group of 2-4 students
2. Decide what you want to do 
3. Write a specification
   * Do this now or after step `7.`
4. Create a github repo under `INDAPlus20` named: `<student1>-...<-studentX>-project`
5. Create a "project" in the github repo. Or create a Trello
6. Create Github milestones for each week
7. Polulate you "project" and milestones
   * Right now, just a little bit is fine. You will improve on this later


## The Project
### Github Project / Trello
These services are _very_ similar. They allow you to create different boards where you can organize cards. Imagine having a digital bulletin board where the world is your oyster!

![This](https://i.pinimg.com/originals/59/78/05/597805a79c234f3be72ef16594b350fc.jpg)

For example, you could have "boards" like:
   * Todo
   * In progress
   * Complete

Where each "card" would have nothing more than a name describing the feature.

The above would be a minimum and could be expaned to something like:

  * Wishes / Hopes and Dreams / If We Have Time
  * MVP (Minimum Viable product)
  * Member1
  * Member2
  ...
  * MemberX
  * Complete
  * Abandoned

Where each card contains not just a name, but also a description of what that feature is. For example, if a card is moved to abandoned, explain why it has been moved there.

### Milestones
Github has a feature called Milestones, found under `issues`. 

Whenever you create an issue on github you can connect it to a Milestone. Milestones are essentially a way to keep track of, well, milestones, but using Issues! It's just a glorified way of grouping issues together.

You can use this feature to determine what should be done on a weekly basis. This would mean having a Milestone for each Week that you work on this project. Alternatively, you can give names to the milestones. These names could be something like:

* MVP
* Playable
* An actual good project
* A finished project
* Extra features

### Specification
Writing project specs is a good practice to follow, however, thats not only why you do them now. For the first week, your group should write a specification and send it to your TA. This is _primarily_ so that we know what each group is up to and so that we can keep track of your progress from early on. 

The report should be in `.md` or `.pdf` format (LaTeX anyone?) and placed in your repo. It should contain the following:

* Any links to the repo (yes, recursion) or Trello if that is used
* Your specification should specify what naming convencion you will use for both:
    * Issues & Commits
      * Issues (and commit messages) are (by github standard) in future tense, i.e `"Fix this bug"` not `"Fixed this bug"` and can be named however you like, as long as they describe the issue itself. Recommended is short titles with a more elaborate description.
    * PR's
      * Pull Requests should be named after an associated issue. Given an issue `#13, "Improve performance"`, I would create the branch using `$ git switch -c issue/13-improve-performance`. It is up to your group if you wish to follow this our use a different convention.
* Most importantly, tell us what you are going to create in your project. You should include a short part about how feasible your project is and how it can be divided into weeks.
* Who is going to do what?

### Pace
We will/have structure(d) the project in such a way that you must do work every week. This is to eliminate that you save yourself only to grind something out the last week, this is not proper practice and not how we do things! This happened a lot for `game-task-12` and `13`, and while it was okay (and expected) there, it is _not_ for a course with the _main_ focus on project work!


## Project Criteria
Aside from the assignment for this week, you are required to achieve the following by the end of the course.

### Project Level
Your project should be advanced enough to pass!

Pong is too simple.

Tetris is good enough for 2 people, not 3 or 4.

The rest explains itself. Motivate why your project is advanced enough!

### Use the Issue tracker!
For every feature you want to create (or bug to fix), there should be an associated issue, hopefully the next few paragraphs will explain why.

  * Follow your naming convention. Assign assignees and attach labels, it looks cool! 
    * **Do not** forget to add issues to milestones, this can be done under the menu for each issue. 
  * Read on about branches to know how to close an issue the good way!

#### Connect to milestones and PR's
To provide structure for your projects, it is good practice to use this feature (described above).

### Use Branches (Pull Requests)!
There is no such thing as working together properly on github without using branches. Therefore we require you to master the following:

* Follow your naming convention!
* `$ git switch`
  * Switch to a branch! Add `-c <branch_name>` to create a new branch!
* Pushing on a branch that is **not** master (main) will create a Pull Request on Github
  * Use the web interface to merge and approve branches (A PR created by `student1` should be approved by another student before merging!).
  * While doing this, you can add labels to branches and connect them to issues!

![Also you](https://media.discordapp.net/attachments/683743508888420383/824771151699247154/FB_IMG_1616176133946.jpg?width=810&height=801)

Using branches is important when working together but it also has some other features:
* Use branches to close issues!
  * Before merging a branch, add (for example) `Fix #13` to the description of the Pull Request. Github will automatically read the word `[Ff]ix` and the number of an issue and close it!
  * You can also just write `#13` to _mention_ an issue without closing it. This will create a link between different pages on github.
    * Note: You can also mention PR's from issues.
  * All of the above can also be done in commit messages, but are not as important.

* If you are really picky, you can _lock_ your repo to only allow merging into master using PR's.
  * You can also make it so only a user _other_ than the one who created the PR can merge it.

### Use Github Projects or Trello!
To keep an overview of your project, you should use one of these services (described above).

## Some ideas:
Most student groups create games, but here are some ideas you could try!

* Generate captcha images!

![Idea1](https://media.discordapp.net/attachments/683743508888420383/824769079554342972/FB_IMG_1613350138811.jpg)
