---
title: "Lombok Test Coverage"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/06/21/lombok-test-coverage.html
category: java
related: lombok
description: "Importance of test coverage when using Lombok, configuring coverage tools like JaCoCo, and best practices."
---

## Overview

When it comes to software development, testing plays a crucial role in ensuring the quality and reliability of the codebase. Test coverage, in particular, is a metric that measures the extent to which the source code of a program has been tested.<!--excerpt--> It helps developers understand which parts of their code are covered by tests and which areas require further attention. 

In this article, we will explore the concept of test coverage specifically in the context of [Lombok](https://projectlombok.org/), a popular Java library.

Lombok is a concise Java library that helps reduce boilerplate code by automatically generating common code snippets such as getters, setters, constructors, and more. It aims to improve developer productivity by reducing the amount of repetitive code that needs to be written. Lombok achieves this through the use of annotations, which are markers added to the source code to trigger the code generation process.

While Lombok can certainly make development faster and more efficient, it is essential to ensure that the generated code is thoroughly tested. As with any software project, maintaining good test coverage is vital for detecting bugs, preventing regressions, and maintaining the overall quality of the codebase.

To achieve effective test coverage with Lombok, developers should focus on two primary aspects: testing the generated code and testing the interaction between the generated code and the rest of the application.

Testing the generated code involves verifying that the getters, setters, constructors, and other code snippets produced by Lombok behave as expected. However, it's important to note that **developers should be careful not to test the Lombok framework itself**, as it is already extensively tested by its maintainers. The focus should be on testing the behavior of the generated code within the context of the application.

This typically involves writing unit tests that exercise the generated code paths and assert the correctness of their behavior. By doing so, developers can ensure that the generated code works as intended and provides the expected functionality. It's essential to differentiate between testing the Lombok framework and testing the specific logic or functionality implemented using Lombok-generated code.

However, it is equally important to test the integration between the generated code and the rest of the application. Lombok-generated code is often tightly coupled with the rest of the codebase, and errors or regressions in this interaction can have significant consequences. Integration tests should be designed to cover scenarios that exercise the Lombok-generated code in conjunction with other components of the application, ensuring smooth interoperability and identifying any potential issues.

## Enhancing Testability of Your Codebase with Lombok

When considering Lombok for your project, it's crucial to evaluate its impact on testability. Testing plays a vital role in software development, ensuring the reliability and correctness of code. Lombok's automatic code generation can affect test coverage and readability. Thoroughly testing the generated code, configuring mock objects, and ensuring compatibility with testing frameworks are essential. Additionally, integration and end-to-end testing scenarios should consider Lombok-generated code to avoid unexpected issues or inconsistencies.

## What and what not to test when working with Lombok.

When it comes to testing code that utilizes Lombok, it's important to focus on testing the behavior and functionality of your own code, rather than the framework itself. Here are some examples of what to test and what not to test when working with Lombok.

### What to test

```java
@Data
public class User {
    private String name;
    private int age;
}
```

#### Custom business logic
```java
public class UserServiceTest {
    @Test
    public void testUserAgeValidation() {
        User user = new User();
        user.setAge(25);
        
        UserService userService = new UserService();
        boolean result = userService.isValidUser(user);
        
        assertThat(result).isTrue();
    }
}
```

In this example, you can write tests to validate custom business logic implemented in _UserService_, which interacts with the Lombok-generated code for _User_ class.

#### Validations and constraints:
```java
public class UserValidatorTest {
    @Test
    public void testUserAgeConstraint() {
        User user = new User();
        user.setAge(150); // Invalid age, should fail validation
        
        UserValidator userValidator = new UserValidator();
        boolean result = userValidator.validateUser(user);
        
        assertThat(result).isFalse();
    }
}
```

Here, you can write tests for the _UserValidator_ class, which validates the constraints applied to the _User_ class fields using Lombok annotations like _@NotNull_ or _@Size_.

#### Collaborating components

```java
public class UserServiceTest {
    @Test
    public void testUserCreation() {
        User user = new User();
        user.setName("John");
        user.setAge(30);
        
        UserRepository userRepository = mock(UserRepository.class);
        UserService userService = new UserService(userRepository);
        
        userService.createUser(user);
        
        verify(userRepository).save(user);
    }
}
```

In this example, you can write tests to ensure that the _UserService_ properly interacts with the collaborating _UserRepository_ component when creating a user.

### What not to test

#### Lombok framework functionality:

```java
public class LombokFrameworkTest {
    // Avoid testing Lombok's own functionality
}
```

There is no need to write tests to validate whether Lombok's generated getters, setters, or constructors work as expected. These features are part of the well-established Lombok framework and are assumed to function correctly.

#### Lombok annotations
```java
public class LombokAnnotationsTest {
    // Avoid testing Lombok annotations directly
}
```

You don't need to test the behavior of Lombok annotations like _@Data_, _@Getter_, or _@Setter_. Trust that Lombok's annotation processors will generate the desired code correctly.

#### Lombok-generated code internals

```java
public class LombokGeneratedCodeTest {
    // Avoid testing the internal implementation details of Lombok-generated code
}
```

Since the Lombok-generated code is automatically generated, there is no need to test its internals. Focus on testing how your code that utilizes the generated code behaves and integrates with the rest of the application.

By following these guidelines, you can ensure that your tests are focused on the critical aspects of your codebase and provide meaningful coverage while avoiding redundant or unnecessary tests related to Lombok.

### Should developers write tests to make sure that a Lombok annotations exist on a particular class?

Testing whether Lombok annotations exist on a particular class is not necessary or recommended. Lombok annotations are meant to be processed by the Lombok framework during compilation, and their functionality is well-established and widely used. Thus, there is no need to write tests specifically to check the presence of Lombok annotations.

Instead, focus on testing the behavior and functionality of your own code that utilizes Lombok-generated code. Write tests to ensure that the desired behavior is achieved by the code that relies on Lombok annotations, rather than testing the presence of those annotations themselves.

By testing the actual behavior and functionality of your code, you indirectly verify the presence and correct usage of Lombok annotations. The generated code resulting from Lombok annotations should be considered a well-established part of your codebase, and its correctness can be assumed based on the extensive testing and usage of the Lombok framework itself.

#### What if a developer accidentally removes a lombok annotation?

If a developer accidentally removes a Lombok annotation from a class, it can have unintended consequences on the generated code and the behavior of the affected class. In such cases, it's important to have tests in place that can catch and highlight any issues resulting from the missing Lombok annotation.

To mitigate this risk, you can include tests that verify the expected behavior and functionality of the Lombok-generated code. These tests should exercise the code paths that rely on the presence of Lombok annotations. By doing so, if a developer accidentally removes a Lombok annotation, the corresponding tests will fail, indicating that the expected behavior is not being achieved.

Here's an example:

```java
public class UserTest {
    @Test
    public void testGetterAndSetter() {
        User user = new User();
        user.setName("John");
        user.setAge(30);
        
        assertThat("John").isEqualTo(user.getName());
        assertThat(30).isEqualTo(user.getAge());
    }
}
```

In this example, the test _testGetterAndSetter_ indirectly verifies the presence of Lombok-generated getters and setters. If a developer accidentally removes the _@Data_ annotation from the _User_ class, this test will fail, indicating that the expected behavior of the getters and setters is not being achieved.  

Including such tests helps ensure that the presence and correct usage of Lombok annotations are maintained. It provides an additional safeguard against accidental removal or modifications of Lombok annotations that could impact the behavior of the generated code.

In addition to test failures, the remaining code that relies on the Lombok-generated methods may break or fail to compile if getters or setters are missing, highlighting the importance of maintaining the presence and correct usage of Lombok annotations.

### Should developers write unit tests to verify that the Lombok portion of the code works?

It is recommended for developers to write unit tests to ensure that Lombok is working as expected in their codebase. Unit tests play a crucial role in verifying the functionality and correctness of the code, including the usage of external libraries or tools like Lombok.

Writing unit tests for code that utilizes Lombok helps in several ways:

1. **Verification of Generated Methods:** Lombok automatically generates methods such as getters, setters, _equals()_, _hashCode()_, and more. Writing unit tests ensures that these generated methods are functioning correctly, providing accurate behavior and adhering to the expected logic.

2. **Handling Edge Cases:** Unit tests can cover various scenarios, including edge cases, to ensure that the Lombok-generated code handles them appropriately. For example, testing object equality and comparison methods (_equals()_, _hashCode()_) with different inputs and edge cases helps validate their correctness.

3. **Compatibility with Reflection and Serialization:** If your code uses reflection or serialization, it is essential to write tests to ensure compatibility between Lombok and these mechanisms. Unit tests can cover scenarios where Lombok annotations interact with reflection or serialization to ensure they work seamlessly together.

4. **Integration with Build Tools:** Lombok integrates with build tools like Maven or Gradle. Writing tests that involve building and running the project with the chosen build tool helps ensure that the Lombok annotations are properly processed during the build process.

By writing unit tests for Lombok-generated code, developers can gain confidence in the behavior and functionality of their codebase. It helps detect issues early, ensures compatibility with other components, and promotes the stability and reliability of the application.

It's important to note that while Lombok's annotations are extensively tested by the Lombok project itself, writing specific unit tests for your codebase helps validate their usage in your specific context and use cases.

## Test Coverage

When it comes to measuring test coverage in a Lombok project, several tools can help assess the extent of code coverage achieved by the tests. These tools analyze the source code and identify which lines or branches have been executed during the test suite's execution. They generate reports that provide insights into the overall coverage percentage and highlight areas that remain untested.

Popular Java code coverage tools such as JaCoCo, Cobertura, and Emma can be easily integrated into Lombok projects to measure test coverage. These tools provide detailed reports that can be used to identify areas of the codebase that lack coverage and guide developers in writing additional tests to fill those gaps. By regularly monitoring test coverage and striving to increase it, developers can significantly enhance the reliability and maintainability of their Lombok-based applications.

### Will test coverage tools like JaCoCo have an accurate test coverage report for projects that utilizes lombok?

Test coverage tools like JaCoCo or alike can provide accurate test coverage reports for projects that utilize Lombok. Lombok-generated code, including getters, setters, and constructors, is treated as regular code by test coverage tools.

When running your tests with a coverage tool like JaCoCo, the tool instruments your code to track which lines and branches are executed during the test run. This instrumentation process includes the Lombok-generated code, and the coverage tool can accurately measure the coverage of those lines.

It is worth mentioning that code generated by Lombok is generally uncomplicated and easy to understand. As a result, the coverage impact of these lines may be relatively minimal when compared to the remaining portions of your codebase. This is due to the fact that Lombok-generated methods often comprise of boilerplate code that is straightforward and unlikely to involve intricate logic or branching.

However, you'll be glad to know that test coverage tools can offer you valuable insights regarding your test coverage, even when it comes to the Lombok-generated code. They come in handy by pinpointing areas that could benefit from extra test cases, guaranteeing that your tests thoroughly exercise the functionality provided by Lombok.

To obtain accurate test coverage reports for projects that use Lombok, make sure to configure and run your coverage tool appropriately, ensuring that the Lombok-generated code is included in the coverage analysis.

#### JaCoCo Configuration for Including Lombok-Generated Code

To configure JaCoCo to include Lombok-generated code in the code coverage analysis, you need to modify the JaCoCo configuration to include the necessary Lombok-generated classes. Here's an example of how you can configure JaCoCo to include Lombok-generated code:

```xml
<build>
    <plugins>
        <!-- JaCoCo Maven Plugin -->
        <plugin>
            <groupId>org.jacoco</groupId>
            <artifactId>jacoco-maven-plugin</artifactId>
            <version>0.8.7</version>
            <configuration>
                <includes>
                    <!-- Include Lombok-generated classes -->
                    <include>**/lombok/**/*.class</include>
                    <include>**/lombok/*.class</include>
                </includes>
            </configuration>
            <executions>
                <execution>
                    <id>prepare-agent</id>
                    <goals>
                        <goal>prepare-agent</goal>
                    </goals>
                </execution>
                <execution>
                    <id>report</id>
                    <phase>test</phase>
                    <goals>
                        <goal>report</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

In this example, the _\<includes\>_ element is used to specify the patterns for including the Lombok-generated classes in the code coverage analysis. The patterns _\**/lombok/\**/*.class_ and _\**/lombok/*.class_ are used to include classes in the _lombok_ package and its subpackages.

Make sure to adjust the include patterns according to your project's specific package structure if necessary.

With this configuration, when you run the JaCoCo code coverage analysis, it will include the coverage information for the Lombok-generated code along with your other codebase, providing a more comprehensive picture of your code's test coverage.

**Maven command to generate the code coverage report:**
```shell
$> mvn clean test jacoco:report
```

### Is it a good practice to exclude generated code from test coverage?

Excluding generated code from test coverage is a common practice and can be beneficial in certain scenarios. While there is no definitive answer as to whether it is always a good practice, here are some considerations to help you make an informed decision:

#### Generated Code

Lombok-generated code, such as getters, setters, and constructors, is typically simple and straightforward, often consisting of boilerplate code. Since Lombok handles the generation of this code, it is less likely to contain complex logic or critical business rules. Excluding such code from test coverage can help focus your tests on the more critical and business-specific parts of your codebase.

When it comes to custom Lombok **builder** methods, the decision to exclude them from test coverage depends on their complexity and the significance of their role in your application.

If your custom Lombok builder methods involve **additional logic** or contain critical business rules, it is **generally a good practice to include them in test coverage**. These methods may have a direct impact on the behavior and correctness of your application, so it's important to ensure they are adequately tested.

On the other hand, if your custom Lombok builder methods primarily serve as convenience methods for constructing objects with predefined values, and they don't involve complex logic or critical business rules, excluding them from test coverage may be reasonable. These methods are often simple and straightforward, and their behavior can be indirectly tested through the tests that exercise the usage of the constructed objects.

The main idea behind excluding generated code from test coverage is to focus your testing efforts on the critical and business-specific parts of your codebase. If the custom Lombok builder methods fall into that category, it is advisable to include them in your test coverage to ensure their correctness and adherence to business rules.

#### Test Maintainability

Including generated code in test coverage can increase the complexity and maintenance effort of your tests. As generated code is often automatically generated and subject to change, updating tests for every change in the generated code can become cumbersome and result in unnecessary test maintenance overhead.

#### Focus on Business Logic

By excluding generated code from test coverage, you can prioritize testing the business logic and critical components of your application. This allows you to allocate your testing efforts more effectively and concentrate on areas that have a higher impact on the functionality and behavior of your system.

#### Code Quality Metrics

Excluding generated code from test coverage can help provide a more accurate reflection of the quality and coverage of your business-specific code. It allows you to gauge the effectiveness of your tests in covering the essential parts of your application rather than focusing on the repetitive and boilerplate aspects.

However, it's important to note that there are situations where including generated code in test coverage might be beneficial. If the generated code contains custom logic or modifications, or if it is critical to the functionality of your application, it may be worthwhile to include it in your coverage analysis.

Ultimately, the decision to exclude or include generated code in test coverage should be based on the specific context, requirements, and trade-offs of your project. Consider factors such as code complexity, maintainability, and the overall testing strategy to determine the most appropriate approach for your situation.

## How do I exclude Lombok from test coverage?

To exclude Lombok-generated code from test coverage measurements, you can configure your code coverage tool to ignore specific classes or packages related to Lombok. The exact steps may vary depending on the coverage tool you are using. 

An article that discusses excluding generated code from test coverage can be found here:

- [Lombok • Exclude Generated Code From Test Coverage](/java/2023/03/13/lombok-exclude-generated-code-from-test-coverage.html)

## In Conclusion

Lombok is a powerful tool for reducing boilerplate code in Java projects. However, it is crucial to ensure that the generated code is thoroughly tested to maintain the overall quality of the application. 

By focusing on testing both the generated code and its interaction with the rest of the codebase, developers can achieve comprehensive test coverage. 

Incorporating code coverage tools into the development process further enhances this goal by providing valuable insights into the coverage achieved and areas that require additional testing. With proper attention to test coverage, Lombok can contribute to more efficient and reliable software development practices.



