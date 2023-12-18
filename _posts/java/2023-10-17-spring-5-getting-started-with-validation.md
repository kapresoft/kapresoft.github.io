---
title: "Spring 5 • Getting Started With Validation"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/17/spring-5-getting-started-with-validation.html
category: java
related: spring
description: "Learn to implement secure and efficient validation in Spring Boot. This guide covers best practices, input validation, constraints, and exception handling."
---

## Overview

Validation is an essential aspect of any Spring Boot application. Employing rigorous validation logic ensures that your application remains secure and efficient. This article discusses various ways to integrate Bean Validation into your Spring Boot application within the Java ecosystem. We'll also explore how to avoid common pitfalls and improve your validation processes.<!--excerpt-->

## Disclaimer: Spring Version Compatibility

Please note that the content of this article is applicable to Spring versions 5 or below. As of Spring version 6, the preferred approach for validation has evolved, with the introduction of the new _@Constraint_ annotation.

Spring 6 introduces significant changes and improvements in the validation framework, and it is recommended to refer to the latest Spring documentation and resources for guidance on using the _@Constraint_ annotation and other features specific to Spring 6 and beyond.

While the information provided in this article remains valuable for projects using Spring 5 or earlier versions, we advise developers working with Spring 6 or newer versions to consult the most up-to-date documentation and resources provided by the Spring Framework team to ensure compliance with the latest best practices and changes in the framework.

## Getting Started with Spring Boot Validation

In Spring Boot, you initiate the validation process by incorporating the Spring Boot Validation Starter. Here is how to include it using Gradle:

Maven:

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```

Gradle:

```groovy
implementation('org.springframework.boot:spring-boot-starter-validation')
```

Including the Spring Boot Web Starter will add Bean Validation capabilities automatically:

Maven:

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

Gradle:

```groovy
implementation('org.springframework.boot:spring-boot-starter-web')
```

The starter simply adds a dependency to a compatible version of Hibernate Validator, the most widely used Bean Validation implementation.

## Common Bean Validation Annotations

Spring Boot utilizes a variety of annotations for validation logic. Some common annotations are:

- _@NotNull_: Ensures the field is not null.
- _@NotEmpty_: Ensures the field is not empty if it's a list.
- _@NotBlank_: Ensures that a String is not empty or null.
- _@Min_ and _@Max_: Set the minimum and maximum value for numeric fields.
- _@Pattern_: Ensures a string field matches a regex pattern.
- _@Email_: Validates if a string field contains a valid email address.

Here's a quick example to demonstrate:

```java
public class User {
  @Email
  private String email;
  
  @NotBlank
  private String username;
  
  // More fields and methods
}
```

## Using @Valid and @Validated Annotations

Spring Boot allows you to automate the validation process using _@Valid_ and _@Validated_ annotations.

- _@Validated_: It is a class-level annotation that tells Spring to evaluate the constraints on method parameters within the annotated class.
- _@Valid_: Apply this annotation to method parameters or fields that you wish to validate.

Here's an example:

```java
@Service
@Validated
public class UserService {
  public void addUser(@Valid User user) {
    // Service logic
  }
}
```

## Validation in Spring MVC Controllers

### Validating Request Body

When developing a Spring REST controller, validating the incoming HTTP request is vital. Spring Boot can automatically map the incoming JSON payload to a Java object. You can ensure this object meets your requirements by annotating the object with _@Valid_.

```java
@RestController
public class UserController {
  @PostMapping("/users")
  public ResponseEntity<String> addUser(@Valid @RequestBody User user) {
    return ResponseEntity.ok("User is valid");
  }
}
```

### Validating Path Variables and Request Parameters

Path variables and HTTP request parameters can also be validated using annotations. You can attach constraint annotations directly to method parameters within your Spring MVC Controller.

```java
@RestController
@Validated
public class UserController {
  @GetMapping("/users/{id}")
  public ResponseEntity<String> getUser(@PathVariable("id") @Min(1) int id) {
    return ResponseEntity.ok("Path variable is valid");
  }
}
```

## Implementing Custom Validators

Sometimes, built-in annotations and validators are insufficient. In such cases, you can create custom validators to meet specific requirements. For instance, to validate an IP address more accurately, you can define a custom constraint annotation and an associated _ConstraintValidator_ implementation.

```java
// Custom Annotation
@Constraint(validatedBy = IpAddressValidator.class)
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidIpAddress {
  // Annotation elements
}

// Validator
public class IpAddressValidator implements ConstraintValidator<ValidIpAddress, String> {
  public void initialize(ValidIpAddress constraint) {
  }

  public boolean isValid(String obj, ConstraintValidatorContext context) {
    // Validation logic
  }
}
```

### Example Usage

In our example, we illustrate the implementation of a custom validator, _ValidIpAddress_, which ensures the accuracy of IP address inputs. This custom validator is seamlessly integrated into a _MyClass_ class, demonstrating how to harness its power to validate IP addresses effectively. Let's delve into this practical example to understand how custom validation can be effortlessly incorporated into your Java applications to enhance data integrity and security.

```java
public class MyClass {
    @ValidIpAddress
    private String ipAddress;

    public MyClass(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getIpAddress() {
        return ipAddress;
    }
}
```

### Unit Test

Unit testing is a critical aspect of software development, ensuring that individual components of a system function as expected in isolation. When it comes to custom validators like _IpAddressValidator_, comprehensive unit testing becomes even more crucial. Custom validators play a vital role in validating specific data formats or constraints, such as IP addresses, and ensuring their accuracy is essential to maintaining data integrity and security within an application. In this context, we'll emphasize the importance of thoroughly testing the _IpAddressValidator_ to validate IP address inputs correctly, ensuring that it meets the required validation criteria and safeguarding the application against potential vulnerabilities arising from incorrect validation.

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import javax.validation.*;
import java.util.Set;

public class MyClassTest {

    @Test
    void testValidIpAddress() {
        // Create a ValidatorFactory and get a Validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();

        // Create a mock MyClass instance with a valid IP address
        MyClass myObject = new MyClass("192.168.1.1");

        // Validate the object
        Set<ConstraintViolation<MyClass>> violations = validator.validate(myObject);

        // Assert that there are no validation violations
        assertTrue(violations.isEmpty());

        // Close the factory
        factory.close();
    }

    @Test
    void testInvalidIpAddress() {
        // Create a ValidatorFactory and get a Validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();

        // Create a mock MyClass instance with an invalid IP address
        MyClass myObject = new MyClass("invalid_ip");

        // Validate the object
        Set<ConstraintViolation<MyClass>> violations = validator.validate(myObject);

        // Assert that there is one validation violation
        assertEquals(1, violations.size());

        // Close the factory
        factory.close();
    }
}

```

## Exception Handling and HTTP Status 400

When validation fails, Spring Boot generally throws a _ConstraintViolationException_. To return an HTTP 400 status code instead, add a custom exception handler to your controller

```java
@ControllerAdvice
public class CustomExceptionHandler {
  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<Object> handleConstraintViolation(MethodArgumentNotValidException ex) {
    return new ResponseEntity<>("Validation error", HttpStatus.BAD_REQUEST);
  }
}
```

## Service-Level Validation

Beyond controller-level validation, it's advisable to add additional validation logic within your service layers, especially if your application has complex business rules.

```java
@Service
@Validated
public class UserService {
  public void addUser(@Valid User user) {
    // Additional validation logic
  }
}
```

## Conclusion

Effective validation is crucial for a secure and functional Spring Boot application. Whether it's basic field-level validations using Bean Validation annotations, custom validation logic, or service-level constraints, Spring Boot offers a flexible validation mechanism to suit any requirement. By mastering these techniques, you can ensure your Spring Boot application not only complies with best practices but is also robust and secure.
