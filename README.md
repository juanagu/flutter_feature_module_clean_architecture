# [WIP] Flutter project with Feature module and clean architecture

## Test

### Unit
    * flutter test
## Automation (BDD)
    * flutter drive --target=test_driver/app.dart
    
## Run and building commands
 Run: 
 * flutter run -t lib/main_dev.dart 

 Build:
 * flutter build -t lib/main_dev.dart

## Git commit message conventions

 *Commit message template:*
 ```
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
or "Fixes bug."  This convention matches up with commit messages generated
by commands like git merge and git revert.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, followed by a
  single space, with blank lines in between, but conventions vary here

- Use a hanging indent

If you use an issue tracker, add a reference(s) to them at the bottom,
like so:

Resolves: #123

```
 -- Guide:
 - Specify the type of commit:
 -- feat: The new feature you're adding to a particular application
 -- fix: A bug fix
 -- style: Feature and updates related to styling
-- refactor: Refactoring a specific section of the codebase
-- test: Everything related to testing
-- docs: Everything related to documentation
-- chore: Regular code maintenance.[ You can also use emojis to represent commit types]
-  Separate the subject from the body with a blank line
-  Your commit message should not contain any whitespace errors
-  Remove unnecessary punctuation marks
-  Do not end the subject line with a period
-  Capitalize the subject line and each paragraph
-  Use the imperative mood in the subject line
-  Use the body to explain what changes you have made and why you made them.
-  Do not assume the reviewer understands what the original problem was, ensure you add it.
-  Do not think your code is self-explanatory

## Workflow
 1. Create a task if the ticket doesn't exist 
 2. Create a new branch from master with the name of Task-ID
 3. Programming with TDD and complete the task or resolve the bug. 
 4. Run "flutter analyze"
 5. Run "flutter test"
 6. Test on iOS & Android "flutter drive --target=test_driver/app.dart" 
 7. If all the checks are ok create a PR to master

## VSCode configurations:

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Flutter Dev Profile",
            "type": "dart",
            "request": "launch",
            "program": "lib/main_dev.dart",
            "args": [
                "--profile",
            ]
        },
        {
            "name": "Flutter Dev",
            "program": "lib/main_dev.dart",
            "request": "launch",
            "type": "dart",
        }
    ]
}
```

## Lecture:
 * [Clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
 * [Component Principles](https://blog.heron.me/component-principles-b943d7bf8b28)
 * [SOLID Principles](https://medium.com/tech-tajawal/s-o-l-i-d-the-first-5-principles-of-ood-c0e743b9e54e)
 * [Clean code](https://medium.com/mindorks/how-to-write-clean-code-lessons-learnt-from-the-clean-code-robert-c-martin-9ffc7aef870c)
 * [Refactoring](https://medium.com/@dhkelmendi/refactoring-from-zero-to-hero-57f24d294eba)
 * [Feature toogles](https://martinfowler.com/articles/feature-toggles.html)
 * [Replacing Throwing Exceptions with Notification in Validations](https://martinfowler.com/articles/replaceThrowWithNotification.html)
 * [Trunk Based Development - TBD](https://www.youtube.com/watch?v=aNgWjSAjjtg)
 * [Test Driven Development - TDD](https://medium.com/hackernoon/introduction-to-test-driven-development-tdd-61a13bc92d92)
 

