---
title: "Java • AssertJ vs Hamcrest Assertion Frameworks"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/27/java-assertj-vs-hamcrest-assertion.html
category: java
related: java
description: "A detailed comparison of Java's AssertJ and Hamcrest assertion frameworks, with examples and best practices for writing assertions in your tests."
---

## Overview

When working with testing frameworks like _JUnit_ or _TestNG_, selecting the right _assertion framework_ can significantly enhance the _readability_ of your _test code_ and improve the overall quality of your tests. Two of the most popular _Java assertion frameworks_ are _AssertJ_ and _Hamcrest_.<!--excerpt--> In this article, we will provide an in-depth comparison of these two frameworks, highlighting their respective features, strengths, and examples of how to implement them in your test cases.

<a id='vKc_41nYRZpcuf2dXg2QkQ' class='gie-single' href='http://www.gettyimages.com/detail/1705600203' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'vKc_41nYRZpcuf2dXg2QkQ',sig:'sodmF0l-eauftWfAMfZKTB5vXZIDMO5apACUn1KXdmM=',w:'550px',h:'200px',items:'1705600203',caption: true ,tld:'com',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>

## AssertJ Assertion Framework

_AssertJ_ is a powerful and flexible _Java library_ designed to enhance the _readability_ of your _test code_ by providing a rich set of _assertion methods_. These methods allow you to write more concise and human-readable _assertions_ for your tests.

### Features of AssertJ

1. **Fluent API** - _AssertJ_ provides a _fluent API_ that makes it easy to chain multiple _assertions_ together, creating a more readable and concise test case.
2. **Custom Assertions** - With _AssertJ_, you can create _custom assertions_ tailored to your specific needs, providing greater flexibility in your test cases.
3. **Wide Range of Assertions** - _AssertJ_ is renowned for its extensive array of assertions, meticulously designed to cater to various data types and testing needs. It provides a comprehensive set of assertions for common data types like objects, arrays, lists, and maps, as well as for more complex data structures.
4. **Detailed Error Messages** - _AssertJ_ generates _good error messages_ that help to quickly identify the cause of a failed test.
5. **Allows for custom error messages** - enables developers to create personalized error messages that are specific to each test case
6. **String Substitutions** - Supports string substitutions in error messages, providing a more flexible and tailored approach to communicating test failures.

### Example of AssertJ

Consider a scenario where you need to validate that a list of strings contains specific elements:

```java
List<String> languages = Arrays.asList("Java", "Python", "C++");

assertThat(languages)
  .hasSize(3)
  .contains("Java")
  .doesNotContain("Ruby");
```

## Hamcrest Assertion Framework

_Hamcrest_ is another popular _Java assertion framework_ known for its use of _matcher objects_ to create _readable assertions_. This framework is also compatible with _JUnit_ and _TestNG_, and provides a different approach to writing _assertions_.

### Features of Hamcrest

1. **Matcher Objects** - _Hamcrest_ uses _matcher objects_ to create expressive and readable _assertions_.
2. **Composability** - _Hamcrest_ allows you to compose multiple _matcher objects_ together to create more complex _assertions_.
3. **Wide Range of Matchers** - _Hamcrest_ provides a wide range of predefined _matcher objects_ that can be used to validate different types of data.
4. **Custom Assertions** - With _Hamcrest_, you have the ability to craft _custom assertions_ that are precisely aligned with your unique requirements.
5. **Allows for custom error messages** - enables developers to create personalized error messages that are specific to each test case

### Example of Hamcrest

In the same scenario as before, you can use _Hamcrest_ to validate the list of strings as follows:

```java
List<String> languages = Arrays.asList("Java", "Python", "C++");

assertThat(languages, hasSize(3));
assertThat(languages, hasItem("Java"));
assertThat(languages, not(hasItem("Ruby")));
```

## Ease of Use With IDEs

When it comes to integration with _IDEs_ (Integrated Development Environments), both _Hamcrest_ and _AssertJ_ provide a user-friendly experience, but there are some differences in how they operate that may influence your choice.

#### Hamcrest

_Hamcrest_ requires you to static import individual assertions, which means you need to know the name of the specific assertion you want to use. This can sometimes make it less convenient, especially if you are unfamiliar with all the available assertions.

Example of using Hamcrest with static import:

```java
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

List<String> languages = Arrays.asList("Java", "Python", "C++");

// Hamcrest assertion
assertThat(languages, hasSize(3));

// JUnit 5 assertion
assertEquals(3, languages.size());

// Additional Hamcrest example
assertThat(languages, contains("Java", "Python", "C++"));
```

Note that the _Hamcrest_ version of _assertThat(arg1, arg2)_ is not designed to be _fluent_ like the _AssertJ_ or other testing libraries, which may affect the readability and ease of chaining multiple assertions together.

#### AssertJ

On the other hand, _AssertJ_ simplifies this process by requiring you to only static import the Assertions class. Once you've done this, you can use the _assertThat(actual)_ method, and the IDE will automatically trigger the available methods when you type a period. This autocompletion feature makes it easier to discover and use the various assertions provided by _AssertJ_.

Example of using AssertJ with static import:

```java
import static org.assertj.core.api.Assertions.*;

List<String> languages = Arrays.asList("Java", "Python", "C++");
assertThat(languages)
  .hasSize(3)
  .contains("Java");
```

## Comparison of Assertion Failure Messages

When a test fails, the output of the assertion failure message is crucial for quickly identifying the cause of the failure. Here, we will compare the output of an assertion failure message in both _Hamcrest_ and _AssertJ_.

#### Hamcrest

_Hamcrest_ provides clear and concise failure messages that describe what was expected and what was actually received. However, some developers find that these messages can sometimes be a bit limited in detail.

Example of a Hamcrest assertion failure message:

```
java.lang.AssertionError: 
Expected: is <3>
     but: was <2>
```

#### AssertJ

_AssertJ_, on the other hand, is known for providing detailed and informative failure messages that help to quickly pinpoint the cause of a failed test.

Example of an AssertJ assertion failure message:

```
java.lang.AssertionError: 
Expecting:
 <2>
to be equal to:
 <3>
but was not.
```

As seen from the examples above, both _Hamcrest_ and _AssertJ_ provide clear failure messages, but _AssertJ_ tends to offer more detailed and helpful information. This detailed output can be particularly beneficial when debugging complex tests with multiple assertions, as it can help you quickly understand what went wrong and where to look to fix the issue.

## Customizing Error Messages in Assertions

An important aspect to consider when choosing an assertion framework is the ability to customize error messages, and whether the framework supports string substitutions within these messages. Custom error messages are crucial as they provide clear and specific feedback when a test fails, making it easier to understand the context and cause of the failure.

#### AssertJ

_AssertJ_ shines in this aspect as it allows you to provide custom error messages for each assertion, and it supports string substitutions, making your error messages more informative and tailored to your specific test cases.

Example of AssertJ custom error message with string substitution:

```java
import static org.assertj.core.api.Assertions.assertThat;

public class CustomErrorMessageTest {
  @Test
  public void testName() {
    String name = "Alice";
    assertThat(name)
      .overridingErrorMessage("Expected name to be Bob, but was %s", name)
      .isEqualTo("Bob");
  }
}
```

In this example, if the test fails, it will display the message "Expected name to be Bob, but was Alice".

#### Hamcrest

_Hamcrest_ also allows for custom error messages, but it doesn't directly support string substitutions in the same way that AssertJ does.

Example of Hamcrest custom error message:

```java
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class CustomErrorMessageTest {
  @Test
  public void testName() {
    String name = "Alice";
    assertThat("Expected name to be Bob", name, equalTo("Bob"));
  }
}
```

In this case, if the test fails, it will display the message "Expected name to be Bob".

To sum up, both AssertJ and Hamcrest allow for custom error messages, but AssertJ takes it a step further by also supporting string substitutions within these messages, offering a more flexible and powerful way to communicate the context of test failures.

## Writing Custom Assertions

The ability to write custom assertions is a powerful feature that allows developers to create more expressive and domain-specific tests. Both _Hamcrest_ and _AssertJ_ offer this capability, but there are some differences in their approach and ease of implementation.

#### Hamcrest

In _Hamcrest_, custom assertions are created by implementing a matcher class. This allows you to define the specific behavior and failure message for your assertion. However, this process can sometimes be more involved and require more boilerplate code compared to _AssertJ_.

Example of a custom Hamcrest assertion:

```java
import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;

public class IsEven extends TypeSafeMatcher<Integer> {
  @Override
  protected boolean matchesSafely(Integer number) {
    return number % 2 == 0;
  }

  @Override
  public void describeTo(Description description) {
    description.appendText("an even number");
  }
}
```

Usage of custom Hamcrest assertion:

```java
import static org.hamcrest.MatcherAssert.assertThat;
import static org.example.IsEven.isEven;

public class CustomAssertionTest {
  @Test
  public void testIsEven() {
    assertThat(4, isEven());
  }
}
```

#### AssertJ

_AssertJ_ takes a slightly different approach to custom assertions by providing a fluent API that makes it easier to chain together multiple conditions. This results in less boilerplate code and more readable tests.

Example of a custom AssertJ assertion:

```java
import org.assertj.core.api.AbstractIntegerAssert;

public class IntegerAssert extends AbstractIntegerAssert<IntegerAssert, Integer> {
  public IntegerAssert(Integer actual) {
    super(actual, IntegerAssert.class);
  }

  public IntegerAssert isEven() {
    isNotNull();
    if (actual % 2 != 0) {
      failWithMessage("Expected an even number but was <%s>", actual);
    }
    return this;
  }
}
```

Usage of custom AssertJ assertion:

```java
import static org.example.IntegerAssert.assertThat;

public class CustomAssertionTest {
  @Test
  public void testIsEven() {
    assertThat(4).isEven();
  }
}
```

In conclusion, while both _Hamcrest_ and _AssertJ_ provide the ability to create custom assertions, _AssertJ_ tends to offer a more straightforward and flexible approach that can lead to more readable and maintainable tests.


In conclusion, while both frameworks are designed to be user-friendly and integrate well with IDEs, _AssertJ_ has a slight edge in terms of ease of use due to its simpler static import process and the helpful autocompletion feature that assists developers in finding the right assertions for their tests.

## AssertJ vs Hamcrest: Which to Choose?

The choice between _AssertJ_ and _Hamcrest_ largely depends on personal preference and the specific requirements of your project. Here are some crucial differences that could help guide your decision:

1. **Fluent API**
    - _AssertJ_ offers a fluent and chainable API, frequently resulting in test cases that are more concise and readable.
2. **Custom Assertions**
    - Both _AssertJ_ and _Hamcrest_ provide the functionality to create custom assertions. However, _AssertJ_ typically has a more straightforward approach, which often means less boilerplate code.

3. **Matcher Objects**
    - _Hamcrest_ is praised for its expressive matcher objects, which enhance the readability of assertions. _Hamcrest_'s expressive language helps in writing tests that read more like natural language, which can be particularly beneficial when working in a team or when you need to share your test results with non-technical _stakeholders_.

4. **Error Messages**
    - _AssertJ_ is reputed for producing detailed error messages, aiding significantly in debugging failed tests.

5. **String Substitutions in Error Messages**
    - _AssertJ_ supports string substitutions in custom error messages, adding an extra layer of flexibility and clarity when communicating test failures.

Each framework has its own strengths and weaknesses, and the best choice depends on your specific needs and preferences.

Ultimately, the decision of which assertion framework to choose—be it _AssertJ_ or _Hamcrest_—rests in the hands of the development team. It is important for the team to carefully evaluate the specific needs of their project, the familiarity of team members with the framework, and the workflow that they are comfortable with. 

Each framework has its own unique features and benefits, and what works for one team might not necessarily be the best fit for another. Therefore, it is crucial for teams to weigh the pros and cons, experiment with both options if possible, and then make an informed decision that aligns with their project requirements and team dynamics.

## In Conclusion

Both _AssertJ_ and _Hamcrest_ are exceptional _Java assertion frameworks_ that serve to improve the readability and quality of your test cases, albeit in different ways. _AssertJ_ stands out with its fluent API and the flexibility it offers in creating custom assertions, while _Hamcrest_ shines with its expressive matcher objects and extensive range of predefined matchers. The decision to choose one over the other ultimately lies with the development team, taking into consideration their project requirements, workflow, and personal preferences. Each framework has its own merits and can significantly enhance the testing experience when utilized effectively.
