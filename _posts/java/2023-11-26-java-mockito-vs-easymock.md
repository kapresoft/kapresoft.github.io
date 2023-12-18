---
title: "Java • Mockito vs EasyMock"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/11/26/java-mockito-vs-easymock.html
category: java
related: java
description: "Explore Java testing frameworks: Compare Mockito's ease & EasyMock's precision in our detailed guide."
---

## Overview

<a href="https://www.java.com/" target="_blank">Java</a>, a widely-used programming language, has evolved significantly over the years, especially in the realm of testing. In this digital era, where software development is fast-paced and highly iterative, the importance of efficient and reliable testing frameworks cannot be overstated. Among the various tools and libraries available for Java developers, <a href="https://site.mockito.org/" target="_blank">Mockito</a> and <a href="https://easymock.org/" target="_blank">EasyMock</a> stand out as popular choices for unit testing.<!--excerpt-->

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/java-mockito-vs-easymock-aadaf33.webp" alt="Java • Mockito vs EasyMock">
</div>

These frameworks are instrumental in simplifying the process of creating mock objects in unit tests. Mock objects are essential for testing the behavior of Java classes in isolation, especially when they interact with external systems or dependencies. The choice between Mockito and EasyMock often boils down to specific project requirements and personal preference, as each offers unique features and capabilities.

In the following sections, we'll delve into a comprehensive comparison of Mockito and EasyMock. We'll explore their core features, ease of use, performance, and scenarios where one might be more suitable than the other. This analysis aims to provide Java developers with the insights needed to make an informed decision when selecting a mocking framework for their projects.

## Introduction to Mockito & EasyMock

In the world of Java development, testing is a critical component that ensures the reliability and quality of software. Two prominent frameworks that have gained traction for creating mock objects in unit testing are Mockito and EasyMock. Understanding these tools and their roles in Java testing is essential for developers looking to improve their testing strategies.

### Quick Overview of Mockito

Mockito is a modern, open-source testing framework in Java that focuses on simplicity and ease of use. It is specifically designed for mock creation, verification, and stubbing in tests. One of the key strengths of Mockito is its straightforward and readable syntax, which makes writing tests more intuitive. Mockito allows developers to write clean and maintainable tests by providing clear and concise APIs. It is well-suited for tests where behavior verification is needed and is particularly popular for its 'spy' feature, which enables partial mocking of objects.

Here's a short code example that provides a quick overview of Mockito:

```java
import static org.mockito.Mockito.*;

// Create a mock object for a fictional UserService class
UserService userServiceMock = mock(UserService.class);

// Define an expected behavior for the mock
when(userServiceMock.getUserById(1)).thenReturn(new User("John"));

// Perform an action using the mock
User user = userServiceMock.getUserById(1);

// Verify that the mock was called with the expected method and argument
verify(userServiceMock).getUserById(1);

// Check the result
assertEquals("John", user.getName());
```

In this example, we create a mock object for a fictional _UserService_ class using Mockito. We then define an expected behavior for the mock using the _when_ method, specifying that when the _getUserById_ method is called with an argument of _1_, it should return a _User_ object with the name "John." We then use the mock to retrieve a user and verify that the _getUserById_ method was called with the expected argument. Finally, we check the result to ensure it matches our expectations.

This code demonstrates the simplicity and ease of use of Mockito for creating mock objects and verifying their behavior in Java unit tests.

### Quick Overview of EasyMock

EasyMock, another well-established framework in the Java ecosystem, is known for its ability to create dynamic mock objects. It operates on the principle of recording and replaying actions to validate the behavior of classes under test. EasyMock's approach involves setting up expectations in a record phase and then switching to a replay phase to verify that the expected actions occur. This framework is often praised for its robustness in handling complex mocking scenarios and its compatibility with a wide range of testing environments.

Here's a short code example that provides a quick overview of EasyMock:

```java
import static org.easymock.EasyMock.*;

// Create a mock object for a fictional OrderService class
OrderService orderServiceMock = createMock(OrderService.class);

// Define an expected behavior for the mock
Order order = new Order(1, "Product A", 100.0);
expect(orderServiceMock.getOrder(1)).andReturn(order);

// Switch to the replay phase
replay(orderServiceMock);

// Perform an action using the mock
Order result = orderServiceMock.getOrder(1);

// Verify that the mock was called with the expected method and argument
verify(orderServiceMock);

// Check the result
assertEquals(1, result.getId());
assertEquals("Product A", result.getProduct());
assertEquals(100.0, result.getPrice(), 0.01);
```

In this example, we create a mock object for a fictional _OrderService_ class using EasyMock. We then define an expected behavior for the mock during the record phase, specifying that when the _getOrder_ method is called with an argument of _1_, it should return an _Order_ object with specific attributes. After setting up the expectations, we switch to the replay phase using the _replay_ method.

Next, we use the mock to retrieve an order, and finally, we verify that the _getOrder_ method was called with the expected argument using the _verify_ method. We also check the result to ensure it matches our expectations.

This code demonstrates EasyMock's approach of recording and replaying actions to validate the behavior of classes under test, making it suitable for testing complex mocking scenarios in Java.

### The Role of These Frameworks in Java Testing

Both Mockito and EasyMock play a crucial role in the Java testing landscape by simplifying the process of dealing with dependencies. They allow developers to isolate the class under test by replacing its dependencies with mock objects. This isolation is vital for unit testing, as it ensures that tests are not affected by external factors and that each test case verifies only the behavior of the unit under test. The choice between Mockito and EasyMock can influence the design and readability of test cases, as well as the overall testing experience. As such, understanding the nuances, strengths, and limitations of each framework is key to leveraging them effectively in Java testing strategies.

## Core Features of Mockito

Mockito is a highly acclaimed framework in the Java community for its ability to simplify the process of mocking in unit tests. Here, we will explore some of the core features of Mockito, accompanied by Java code examples to demonstrate its practical application in testing.

### Key Features of Mockito

1. **Simple Mock Creation:** Mockito allows for the easy creation of mock objects for interfaces and classes, which is fundamental in unit testing.

2. **Argument Matchers:** Mockito provides a variety of argument matchers to specify conditions under which method calls are considered valid.

3. **Behavior Driven Development (BDD) Support:** Mockito supports BDD methodologies, allowing for more readable and maintainable tests.

4. **Verification of Interactions:** It allows developers to verify the number and types of interactions that occur between objects.

5. **Exception Handling:** Mockito can be used to simulate exceptions in order to test error handling logic.

6. **Spying on Real Objects:** Mockito can create spies on real objects, where only specific behaviors are stubbed or verified.

### Examples of Usage in Java Testing

#### Example 1: Simple Mock Creation

```java
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;
import java.util.List;

public class SimpleMockTest {
    @Test
    public void testMockCreation() {
        // Creating a mock object
        List<String> mockedList = mock(List.class);

        // Using the mock object
        mockedList.add("one");
        mockedList.clear();

        // Verification
        verify(mockedList).add("one");
        verify(mockedList).clear();
    }
}
```

In this example, a mock of a _List_ interface is created and used. The _verify_ method checks whether the specified interactions (_add_ and _clear_) have occurred.

#### Example 2: Argument Matchers

```java
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;

public class ArgumentMatcherTest {
    @Test
    public void testArgumentMatcher() {
        List<String> mockedList = mock(List.class);

        // Using the mock with an argument matcher
        mockedList.add(anyString());

        // Verification with the matcher
        verify(mockedList).add(anyString());
    }
}
```

Here, _anyString()_ is an argument matcher that matches any String. It's useful when the exact argument value is not relevant for the test.

#### Example 3: Exception Handling

```java
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;

public class ExceptionHandlingTest {
    @Test
    public void testExceptionSimulation() {
        List<String> mockedList = mock(List.class);

        // Stubbing to throw an exception
        when(mockedList.get(0)).thenThrow(new RuntimeException());

        try {
            mockedList.get(0);
        } catch (RuntimeException e) {
            // Exception handling logic here
        }
    }
}
```

This example shows how to stub a method to throw an exception, allowing the testing of exception handling logic.

#### Example 4: Spying on Real Objects

```java
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;

public class SpyTest {
    @Test
    public void testSpy() {
        List<String> list = new ArrayList<>();
        List<String> spyList = spy(list);

        // Using the spy to add an element
        spyList.add("one");
        spyList.add("two");

        // Verify method was called
        verify(spyList).add("one");

        // Get the size using the real implementation
        assertEquals(2, spyList.size());
    }
}
```

In this scenario, a spy is created on a real _ArrayList_ object. The real method implementations are used, but specific interactions can still be stubbed or verified.

These examples demonstrate just a few of the powerful features offered by Mockito, illustrating its flexibility and utility in Java unit testing.


## Core Features of EasyMock

EasyMock is another prominent framework in the Java testing landscape, known for its ability to create dynamic mock objects for effective unit testing. Below, we'll explore the core features of EasyMock, complemented by Java code examples to illustrate how these features can be applied in real-world testing scenarios.

### Key Features of EasyMock

1. **Record and Replay Model:** EasyMock operates on a record-replay model, where you first record the expected behaviors and then replay to verify them during the test.

2. **Flexible Argument Matching:** Like Mockito, EasyMock provides argument matchers for specifying conditions for method calls.

3. **Exception Handling:** EasyMock allows for easy simulation of exceptions to test error handling.

4. **Mocking Interface and Classes:** It can mock both interfaces and classes, giving a wide range of flexibility in testing various components.

5. **Integration with Testing Frameworks:** EasyMock seamlessly integrates with popular testing frameworks like JUnit.

### Examples of Usage in Java Testing

#### Example 1: Record and Replay Model

```java
import static org.easymock.EasyMock.*;
import org.junit.jupiter.api.Test;

public class RecordAndReplayTest {
    @Test
    public void testRecordAndReplay() {
        // Creating a mock object
        List<String> mockedList = createMock(List.class);

        // Recording expected behaviors
        expect(mockedList.add("one")).andReturn(true);
        expect(mockedList.size()).andReturn(1);
        replay(mockedList);

        // Using the mock object
        mockedList.add("one");
        int size = mockedList.size();

        // Verification
        verify(mockedList);
        assertEquals(1, size);
    }
}
```

This example shows the record-replay model of EasyMock. The expected behaviors (_add_ and _size_) are recorded, and then the mock is used in the test, followed by verification.

#### Example 2: Argument Matchers

```java
import static org.easymock.EasyMock.*;
import org.junit.jupiter.api.Test;

public class ArgumentMatcherTest {
    @Test
    public void testArgumentMatcher() {
        List<String> mockedList = createMock(List.class);

        // Using matchers during recording phase
        expect(mockedList.add(anyString())).andReturn(true);
        replay(mockedList);

        // Using the mock object
        mockedList.add("any string");

        // Verification
        verify(mockedList);
    }
}
```

In this example, _anyString()_ is used to represent any string argument, demonstrating the flexibility of argument matchers in EasyMock.

#### Example 3: Exception Handling

```java
import static org.easymock.EasyMock.*;
import org.junit.jupiter.api.Test;

public class ExceptionHandlingTest {
    @Test
    public void testExceptionSimulation() {
        List<String> mockedList = createMock(List.class);

        // Expecting an exception
        expect(mockedList.get(0)).andThrow(new RuntimeException());
        replay(mockedList);

        try {
            mockedList.get(0);
        } catch (RuntimeException e) {
            // Exception handling logic
        }

        // Verification
        verify(mockedList);
    }
}
```

This code demonstrates how to set up a mock to throw an exception, useful for testing how your code handles unexpected scenarios.

#### Example 4: Mocking Classes

```java
import static org.easymock.EasyMock.*;
import org.junit.jupiter.api.Test;

public class MockingClassTest {
    @Test
    public void testMockingClass() {
        // Mocking a class
        ArrayList<String> mockedList = createMock(ArrayList.class);

        // Setting expectations
        expect(mockedList.size()).andReturn(2);
        replay(mockedList);

        // Using the mock
        assertEquals(2, mockedList.size());

        // Verification
        verify(mockedList);
    }
}
```

In this example, we demonstrate how to mock a class (_ArrayList_) instead of an interface, showcasing EasyMock's capability to handle both.

These examples provide a glimpse into the versatility and functionality of EasyMock in Java testing, offering a comprehensive approach to creating mock objects and verifying interactions in unit tests.


## Comparison Between Mockito and EasyMock

When it comes to Java unit testing, choosing the right mocking framework can significantly impact the efficiency and clarity of your tests. Mockito and EasyMock are two of the leading choices, each with its own strengths and nuances. Let's compare them across several key aspects: ease of use and setup, syntax and readability, integration with other tools, and community support and documentation.

### Ease of Use and Setup

**Mockito:**
- **Pros:** Mockito is often praised for its simplicity and minimal setup requirements. It uses straightforward annotations and is generally considered more intuitive for beginners.
- **Cons:** Some advanced features might require a steeper learning curve.

**EasyMock:**
- **Pros:** EasyMock is reliable for more complex mocking scenarios, especially with its record and replay model.
- **Cons:** This record-replay approach can be less intuitive for newcomers and might lead to a bit more boilerplate code.

### Syntax and Readability

**Mockito:**
- **Pros:** Mockito's syntax is highly readable and aligns closely with natural language, making the tests easier to understand. The BDD support enhances this readability.
- **Cons:** Some advanced features can introduce complexity in syntax.

**EasyMock:**
- **Pros:** Provides clear distinctions between phases of test (record, replay, verify), which can be helpful in understanding test flow.
- **Cons:** The record-replay model can sometimes lead to verbose and less intuitive code, especially for those not familiar with it.

### Integration with Other Java Tools and Frameworks

**Mockito:**
- **Pros:** Excellently integrates with a wide range of Java testing frameworks like JUnit and TestNG. Its popularity ensures good support for integration with other tools.
- **Cons:** Some integrations might require additional configuration or setup.

**EasyMock:**
- **Pros:** Like Mockito, integrates well with major Java testing frameworks and is versatile in different development environments.
- **Cons:** May have slightly less integration support due to its lower popularity compared to Mockito.

### Community Support and Documentation

**Mockito:**
- **Pros:** Has a large and active community. The documentation is extensive and regularly updated, making it easier to find help and resources.
- **Cons:** The vastness of resources can sometimes be overwhelming to sift through for specific issues.

**EasyMock:**
- **Pros:** Well-documented with a dedicated user base. Offers detailed guidance for various mocking scenarios.
- **Cons:** The community is smaller compared to Mockito, which might affect the speed of troubleshooting unique problems.

### Comparison Summary

Both Mockito and EasyMock offer robust solutions for mocking in Java unit tests, but their approach and user experience differ. Mockito stands out for its ease of use and readability, making it a favorite among developers who prefer straightforward syntax and quick setup. EasyMock, with its explicit record-replay model, appeals to those who appreciate a more structured approach to mocking, especially useful in complex scenarios.

The choice between Mockito and EasyMock ultimately depends on personal preference, the specific requirements of your project, and your comfort with the testing framework's style and capabilities. Both frameworks are capable tools in the Java developer's arsenal, contributing significantly to the efficacy and clarity of unit tests.

## Use Case Scenarios

Selecting between Mockito and EasyMock for your Java testing needs often depends on the specific use case scenario of your project. Each framework has its unique strengths that make it more suitable for certain types of testing environments and requirements. Let's explore some scenarios where one might be more advantageous over the other, along with real-world examples.

### When to Use Mockito

1. **For Simplicity and Quick Setup:**
    - **Scenario:** If you're working on a project where quick development and testing are crucial, and the mocking requirements are not exceedingly complex, Mockito is an excellent choice. Its straightforward setup and intuitive syntax make it ideal for rapid development cycles.
    - **Example:** In a web application where you need to mock service layer interactions for controller testing, Mockito allows for fast and readable mocks, speeding up the development process.

2. **Behavior-Driven Development (BDD):**
    - **Scenario:** Mockito is particularly beneficial in projects that follow Behavior-Driven Development methodologies. Its syntax and annotations are conducive to writing tests that are more readable and aligned with business requirements.
    - **Example:** When writing tests for a user story in an Agile project, Mockito's BDD-style mocks can align the tests closely with the acceptance criteria of the story.

3. **Partial Mocking (Spying):**
    - **Scenario:** Mockito is preferable when you need to spy on real objects, i.e., when you want to mock certain behaviors of a class while keeping others unchanged.
    - **Example:** In a scenario where you're testing a complex class but only need to mock certain external method calls, Mockito's spying capabilities allow for partial mocking without needing to mock the entire object.

### When to Use EasyMock

1. **For Complex Mocking Scenarios:**
    - **Scenario:** EasyMock shines in situations where the mocking requirements are complex, especially when you need explicit control over the mock's behavior across different phases of the test.
    - **Example:** In testing legacy systems where the interactions are intricate and you need to mock several layers of interactions precisely, EasyMock's record and replay model offers the necessary control and granularity.

2. **Structured Approach to Mocking:**
    - **Scenario:** Projects that benefit from a more structured and phased approach to mocking, such as enterprise-level applications with multiple dependencies, may find EasyMock more suitable.
    - **Example:** In an enterprise application with extensive service layers and DAOs (Data Access Objects), EasyMock can help define clear expectations and verifications for each layer's interactions.

3. **Explicit Verification Phase:**
    - **Scenario:** When the testing strategy emphasizes the importance of the verification phase separately from the setup or arrangement phase of the mock, EasyMock’s explicit separation of these phases is advantageous.
    - **Example:** In a banking application, where verifying the precise sequence of method calls and interactions is crucial, EasyMock’s distinct phases help ensure the accuracy and order of operations.

### Summary for Use Case Scenarios

In summary, Mockito is often the go-to for quick, straightforward, and readable unit testing, especially in agile and rapid development environments. EasyMock, on the other hand, is more suited for complex scenarios where a structured approach to mocking and an explicit verification phase are required. Both frameworks have their places in the Java testing world, and the choice between them should be guided by the specific requirements and nuances of the project at hand.

## Performance and Efficiency

Performance and efficiency are critical factors when choosing a mocking framework for Java unit testing, especially in large-scale and resource-intensive projects. Mockito and EasyMock, while similar in their fundamental purpose, exhibit different characteristics in terms of execution speed, resource usage, and scalability. Let's compare these two frameworks from a performance and efficiency standpoint.

### Execution Speed and Resource Usage

**Mockito:**
- **Execution Speed:** Mockito is generally known for its fast execution speed. Its straightforward approach to mocking and the absence of a record-replay phase contribute to this efficiency.
- **Resource Usage:** Mockito tends to be lightweight in terms of resource usage. It doesn't require significant memory overhead, making it suitable for tests where resource conservation is crucial.

**EasyMock:**
- **Execution Speed:** The execution speed of EasyMock is generally competitive, but it can be slightly slower in complex scenarios due to the overhead of its record-replay model.
- **Resource Usage:** EasyMock might consume more resources in cases of extensive mocking or when dealing with large objects, as it needs to record interactions before replaying them.

### Scalability in Large Projects

**Mockito:**
- **Scalability:** Mockito scales well in large projects due to its simplicity and ease of integration. Its straightforward syntax and behavior make it easier to maintain and understand tests in large codebases.
- **Large Projects:** In projects where numerous and diverse unit tests are needed, Mockito's clear and concise approach minimizes the cognitive load and helps maintain high test coverage with less effort.

**EasyMock:**
- **Scalability:** While EasyMock is robust, its record-replay model can become cumbersome in very large projects. The need to explicitly record expected behaviors for each mock can lead to verbose and complex test setups.
- **Large Projects:** In complex applications where the precise control of mock behavior is essential, EasyMock's detailed approach is advantageous. However, it might require more effort to maintain and understand the tests as the project grows.

### Summary for Performance and Efficiency

In terms of performance and efficiency, **Mockito generally offers faster execution and less resource consumption**, making it a favorable choice in scenarios where these factors are prioritized. EasyMock, while slightly more resource-intensive, provides a level of control and precision that can be crucial in complex testing scenarios.

**The scalability aspect also favors Mockito**, particularly in large-scale projects where maintaining a large suite of tests with minimal overhead is important. **EasyMock**, on the other hand, could be **more suited for projects where the complexity and detail of the interactions being tested are more critical than the sheer size of the test suite**.

Ultimately, the choice between Mockito and EasyMock for performance and efficiency should be based on the specific needs of the project, considering factors like the complexity of tests, the scale of the project, and the resources available.

## Conclusion

In the realm of Java unit testing, both Mockito and EasyMock offer powerful capabilities for creating mock objects, but they cater to slightly different needs and preferences. To conclude our discussion, let’s summarize the pros and cons of each framework and provide final recommendations based on various use cases.

### Pros and Cons

**Mockito:**
- **Pros:**
    - Simple and intuitive syntax, making it easier for beginners and improving readability.
    - Fast execution speed and low resource consumption.
    - Excellent for behavior-driven development and scenarios requiring partial mocks (spying).
    - Strong community support and extensive documentation.

- **Cons:**
    - Some advanced features may have a steeper learning curve.
    - Might not offer the same level of detailed control over mock behavior as EasyMock in complex scenarios.

**EasyMock:**
- **Pros:**
    - Provides a structured approach to mocking with its record and replay model.
    - Suited for complex mocking scenarios requiring explicit control and verification.
    - Clear separation of phases in the testing process, beneficial for certain testing methodologies.

- **Cons:**
    - Slightly less intuitive, especially for beginners, due to its record-replay mechanism.
    - Can be more verbose and resource-intensive in large-scale or complex tests.

### Final Recommendations

1. **For Agile and Rapid Development Projects:**
    - **Recommendation:** Mockito is the preferred choice for projects that require quick development cycles and highly readable tests, particularly useful in agile environments.

2. **For Complex Testing Environments:**
    - **Recommendation:** EasyMock is better suited for projects where complex interactions need to be tested with a high level of detail and control.

3. **For Behavior-Driven Development:**
    - **Recommendation:** Mockito, with its natural language-like syntax, aligns well with BDD practices, making it the go-to option.

4. **For Large-Scale Projects with a Focus on Performance:**
    - **Recommendation:** Mockito, due to its performance efficiency and scalability, is more suitable for large projects where maintaining a vast number of tests with minimal overhead is crucial.

5. **For Educational Purposes or Simpler Use Cases:**
    - **Recommendation:** Mockito's simplicity and ease of use make it an excellent choice for educational environments or projects with simpler testing needs.

In conclusion, while both Mockito and EasyMock are competent and reliable for Java unit testing, the choice between them depends on specific project requirements, testing complexity, development methodology, and the team's familiarity with the framework. Understanding the nuances of each and aligning them with your project's needs will ensure effective and efficient testing.
