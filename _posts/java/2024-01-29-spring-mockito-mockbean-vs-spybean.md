---
title: "@MockBean vs @SpyBean in Spring: The Ultimate Guide for Mastering Mockito Testing"
category: java
tags: 
    - testing
    - mockito
    - spring
canonical_url: https://www.kapresoft.com/java/2024/01/29/spring-mockito-mockbean-vs-spybean.html
description: "Explore the nuanced differences between Spring's @MockBean and @SpyBean annotations and their impact on testing in Spring applications."
---

## Overview

Unlocking the potential of modern application testing within the Spring Framework, the nuanced distinction between _@MockBean_ and _@SpyBean_ often plays a critical role. These annotations, integral in the Mockito framework, serve distinct purposes and are key to efficient and effective testing strategies. For developers already versed in Mockito and Spring, grasping the subtle yet significant differences between these annotations is essential.<!--excerpt-->

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/spring-mockito-mockbean-vs-spybean-cover-c385e17.webp" alt="Image: Spring • Mockito Mockbean Vs Spybean">
</div>

_@MockBean_, a staple in the Mockito toolkit, is used for creating mock instances of a bean. It's particularly useful in isolating the component under test by replacing other beans in the Spring context with mock versions. This approach is ideal when testing behavior in isolation is required, ensuring that no external dependencies interfere with the unit under test.

On the other hand, _@SpyBean_ brings a different flavor to testing. It's used for creating partial mock instances. While _@MockBean_ creates a complete mock, _@SpyBean_ allows the original bean's behavior to be retained, with the option to override specific methods as needed. This is particularly useful in scenarios where you want to use the real functionality of the bean but need to alter certain behaviors for testing purposes.

Understanding when and how to use _@MockBean_ and _@SpyBean_ can significantly enhance testing efficiency in Spring applications. This article aims to shed light on their individual functionalities, how they differ, and their optimal use cases, supported by practical examples. By the end of this exploration, developers will have a clearer understanding of these powerful tools in the Spring testing arsenal, enabling them to make informed decisions in their testing strategies.

## Understanding @MockBean

This section focuses on demystifying _@MockBean_, a crucial annotation in Spring testing, by explaining its core principles, how it operates within the Spring context, and its practical applications.

### Definition and Basic Concept
In the Spring testing landscape, _@MockBean_ is an annotation used to add mock objects to the Spring application context. These mock objects replace the real beans during testing, allowing developers to focus solely on the behavior of the component under test. It is a part of the Spring Boot Test framework and integrates seamlessly with Mockito, a popular mocking framework for unit tests in Java.

### How @MockBean Works in Spring Tests
When you annotate a field with _@MockBean_, Spring Boot Test automatically replaces the bean of the same type in the application context with a Mockito mock. This mock is then reset after each test, ensuring test isolation and eliminating side effects between tests.

```java
@SpringBootTest
public class SampleServiceTest {

    @MockBean
    private DependencyService dependencyService;

    @Autowired
    private SampleService sampleService;

    @Test
    public void testSampleServiceMethod() {
        when(dependencyService.someMethod())
                .thenReturn("Mocked Response");
        String result = sampleService.useDependency();
        assertThat(result).isEqualTo("Mocked Response");
    }
}
```

In this example, _DependencyService_ is a dependency of _SampleService_. By using _@MockBean_, we replace _DependencyService_ in the Spring context with a mock, allowing us to control its behavior and test _SampleService_ in isolation.

### Advantages of Using @MockBean
- **Isolation**: _@MockBean_ ensures that the component under test is isolated from its dependencies, leading to more reliable and predictable tests.
- **Simplicity**: It integrates effortlessly with Spring Boot, making it straightforward to replace beans with mocks.
- **Flexibility**: Allows customization of the mocked bean's behavior on a per-test basis.
- **Integration**: Works seamlessly with Mockito, offering a familiar and powerful mocking mechanism.

### Common Use Cases and Examples
- **Testing Service Layer**: When testing service layers, _@MockBean_ can be used to mock data access objects (DAOs) or repositories, ensuring the service logic is tested in isolation from the database.

```java
@SpringBootTest
public class UserServiceTest {

    @MockBean
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @Test
    public void testAddUser() {
        User mockUser = new User("Alice");
        when(userRepository.save(any(User.class)))
                .thenReturn(mockUser);
        User result = userService.addUser("Alice");
        assertThat(result.getName()).as("User Name")
                .isEqualTo("Alice");
    }
}
```

- **Controller Tests**: In controller tests, _@MockBean_ can mock service layer beans, allowing you to test the controller's request handling and response generation without relying on the service logic.

```java
@WebMvcTest(UserController.class)
public class UserControllerTest {

    @MockBean
    private UserService userService;

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testGetUser() throws Exception {
        when(userService.getUserById(1L)).thenReturn(new User("Bob"));
        mockMvc.perform(get("/users/1"))
               .andExpect(status().isOk())
               .andExpect(content().string(containsString("Bob")));
    }
}
```

To recap, _@MockBean_ is a powerful tool in the Spring testing arsenal, providing isolation, simplicity, flexibility, and seamless integration. By mocking dependencies, it enables developers to write cleaner, more focused tests, crucial for ensuring quality in Spring applications.

## Exploring @SpyBean

Gain in-depth insights into _@SpyBean_, a key annotation in Spring testing, through a detailed exploration of its functionality, usage, and benefits within the Spring Framework context.

### Definition and Core Functionality
_@SpyBean_ is an annotation used within the Spring testing framework to create a spy of an existing bean. A spy, in Mockito terms, is a partial mock that by default uses the real methods of the bean but allows for specific methods to be stubbed or verified. This approach is beneficial when you need to monitor or alter the behavior of an existing Spring bean without completely replacing its functionality.

### The Mechanism of @SpyBean in the Spring Context
When a bean is annotated with _@SpyBean_, Spring creates a wrapper around the actual bean. This wrapper allows the original methods to be executed while also giving the capability to override certain behaviors for testing purposes. Unlike _@MockBean_, which creates a complete mock, _@SpyBean_ maintains the state and behavior of the original bean.

```java
@SpringBootTest
public class PaymentServiceTest {

    @SpyBean
    private PaymentProcessor paymentProcessor;

    @Autowired
    private PaymentService paymentService;

    @Test
    public void testPaymentService() {
        doReturn(true)
                .when(paymentProcessor)
                .process(any(BigDecimal.class));
        boolean success = paymentService.makePayment(new BigDecimal("100.00"));
        assertThat(success).as("Make Payment")
                .isTrue();
    }
}
```

In this example, _PaymentProcessor_ is a dependency of _PaymentService_. Using _@SpyBean_, the actual _PaymentProcessor_ bean is wrapped, and its _process_ method is overridden for the test.

### Benefits of Opting for @SpyBean
- **Partial Mocking**: Retains the original functionality of the bean while allowing specific behaviors to be overridden.
- **Statefulness**: Useful for beans where maintaining state is essential for testing.
- **Flexibility**: Combines real behavior with mocked responses, offering a balance between isolation and integration in tests.

### Typical Scenarios and Sample Code
_@SpyBean_ is especially useful in scenarios where the complete behavior of a bean is complex or when you want to test the interaction with the actual implementation.

```java
@SpringBootTest
public class NotificationServiceTest {

    @SpyBean
    private EmailSender emailSender;

    @Autowired
    private NotificationService notificationService;

    @Test
    public void testSendNotification() {
        doNothing()
                .when(emailSender)
                .send(anyString());
        notificationService.notifyUser("Welcome!");
        verify(emailSender, times(1)).send("Welcome!");
    }
}
```

In this case, _EmailSender_ is spied to verify that the _send_ method is called correctly by _NotificationService_, without actually sending emails during the test.

## @MockBean vs @SpyBean: A Comparative Analysis

Delve into the nuanced differences between _@MockBean_ and _@SpyBean_ in this comprehensive comparison, designed to clarify when and how to use each annotation effectively in Spring testing.

### Key Differences in Functionality
- **Mocking Approach**: _@MockBean_ creates a complete mock that replaces the bean's functionality entirely, while _@SpyBean_ creates a spy that retains the original behavior.
- **State and Behavior**: _@MockBean_ does not maintain the state of the bean, whereas _@SpyBean_ does.

### When to Use @MockBean Over @SpyBean and Vice Versa
- Use _@MockBean_ for complete isolation and when testing components that should not be influenced by the actual implementation of their dependencies.
- Opt for _@SpyBean_ when you need to keep the real behavior of the bean but still want to override or verify specific methods.

### Impact on Application Testing Strategy
- Choosing between _@MockBean_ and _@SpyBean_ can significantly affect the testing strategy. _@MockBean_ is more suited for unit testing, while _@SpyBean_ is better for integration testing where real behavior is essential.
- The decision impacts how closely the tests mimic the actual runtime behavior of the application.

### Integrating with Other Spring Components
Both annotations work well within the Spring ecosystem. The choice between them should be guided by the testing needs of specific components and the desired level of integration with the rest of the Spring application.

## Practical Examples in Spring Testing

This following provides step-by-step guides and best practices to effectively implement these annotations, enhancing your testing strategy for Spring applications.

### Step-by-Step Guide for Implementing @MockBean

Navigate through the essentials of implementing _@MockBean_ in Spring testing with this structured guide, which breaks down the process into clear, actionable steps.

1. **Annotate Test Class**: Use _@SpringBootTest_ to indicate that the test should load the Spring context.
2. **Declare MockBean**: Annotate a field in the test class with _@MockBean_ to replace the actual bean with a mock.
3. **Set Up Mock Behavior**: Utilize Mockito's _when()_ and _thenReturn()_ to define the mock's behavior.
4. **Write Test Methods**: Implement your test methods, focusing on the behavior that involves the mocked bean.

Here's an illustrative example of how to effectively utilize @MockBean in Spring testing:

```java
@SpringBootTest
public class OrderServiceTest {

    @MockBean
    private PaymentGateway paymentGateway;

    @Autowired
    private OrderService orderService;

    @Test
    public void testOrderProcessing() {
        when(paymentGateway.process(any()))
                .thenReturn(true);
        boolean success = orderService.processOrder(new Order());
        assertThat(success).as("Process Order")
                .isTrue();
    }
}
```

### Detailed Tutorial on Utilizing @SpyBean

This following offers a step-by-step tutorial on effectively utilizing _@SpyBean_ in Spring testing, guiding you through each phase from setting up your test class to executing and verifying tests.

1. **Annotate Test Class**: Start with _@SpringBootTest_ to engage the full application context.
2. **Declare SpyBean**: Use _@SpyBean_ on the bean you wish to spy.
3. **Override Methods as Needed**: Apply Mockito's _doReturn()_ or _doThrow()_ for method behavior modification.
4. **Conduct Tests**: Implement tests to validate both the overridden and actual behaviors of the spied bean.

Here's an illustrative example of how to effectively utilize @SpyBean in Spring testing:

```java
@SpringBootTest
public class InventoryServiceTest {

    @SpyBean
    private StockManager stockManager;

    @Autowired
    private InventoryService inventoryService;

    @Test
    public void testStockUpdate() {
        doReturn(50)
                .when(stockManager)
                .getStockLevel("item1");
        assertThat(inventoryService.getStockLevel("item1"))
                .isEqualTo(50);
    }
}
```

### Best Practices and Tips for Effective Testing

In this section, we present a compilation of best practices and tips to refine your testing techniques using _@MockBean_ and _@SpyBean_ in Spring. These guidelines are designed to help you achieve more efficient and effective testing outcomes.

- **Isolation**: Use _@MockBean_ for unit tests to isolate the component under test.
- **Real Behavior**: Choose _@SpyBean_ when the real behavior of the bean is necessary for the test scenario.
- **Minimal Mocking**: Mock or spy only the necessary components to avoid overcomplicating the test setup.
- **Clear Intent**: Write tests with clear objectives and ensure they align with the chosen mocking strategy.

## Conclusion

### Summarizing the Importance of Correct Annotation Choice
Selecting the right annotation - _@MockBean_ or _@SpyBean_ - is crucial in Spring testing. The choice dictates the level of isolation and realism in tests, impacting the accuracy and reliability of test outcomes. Proper use of these annotations enhances the test's ability to mimic real-world scenarios and isolate specific behaviors, leading to more robust and maintainable Spring applications.

### Final Thoughts on Enhancing Test Quality in Spring Applications
High-quality testing in Spring applications is achieved not just through comprehensive test coverage but also through strategic use of testing tools. Understanding and correctly applying _@MockBean_ and _@SpyBean_ ensures that tests are not only effective but also efficient. This understanding is pivotal in building resilient, bug-resistant applications, ultimately contributing to the development of high-quality Spring applications.
