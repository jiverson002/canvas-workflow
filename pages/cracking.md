---
title: "Password cracking"
permalink: /exercises/cracking/
toc: true
---

**Disclaimer.** The program that you develop for this exercise should **NOT** be considered a measure of the strength of a particular password. An obvious example would be the password '*P@ssw0rd*', which, according to the program, would take 147.53338 centuries to crack, but in practice would be among the first passwords checked by any cracker worth their salt.
{: .notice--warning}

## TL;DR
Implement a program to calculate the number of passwords that can be constructed from some alphabet, as well as the time it would take to search the entire password space assuming a cracking program capable of some number of guesses per second.

## Learning objectives
This exercise is designed to help you learn about (and assess whether you have learned about):
* how to understand a problem.
* how to write an algorithm for solving a problem.
* how to write a simple program in Java using variables, conditions, loops, and terminal output.
* how to create test cases that can be used to verify the correctness of an algorithm.

As a practical matter, this exercise will help you become comfortable with the various policies (including submission policies and grading policies) that you must comply with while working on them and the various tools you will use while working on them.

Lastly, this exercise will give you a better understanding and appreciation for password composition.

## Background
Have you ever wondered why many websites have password requirements like:
* be a minimum of 8 and a maximum of 16 characters
* must contain at least one
  * upper-case letter,
  * lower-case letter,
  * number, and
  * special character: ! $ / % @ #
  
They are an attempt to prevent users from choosing passwords that are easy to guess. In this context, it will not be a person guessing, but rather a machine running a cracking program, capable of thousands or millions of guesses per second. It turns out that when requirments like this are not enforced people tend to pick easily guessable passwords. According to many sources, some of the most popular passwords are:
* password
* 123456
* qwerty
* monkey
* password1

By requiring the inclusion of certain groups of characters, it prevents the use of passwords such as those listed above, at least in their most obvious form. If a cracking program is unable to quickly guess a password based on a dictionary of common passwords, it is necessary to use *brute-force* to guess the password, i.e., check all possible passwords that satisfy the requirements.

A useful exercise for any computer literate person interested in the security of their password protected identity is to determine how many possible passwords could be constructed from a given set of requirements, and how long it would take a cracking program to check all such passwords. The total number of passwords of length *L* that can be created from an alphabet of size *C* can be expressed as:

[1] *C*<sup>*L*</sup>.

Using equation [1], the time it would take for a cracking program, capable of *G* guesses per second, to check all passwords of minimum length *N* and maximum length *M* can be expressed as:

[2] (*C*<sup>*N*</sup>+*C*<sup>*N*+1</sup>+&#8943;+*C*<sup>*M*</sup>)/*G*.

Keep in mind that this is not an indication of how long it would take to crack a particular password, only of how long to search the entire password space. It is conceivable that any given password will be found in less time than that indicated. Still, it allows one to compare the effect of alphabet size and password length on the search space and time.

## Instructions
You are to write a program, called `Main`, using the example below as a starting point. For this problem, the alphabet size will be dictated by the variable `PROTOTYPE`, that will contain a string of characters representing the different *classes* of characters allowed in a password. Possible character classes are:
* lower-case letters [a-z],
* upper-case letters [A-Z],
* digits [0-9], and
* special characters [!$/%@#].

It will be your job to compute the total size of the alphabet from the value of `PROTOTYPE` by increasing the alphabet size by an appropriate amount based on which classes it contains. In the example below, the alphabet size would be 26 because `PROTOTYPE` only contains lower-case letters, of which there are 26. For simplicity, we will assume that the minimum password length is always one and that the maximum length is the length of `PROTOTYPE`.

```java
/**
 * A program to compute the length of time it would take to brute force a
 * password, given the search space of possible passwords.
 */
public class Main
{
  /**
   * The password prototype --- defines the alphabet based on which character
   * classes it includes.
   */
  public static String PROTOTYPE = "aaaa";
  /**
   * The number of guesses per second that the cracking program is capable of.
   */
  public static double G = 1000.0;
  
  // ...
}
```

To find out if a [`String`](https://docs.oracle.com/javase/7/docs/api/java/lang/String.html) contains any one of a set of characters, you can use the [`matches(String regex)`](https://docs.oracle.com/javase/7/docs/api/java/lang/String.html#matches(java.lang.String)) method. In this case, the argument `regex` should be one of the following, depending on the character class your are checking for:
* lower-case letters `".*[a-z].*"`,
* upper-case letters `".*[A-Z].*"`,
* digits `".*[0-9].*"`, or
* special characters `".*[!$/%@#].*"`.

The characters `.*` before and after the brackets enclosing the character set will include matches found anywhere in the `String` object that the method is being called on.

Your program should output **EXACTLY** two lines to the console. The first line should report the size of the search space, i.e., total number of passwords that can be constructed, and the second should report the time to search the entire space. The output format of your program should **EXACTLY** match the following example:
```sh
Search space size: 1558868884
Time to search:    2.57749 weeks
```
which can be produced by the following two lines of Java code:
```java
System.out.println("Search space size: " + size);                       
System.out.println("Time to search:    " + String.format("%.5f", time) + " " + unit);
```
where `size`, `time`, `unit` are three variables that represent the search space size, the time to search, and the units for the time respectively.

To make your program more user friendly, it should present the time to search using the most appropriate unit of measurement from the following list:
* seconds,
* minutes,
* hours,
* days,
* weeks,
* years, or
* centuries.

For example, if the number of seconds to search the space is less than 60, it should use the unit *seconds*, however if it is greater than 60, but less than 60\*60=3600, then it should use the unit *minutes* and so on, all the way up to *centuries*. To keep things consistent, we will define a year as 52 weeks.

## Testing
One of the most important tasks when developing a piece of software is to test it to ensure its correctness. To this end, you should create a set of test cases to test your code under different conditions. For this exercise, the test cases will be different values of the variable `PROTOTYPE`. You should manually compute the search space size and time to search for each of the test cases, and then check your results against those of your program. Some examples of test cases might be:
* `"aaaa"`
* `"AAAA"`
* `"0000"`
* `"!!!!"`
* `"aA0!"`

Be judicious about your choice of test cases, so that you are not repeating calculations that will ulitmately produce the same results. For example, it is probably not necessary to check both `"aaaa"` and `"bbbb"` since they define the same alphabet and have the same maximum length.

If you are satisfied with your set of test cases and your program is producing correct results, then your set of test cases is inadequate. If you have found a test case for which your program produces incorrect output, or you cannot come up with any such cases after thinking about it for some time, then you should download and run this [testing program](TODO).

After downloading the testing program to the directory where you developed your own program, make sure that your program is compiled, and click the `Test` button in DrJava. This will run your program using a pre-defined set of test cases and report whether or not your program produced the correct output. The testing program should report two failures (test8 and test9). If it reports more, then you should address each of them until only these two remain.

## Improvements
At this point, you have a program worthy of up to 94%. To be eligible for full-marks, you must do one last thing &mdash; improve your code so that it passes all but test9 in the testing program. For your information, the cause of failure is the same for test8 and test9, however, the solution to test8 is much more straight-forward than that of test9.

## FAQs
None so far. Reload this page periodically to check if any arise.
