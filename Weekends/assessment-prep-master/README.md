# Assessment Prep

At App Academy, your progress will be measured by periodic assessments. 
The assessments are designed to test the level of understanding of the current
material, and to ensure that you are on track to enter the workplace by week nine.

Assessment provide you with feedback about your progress, and give you an early indicator 
if you are falling behind. To get an accurate reading, it is important that you study hard
and push yourself during the test.

**PRO TIP**: `Command + K` will clear the console's output, so scrolling to the top of RSpec specs becomes faster.

### Lather, Rinse, Repeat

Practicing for assessments is all on you!

1. Run the specs for the practice assessment
2. Start a timer
3. Write solutions to the specs (in order if possible) until they are all passing
4. Stop timer and evaluate your time
5. Open and look at the solutions
6. Close the solutions
7. Repeat until your time is acceptable

It really helps to focus on hitting on one spec at a time. Try not to think ahead too much.
It's easy to get stuck trying to tackle all seven specs for some method; instead you should 
run the tests frequently focus only on hitting the first failing spec. 
Warning: don't take this as
_dogma_, sometimes you will have to hit specs out of order, skip sections of the spec, or 
find it faster to pass multiple specs at a time.

## W2D1 - Assessment 1
**How to prepare**: Follow the lather, rinse, repeat for the assessment [specs](./a01-practice/spec/assessment01_spec.rb). Practice reading the spec file as it will help you understand what the assessment is testing for. 

**Topics**: 
* iteration
* recursion
* blocks and procs
* methods
* sorting
* searching
* Array
* String
* pass by reference

**Resources**:
* [practice][a1]
* [solutions][a1-soln]

W2D3 - Assessment 1 retake for those at or below the threshold.

## W3D1 - Assessment 2
**How to prepare**: Follow the lather, rinse, repeat for the practice specs. This assessment will be more complex than the last and has multiple spec files. The recommended aproach is to run each spec individually. This will give you more manageable output. Read the instructions. The instructions will contain a suggested order in which specs should be run.

RSpec has been covered and you may not have really dug into how it works... It behooves you to look at the RSpec content as it will help you understand what the specs expect. Most specifically test doubles, `subject`, and `let`.

**Topics**:
* inheritance
* encapsulation
* polymorphism
* error handling, exceptions
* decomposition

**Resources**:
* [practice][a2]
* [solutions][a2-soln]

W3D3 - Assessment 2 retake

## W4D1 - Assessment 3
**How to prepare**: Do sql zoo. A Lot.

**Topics**:
* SELECT
* FROM
* WHERE
* GROUP BY
* HAVING
* JOIN (left, inner)
* DISTINCT
* COUNT
* SUM

**Resources**:
* [practice at SQLZOO][sql-zoo]

## W5D3 - Assessment 4
**How to prepare**: Know Auth!!! Authentication, basic CRUD (Create, Read, Update, Delete) operations in ruby on rails. Lather, Rinse, Repeate the practice assessment and learn how to read the [capybara][capybara] specs.

Helpful commands:
`bundle exec rspec spec/features/*_spec.rb`
`rake db:migrate`
`rake db:test:prepare`

**Topics**:
* authentication
* authorization
* layouts
* helpers
* model
* view
* controller
* associations
* validations
* error rendering

**Resources**:
* [practice][a4]
* [solutions][a4-soln]

W5D5 - Assessment 4 retake

[capybara]: https://github.com/jnicklas/capybara

## W7D1 - Assessment 5
**How to prepare**: Practice running [jasmine][jasmine-github] specs ([Additional tutorial][jasmine-tutorial]). 

**Topics**:
* recursion
* iteration
* callbacks
* bind, call, apply
* inheritance
* namespacing

**Resources**:
* [practice][a5]
* [solutions][a5-soln]
* [jasmine test examples][a5-ex]

[jasmine-tutorial]: http://evanhahn.com/how-do-i-jasmine/
[jasmine-github]: http://pivotal.github.io/jasmine/

**TODO**
+ TODO: double check the schedule
+ TODO: pretty it up
+ TODO: check for broken links
+ TODO: review the summary of how to prep for each assessment
+ TODO: review the material covered
+ TODO: review the prep for assessment 05
+ TODO: Assessment05 retake day?

[a1]: ./a01-practice
[a1-soln]: ./a01-practice-soln
[a2]: ./a02-practice
[a2-soln]: ./a02-practice-soln
[sql-zoo]: http://sqlzoo.net/wiki/Main_Page
[a4]: ./a04-practice
[a4-soln]: ./a04-practice-soln
[a5-ex]: ./a05-examples
[a5]: ./a05-practice
[a5-soln]: ./a05-practice-soln
