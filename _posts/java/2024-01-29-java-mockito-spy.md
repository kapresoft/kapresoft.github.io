---
title: "Mastering Mockito Spy: Elevate Your Java Testing Game"
category: java
tags: 
    - spring
    - testing
canonical_url: https://www.kapresoft.com/java/2024/01/29/java-mockito-spy.html
description: "Explore the intricacies of software testing with Mockito Spy, a tool designed for precise and efficient testing in Java applications."
---

## Overview

Navigating the complexities of software development demands a robust approach to testing. Mockito emerges as a key player in this domain, particularly within the Java community. Renowned for its transformative impact on unit testing, Mockito serves as a powerful mocking framework. Its primary function is to enable developers to craft and manipulate mock objects. exThese mocks are essential in isolating specific components of an application for testing, free from the unpredictability of external dependencies and interactions.<!--excerpt--> This strategic isolation is not just a matter of efficiency; it's fundamental to achieving rapid, dependable test results, ensuring each component functions correctly in a controlled environment.

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/java-mockito-spy-cover-6cbf356.webp" alt="Image: Java • Mockito Spy">
</div>

One of the jewels in Mockito's crown is the _Mockito Spy_ feature. While traditional mocks are entirely dummy implementations of an interface or class, a spy in Mockito is something more nuanced. It bridges the gap between real object behavior and the flexibility of a mock, offering a unique blend of authenticity and control. By wrapping a real object, a spy allows most operations to be performed as usual, while still providing the ability to intercept and alter specific method calls, track interactions, or verify behaviors. This makes Mockito Spy an indispensable tool for enhancing test accuracy and efficiency, particularly when dealing with legacy code or complex class interactions where complete mocking is impractical or impossible. In the following sections, we'll dive deeper into the capabilities of Mockito Spy, elucidating its role and significance in crafting high-quality, maintainable tests in Java applications.

## Introduction to Mockito Spy

Mockito Spy stands out within the Mockito framework as a hybrid testing tool, blending the characteristics of real objects and mocks. Unlike standard mocks, which are essentially blank canvases allowing for complete control and customization, spies in Mockito wrap around real objects. This wrapping technique enables the spy to defer calls to the actual methods of the object unless explicitly stubbed. As a result, spies are ideal for scenarios where you need to monitor real object behavior while still retaining the ability to override specific method behaviors for testing purposes.

Spying is particularly beneficial when dealing with legacy code, where creating a mock for every aspect of the complex system is neither practical nor efficient. It also shines in situations where the behavior of a real object is intricate, and replicating it in a mock would be overly cumbersome. By using spies, developers can keep the natural behavior of the object intact for the most part, stepping in only where necessary to alter or track specific functionalities.

## Setting Up Your Environment for Mockito Spy

To begin using Mockito Spy, setting up your Java project environment correctly is crucial. Firstly, ensure that your project includes the Mockito library. If you're using Maven, add the following dependency to your _pom.xml_ file:

```xml
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-core</artifactId>
    <version>5.10.0</version>
    <scope>test</scope>
</dependency>
```

For Gradle users, include this line in your _build.gradle_:

```gradle
testImplementation 'org.mockito:mockito-core:[latest-version]'
```

The current version of <a href="/java/2023/11/26/java-mockito-vs-easymock.html" target="_blank" alt="Mockito">Mockito</a> is found in <a href="https://mvnrepository.com/artifact/org.mockito/mockito-core" target="_blank" alt="maven repository" rel="nofollow">maven repository</a>. After adding the dependency, synchronize your project to ensure that the Mockito library is downloaded and available for use.

Next, configure your testing environment. Mockito is typically used alongside <a href="/java/2023/10/26/java-unit-testing-best-practices.html" target="_blank" alt="JUnit">JUnit</a>, so make sure you have JUnit set up in your project. With these dependencies in place, you're now ready to start writing tests that leverage the power of Mockito Spy, enhancing both the scope and effectiveness of your unit tests.

## Writing Your First Test with Mockito Spy

Writing your first test with Mockito Spy involves three key steps: creating a spy, verifying interactions, and stubbing method calls. Let's go through each step with a Java code example.

Assume we have a simple _Calculator_ class that we want to test:

```java
public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
    
    public int subtract(int a, int b) {
        return a - b;
    }
}
```

### Step 1: Creating a Spy
First, we need to create a spy of the _Calculator_ class. This can be done using the _spy_ method provided by Mockito.

```java
import org.mockito.Mockito;
import static org.junit.Assert.*;
import org.junit.Test;

public class CalculatorTest {

    @Test
    public void testAddition() {
        Calculator calculator = new Calculator();
        Calculator spyCalculator = Mockito.spy(calculator);

        // Rest of the test
    }
}
```

In this example, _spyCalculator_ is a spy on the actual _calculator_ object.

### Step 2: Verifying Interactions
Next, let's verify that a method was called with specific parameters. This is done using the _verify_ method.

```java
@Test
public void testAddition() {
    Calculator calculator = new Calculator();
    Calculator spyCalculator = Mockito.spy(calculator);

    spyCalculator.add(10, 20);

    Mockito.verify(spyCalculator).add(10, 20);

    // Rest of the test
}
```

Here, we're verifying that the _add_ method of the spy object was called with the arguments _10_ and _20_.

### Step 3: Stubbing Method Calls
Finally, you may want to change the behavior of the method in the spy. This is achieved by stubbing the method call.

```java
@Test
public void testSubtraction() {
    Calculator calculator = new Calculator();
    Calculator spyCalculator = Mockito.spy(calculator);

    Mockito.doReturn(5).when(spyCalculator).subtract(10, 5);
    
    int result = spyCalculator.subtract(10, 5);

    assertEquals(5, result);
    Mockito.verify(spyCalculator).subtract(10, 5);
}
```

In this example, we stub the _subtract_ method. Even though the actual implementation would return _5_, we could have stubbed it to return any other value. This shows how we can control the behavior of specific methods in a spy object.

By following these steps, you can create a spy, verify its interactions, and stub method calls, giving you greater flexibility and control in your unit tests.

## Spring Framework and Mockito @Spy

Integrating Mockito's _@Spy_ annotation with the latest <a href="/java/2024/01/03/spring-getting-started.html" target="_blank" alt="Spring Framework">Spring Framework</a> and <a href="/java/2023/10/26/java-unit-testing-best-practices.html" target="_blank" alt="JUnit">JUnit</a> offers a powerful approach to testing Spring components. It allows you to partially <a href="/java/2023/12/01/mastering-spring-mockbean.html" target="_blank" alt="mock Spring beans">mock Spring beans</a> while maintaining the context setup and dependency injection capabilities of Spring. Here’s how you can implement this in a Java application using <a href="/java/2023/10/27/java-assertj-vs-hamcrest-assertion.html" target="_blank" alt="AssertJ">AssertJ</a> for assertions, which provides more fluent and intuitive assertion methods.

### Setting Up Dependencies

For <a href="/java/2018/08/16/getting-started-with-maven.html" target="_blank" alt="maven">Maven</a>, ensure you have the necessary dependencies in your _pom.xml_ file. You need the latest Spring Boot Starter Test, which includes support for JUnit and Mockito, along with AssertJ:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <version>3.2.2</version>
    <scope>test</scope>
</dependency>
```

For <a href="/java/2018/08/14/getting-started-with-gradle.html" target="_blank" alt="Gradle">Gradle</a>, you would add the necessary dependencies in your _build.gradle_ file to include the latest Spring Boot Starter Test, Mockito, and AssertJ. Here's the equivalent Gradle import:


```gradle
dependencies {
    testImplementation 'org.springframework.boot:spring-boot-starter-test:3.2.2'
}
```

This will set up your Gradle project with the necessary dependencies for using Mockito _@Spy_ with the Spring Framework and JUnit, along with AssertJ for assertions.

### Example Scenario: Testing a Spring Service

Suppose you have a simple Spring service:

```java
@Service
public class UserService {
    public String getUserDetails(String userId) {
        // Logic to retrieve user details
        return "User Details for " + userId;
    }
}
```

### Writing the Test with @Spy

Create a test class using Spring's _@SpringBootTest_ to load the application context. Use Mockito's _@SpyBean_ to inject a spy of your service into the Spring context.

```java
import org.springframework.boot.test.context.SpringBootTest;
import org.junit.jupiter.api.Test;
import org.mockito.SpyBean;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class UserServiceTest {

    @SpyBean
    private UserService userService;

    @Test
    public void getUserDetailsTest() {
        String userId = "123";
        String expected = "User Details for 123";

        // Call the real method
        String actual = userService.getUserDetails(userId);

        // Assert using AssertJ
        assertThat(actual).isEqualTo(expected);
    }
}
```

In this test, _UserService_ is spied upon, meaning its real methods will be called unless explicitly stubbed. AssertJ provides a more readable way to assert the expected outcomes.

### Overriding Behavior in Tests

You can also override certain behaviors in your spy for more focused testing:

```java
import org.mockito.Mockito;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.mockito.SpyBean;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class UserServiceTest {

    @SpyBean
    private UserService userService;

    @Test
    public void getUserDetailsTestWithStubbing() {
        String userId = "123";
        String stubbedResult = "Stubbed User Details";

        // Stubbing a method
        Mockito.doReturn(stubbedResult)
                .when(userService)
                .getUserDetails(userId);

        String actual = userService.getUserDetails(userId);

        // Assert using AssertJ
        assertThat(actual).isEqualTo(stubbedResult);
    }
}
```

In this example, _getUserDetails(userId)_ is stubbed to return a predetermined string. This is useful when you need to isolate certain behaviors without altering the entire functionality of the bean.

### Real-World Scenario

Let's consider a more real-world scenario involving a service with a method that has a dependency on an external API or database. In such cases, using a spy to override the behavior of specific methods can be particularly beneficial for testing, as it allows you to avoid making actual calls to external systems, which might be time-consuming, unreliable, or have side-effects.

Imagine you have a _UserService_ with a method that retrieves detailed user information, which includes a call to an external email service to fetch the user's email address. In a test environment, you might want to avoid calling this external service.

Here's an example:

```java
public class UserService {
    private EmailService emailService;

    public UserService(EmailService emailService) {
        this.emailService = emailService;
    }

    public UserDetails getUserDetails(String userId) {
        String email = emailService.getEmailForUser(userId);
        // Additional logic to retrieve user details
        return new UserDetails(userId, email);
    }
}

public class EmailService {
    public String getEmailForUser(String userId) {
        // Makes an external API call to get email
        return "user@example.com"; // Simplified for example
    }
}
```

In your test, you can use a spy to override the _getEmailForUser(userId)_ method of the _EmailService_ to avoid making the external call:

```java
import org.mockito.Mockito;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.mockito.SpyBean;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class UserServiceTest {

    @SpyBean
    private EmailService emailService;

    @Test
    public void getUserDetailsWithoutExternalCall() {
        String userId = "123";
        String stubbedEmail = "stubbed-email@example.com";

        // Stubbing the external call
        Mockito.doReturn(stubbedEmail)
                .when(emailService)
                .getEmailForUser(userId);

        UserService userService = new UserService(emailService);
        UserDetails userDetails = userService.getUserDetails(userId);

        // Assert using AssertJ
        assertThat(userDetails.getEmail()).isEqualTo(stubbedEmail);
    }
}
```

In this modified example, _UserServiceTest_ uses a spy to stub the _getEmailForUser()_ method of _EmailService_. This way, the test doesn't make an actual external call but uses a stubbed email address, making the test more reliable and faster, as it doesn't depend on the availability or behavior of the external service.

Additionally, leveraging Mockito's _@SpyBean_ alongside <a href="/java/2023/11/16/spring-boot-mockmvc-best-practices.html" target="_blank" alt="Spring Boot">Spring Boot</a> and AssertJ provides the dual advantage of flexible spying on <a href="/java/2023/12/01/mastering-spring-mockbean.html" target="_blank" alt="Spring-managed beans">Spring-managed beans</a> and the clarity of fluent assertions, thereby enhancing both the robustness and readability of your tests.

## Advanced Uses of Mockito Spy

Mockito Spy offers a range of advanced features that can be particularly useful in complex testing scenarios. Let's explore some of these features, including spying on real objects, partial mocking, and using spies with legacy code, supported by Java code examples.

### Spying on Real Objects

With Mockito, you can create a spy of a real object, where some methods have real behavior, and others are overridden (stubbed). This is particularly useful when you want to test the actual object but need to alter certain behaviors to fit your test scenario.

Consider a _UserManager_ class that interacts with a database:

```java
public class UserManager {
    public boolean isValidUser(String username) {
        // Connects to the database and checks if the user is valid
        return true; // Simplified for the example
    }

    public void updateUser(String username) {
        // Updates user in the database
    }
}
```

We can spy on this real object and override the _isValidUser_ method:

```java
import org.mockito.Mockito;
import org.junit.Test;

public class UserManagerTest {

    @Test
    public void testUpdateUser() {
        UserManager userManager = new UserManager();
        UserManager spyUserManager = Mockito.spy(userManager);

        // Stubbing the method
        Mockito.doReturn(false).when(spyUserManager).isValidUser("testUser");

        // 'isValidUser' will use the stubbed value, 'updateUser' will execute real code
        if(spyUserManager.isValidUser("testUser")) {
            spyUserManager.updateUser("testUser");
        }

        // Verify 'updateUser' was not called due to the stubbed method
        Mockito.verify(spyUserManager, Mockito.never()).updateUser("testUser");
    }
}
```

### Partial Mocking

Partial mocking is another powerful feature of Mockito Spy. This allows you to mock only certain methods of an object while leaving the rest with their real behavior. This is useful when testing a class with a mix of complex and simple methods, where mocking everything is unnecessary.

```java
public class PaymentProcessor {
    public boolean processPayment(double amount) {
        // Complex payment processing logic
        return true;
    }

    public void notifyUser() {
        // Simple notification logic
    }
}
```

Here’s how you can partially mock the _PaymentProcessor_:

```java
import org.mockito.Mockito;
import org.junit.Test;
import static org.junit.Assert.*;

public class PaymentProcessorTest {

    @Test
    public void testProcessPayment() {
        PaymentProcessor paymentProcessor = new PaymentProcessor();
        PaymentProcessor spyPaymentProcessor = Mockito.spy(paymentProcessor);

        // Stubbing processPayment method
        Mockito.doReturn(false)
                .when(spyPaymentProcessor)
                .processPayment(100.0);

        assertFalse(spyPaymentProcessor.processPayment(100.0));
        spyPaymentProcessor.notifyUser();

        // Verify that 'notifyUser' method ran with real behavior
        Mockito.verify(spyPaymentProcessor).notifyUser();
    }
}
```

### Using Spies with Legacy Code
Mockito Spy is particularly useful when working with legacy code. Often, such code bases are not designed with testing in mind, making them hard to test with traditional mocking. Spies can help by allowing you to use the real code but override specific parts that are hard to test, such as external dependencies.

Assuming a legacy _OrderProcessor_ class:

```java
public class OrderProcessor {
    public void processOrder(String orderId) {
        // Complex logic with external dependencies
    }

    public void logOrder(String orderId) {
        // Logging logic
    }
}
```

We can use a spy to test _OrderProcessor_:

```java
import org.mockito.Mockito;
import org.junit.Test;

public class OrderProcessorTest {

    @Test
    public void testProcessOrder() {
        OrderProcessor orderProcessor = new OrderProcessor();
        OrderProcessor spyOrderProcessor = Mockito.spy(orderProcessor);

        // Stubbing external dependency part
        Mockito.doNothing()
                .when(spyOrderProcessor)
                .logOrder("123");

        spyOrderProcessor.processOrder("123");

        // Verify that the 'logOrder' method was called
        Mockito.verify(spyOrderProcessor).logOrder("123");
    }
}
```

By utilizing these advanced features of Mockito Spy, you can handle a variety of complex testing scenarios with greater ease and precision, making your tests more robust and reliable.


## Best Practices and Common Pitfalls

In this section, we'll explore essential guidelines and typical missteps in using Mockito Spy, providing a roadmap for effective and error-free testing practices.

### Best Practices for Using Mockito Spy

Delve into the key strategies for maximizing the efficiency and accuracy of Mockito Spy in your testing processes.

1. **Use Spies Sparingly**: Spies should be used judiciously. Prefer using standard mocks whenever possible, as they lead to simpler and more maintainable tests. Use spies primarily when dealing with legacy code or when testing behavior that relies on the real object.

2. **Clearly Define Stubbing**: When stubbing methods in a spy, clearly define the behavior you want to override. Avoid unnecessary stubbing, as it can lead to confusing and brittle tests.

3. **Verify with Care**: Be precise with verifications. Over-verifying can make your tests brittle, while under-verifying can lead to missed bugs. Focus on verifying the behavior that directly relates to the purpose of your test.

4. **Keep Tests Focused**: Each test should verify a single behavior or functionality. This makes tests easier to understand and maintain.

5. **Document Your Intentions**: Comment your test code, especially when the reasoning behind the use of spies is not immediately apparent. This helps others understand why a spy was necessary over a mock.

### Common Pitfalls to Avoid

Let's examine some frequent mistakes to steer clear of when working with Mockito Spy, ensuring smoother and more reliable testing.

1. **Overuse of Spies**: Relying too heavily on spies can lead to tests that are more complex and harder to maintain. It can also mask code design issues.

2. **Stubbing Everything**: Stubbing every method in a spy defeats the purpose of spying. If you find yourself doing this, consider if a mock would be more appropriate.

3. **Ignoring Default Behavior**: When using spies, remember that they use the real methods by default. Ignoring this can lead to unexpected side effects in your tests.

4. **Not Isolating Tests**: Ensure that your tests are isolated and do not depend on the state created by other tests. This is especially important when using spies, as they work with real objects.

Following these best practices and avoiding common pitfalls, you can leverage Mockito Spy effectively, resulting in cleaner, more reliable, and maintainable tests.

## Mockito Spy vs. Regular Mocks: When to Use Each

Mockito offers two primary ways to create test doubles: Spies and Mocks. Understanding when to use each is crucial for writing effective tests. Let's explore their differences and appropriate use cases, supported by Java code examples.

### Regular Mocks

Mocks in Mockito are completely simulated objects where none of the real object's behavior is retained. They are best used when:

- You need to test the interactions between objects.
- The object has external dependencies like database or network calls that you want to avoid.
- You're testing in isolation and don’t need any actual implementation from the object.

Consider a _PaymentService_ class that depends on a _CreditCardProcessor_:

```java
public class PaymentService {
    private CreditCardProcessor processor;

    public PaymentService(CreditCardProcessor processor) {
        this.processor = processor;
    }

    public void processPayment(String creditCardNumber, double amount) {
        // Process payment using CreditCardProcessor
    }
}
```

When testing _PaymentService_, you can mock _CreditCardProcessor_:

```java
import org.mockito.Mock;
import org.mockito.Mockito;
import org.junit.Before;
import org.junit.Test;

public class PaymentServiceTest {

    @Mock
    private CreditCardProcessor mockProcessor;

    private PaymentService paymentService;

    @Before
    public void setUp() {
        mockProcessor = Mockito.mock(CreditCardProcessor.class);
        paymentService = new PaymentService(mockProcessor);
    }

    @Test
    public void testProcessPayment() {
        paymentService.processPayment("123456789", 100.0);
        Mockito.verify(mockProcessor).process("123456789", 100.0);
    }
}
```

### Mockito Spies

Spies, on the other hand, are partially mocked objects where some methods retain the real behavior. Spies are ideal when:

- You need to test most of the real object’s behavior.
- You only want to override or track specific methods.
- You are dealing with legacy code that is hard to refactor for testing.

For example, consider a _NotificationService_ that needs partial testing:

```java
public class NotificationService {
    public void sendEmail(String message) {
        // Send an email
    }

    public void logNotification(String message) {
        // Log the notification
    }
}
```

You can use a spy to test _NotificationService_:

```java
import org.mockito.Mockito;
import org.junit.Test;

public class NotificationServiceTest {

    @Test
    public void testSendEmail() {
        NotificationService notificationService = new NotificationService();
        NotificationService spyService = Mockito.spy(notificationService);

        Mockito.doNothing().when(spyService).logNotification("Test Message");

        spyService.sendEmail("Test Message");
        spyService.logNotification("Test Message");

        Mockito.verify(spyService).sendEmail("Test Message");
        Mockito.verify(spyService).logNotification("Test Message");
    }
}
```

### Choosing Between Mocks and Spies

- **Use a mock** when you want to completely simulate an object and its interactions.
- **Opt for a spy** when you need the real behavior of the object but want to override or monitor specific methods.

Understanding the nuances of Mockito's mocks and spies allows you to write tests that are both effective and appropriate for your testing scenario.

## Conclusion

Throughout this article, we've delved into the practicalities and advantages of using Mockito Spy in software testing. Mockito Spy stands out as a versatile tool, offering a blend of real object behavior and mock functionality. This makes it particularly valuable in situations where full mocking is impractical, such as dealing with legacy code or when specific behaviors of real objects need to be preserved.

We've observed that Mockito Spy, especially when integrated with the Spring framework, is a powerful tool for partial mocking and spying on real objects, presenting distinct advantages in complex testing scenarios. Its capability to precisely verify interactions and strategically stub specific method calls leads to more controlled and accurate testing processes. Leveraging Spring's features, such as _@SpyBean_ and _@MockBean_, further augments this precision, allowing Mockito Spy to seamlessly align with Spring's robust dependency management and configuration features. This combination not only enhances testing accuracy but also brings a new level of efficiency and effectiveness to the testing landscape.

However, it's important to remember that Mockito Spy should be used judiciously. Regular mocks are often more suitable for complete isolation and simplicity, while spies are best reserved for scenarios that require a mix of real and mocked behaviors.

Incorporating Mockito Spy into your testing strategy can elevate the quality and accuracy of your tests. It's a powerful tool that, when used appropriately, can significantly enhance your ability to write robust, maintainable, and effective tests. As you continue to navigate the world of software testing, consider integrating Mockito Spy into your toolkit to harness its full potential in improving your testing practices.
