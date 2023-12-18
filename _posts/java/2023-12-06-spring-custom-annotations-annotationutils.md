---
title: "Spring • Custom Annotations & AnnotationUtils"
title_style: title2w
section_style: article1
category: java
related: spring
canonical_url: https://www.kapresoft.com/java/2023/12/06/spring-custom-annotations-annotationutils.html
description: "Unlocking the Potential of Custom Annotations in Java and Spring using AnnotationUtils."
---

## Overview

<a href="https://spring.io/projects/spring-framework" target="_blank" alt="Spring">Spring</a>, a powerhouse in the Java ecosystem, is renowned for simplifying the development process of stand-alone, production-grade Spring-based applications. At its core, Spring leverages annotations, a form of metadata that provides data about a program but isn’t part of the program itself. These annotations are pivotal in reducing boilerplate code, making your codebase cleaner and more maintainable.<!--excerpt-->

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/springboot-custom-annotations-in-action-40f9d4d.webp" alt="Image: Spring • Custom Annotations with AnnotationUtils">
</div>

Delving into custom annotations in Spring unlocks a new realm of possibilities. Custom annotations extend the capabilities of predefined ones, allowing developers to tailor functionality to their specific needs. They are instrumental in implementing cross-cutting concerns, ensuring code consistency, and enforcing best practices across the application. Whether it's streamlining configuration processes, enhancing readability, or creating custom validation routines, custom annotations can significantly optimize both development and maintenance phases of your Spring applications.

In the following sections, we will explore the fundamentals of creating and utilizing custom annotations in Spring. This journey will equip you with the knowledge to harness the full potential of annotations, paving the way for more efficient and effective code solutions.

## Understanding the Basics of Annotations

Annotations in Java, marked by the "@" symbol, are metadata tags that can be applied to various elements like classes, methods, or fields. Originating from Java 5, they represent a powerful and flexible means of adding metadata information to your code. Unlike comments, annotations are not merely for the programmer’s reference; they can influence the way a program is executed.

In the context of Spring, annotations play a critical role. They are the linchpins that hold together the framework, providing a declarative way of defining configurations and behaviors. For instance, _@SpringBootApplication_ is an annotation that denotes the starting point of a Spring application, combining _@Configuration_, _@EnableAutoConfiguration_, and _@ComponentScan_ annotations under the hood. Similarly, _@RestController_ and _@RequestMapping_ annotations are used for creating RESTful web services.

Spring's use of annotations extends to various aspects like dependency injection (_@Autowired_), aspect-oriented programming (_@Aspect_), and transaction management (_@Transactional_). This extensive use of annotations contributes to the reduction of boilerplate code, making the code more readable and manageable.

Moreover, Spring annotations are not limited to those provided out-of-the-box. The framework offers the flexibility to create custom annotations, enabling developers to encapsulate recurring patterns and logic into reusable elements. This not only streamlines the code but also promotes a more organized and consistent coding standard within the application.

In essence, understanding annotations is crucial for any developer working with Spring. They form the backbone of the framework, simplifying configuration and enabling a range of functionalities that are both powerful and easy to implement. In the next sections, we will delve into how you can create and leverage custom annotations to further enhance your Spring applications.

## The Building Blocks of Custom Annotations

The creation of custom annotations in Java, and by extension in Spring, hinges on the use of a specific _keyword_: _@interface_. This keyword is the cornerstone in defining a custom annotation. It tells the Java compiler that you are declaring an annotation type. The syntax looks deceptively similar to an interface declaration, which is intentional, as annotations themselves are a form of interface.

Here’s a basic structure of a custom annotation:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD) // Can be changed to TYPE, FIELD, etc., based on where you want to use it
public @interface YourCustomAnnotation {
    // Define annotation elements here
    String value() default "Default Value";
}
```

In this structure, two critical meta-annotations are used:

1. **@Retention**: This meta-annotation specifies how the marked annotation is stored. <a href="https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/annotation/RetentionPolicy.html#RUNTIME" target="_blank" alt="RetentionPolicy.RUNTIME">RetentionPolicy.RUNTIME</a> ensures that the annotation is available at runtime for reflection, which is typically the case for annotations used in Spring applications.
2. <a href="https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/annotation/Target.html" target="_blank" alt="@Target">@Target</a>: This defines where your custom annotation can be applied, such as a method, class, or field. In the example, <a href="https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/annotation/ElementType.html#METHOD" target="_blank" alt="ElementType.METHOD">ElementType.METHOD</a> is used, meaning the custom annotation is applicable to methods.

The body of the custom annotation can include elements that resemble method declarations. These elements can have default values and can be accessed later when the annotation is used.

### Overview of Spring's Annotation Utility

Spring provides various utility methods to interact with annotations, making it easier to work with them, especially in more complex scenarios like dealing with inherited annotations or aliases.

1. **AnnotationUtils**: A core class in Spring’s framework, _AnnotationUtils_ provides static methods to find an annotation on a given class, method, or field, even considering meta-annotations. It respects the semantics of annotation inheritance and can also be used to synthesize annotation proxies, which is crucial for handling annotation attributes and their default values.

2. **Retrieving Annotation Values**: When working with custom annotations, it's common to retrieve their parameter values. This can be done using methods like _AnnotationUtils.getValue(Annotation)_, which retrieves the value of the 'value' attribute, or _AnnotationUtils.getAnnotationAttributes(Annotation)_, which provides all the attributes of an annotation in a map format.

### Overview of Spring's Annotation Attribute Constructs

Spring's annotation framework offers a rich set of attribute constructs that can be used to define custom annotations in a flexible way.

1. **'value' as the Default Attribute**: In Spring, the _value_ attribute of an annotation is often used as a default or primary attribute, allowing for concise usage of the annotation. When an annotation has a single attribute, and it's named _value_, you can omit the attribute name in the usage.
2. **@AliasFor**: This is a powerful feature for defining aliases for annotation attributes. By using _@AliasFor_, you can indicate that two attributes of an annotation (or between different annotations) should mirror each other’s values. This is particularly useful for creating composed annotations that build upon existing annotations while adding custom functionality.
3. **Defaults in Annotation Attributes**: Setting default values for attributes in annotations is a common practice. This allows for optional specification of those attributes when the annotation is used, providing flexibility and reducing the need for boilerplate configurations.
4. **Combining Annotations**: Spring also allows combining annotations, where one annotation can 'meta-annotate' another. This helps in creating composite annotations that bundle several other annotations together, reducing repetition and making the code more readable.

Understanding Spring's annotation utilities and attribute constructs is essential for developers using custom annotations in Spring. These tools enhance your application's expressiveness and flexibility, allowing you to encapsulate specific behaviors and configurations. This not only promotes code reuse but also minimizes potential errors. Custom annotations in Java, as applied in Spring, are key in developing efficient, maintainable, and robust applications.

### Example Custom Annotation with Spring's Annotation Utilities

Let's create an example custom annotation that demonstrates the use of Spring's annotation utilities and attribute constructs. We'll also include a sample code snippet to retrieve the value of the annotation parameter at runtime.

#### Defining the Custom Annotation

We'll create an annotation _@ConfigSetting_ with a _value_ attribute and an alias:

```java
import org.springframework.core.annotation.AliasFor;
import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface ConfigSetting {

    @AliasFor("setting")
    String value() default "";

    @AliasFor("value")
    String setting() default "";
}
```

In this annotation, _value_ and _setting_ are aliases for each other, allowing flexible usage of the annotation.

#### Using the Annotation

Apply this annotation to a field in a bean:

```java
@Component
public class ApplicationConfig {

    // Can also be written as
    // @ConfigSetting("configValue") 
    @ConfigSetting(value = "configValue")
    private String configParameter;
    
    // Getters and setters
}
```

#### Retrieving Annotation Value at Runtime

To retrieve the value of the _@ConfigSetting_ annotation at runtime, you can use Spring's _AnnotationUtils_:

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;

@Component
public class AnnotationValueRetriever {

    @Autowired
    private ApplicationConfig applicationConfig;

    public void printConfigSettingValue() {
        try {
            Field field = ApplicationConfig.class.getDeclaredField("configParameter");
            ConfigSetting configSetting = AnnotationUtils.getAnnotation(field, ConfigSetting.class);
            if (configSetting != null) {
                String value = configSetting.value();
                System.out.println("ConfigSetting value: " + value);
            }
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
    }
}
```

In this code, _AnnotationUtils.getAnnotation(field, ConfigSetting.class)_ is used to retrieve the _@ConfigSetting_ annotation from the _configParameter_ field of the _ApplicationConfig_ class. The _value_ method (which is aliased with _setting_) is then called to get the actual value set in the annotation.

This example demonstrates how to define a custom annotation with aliasing and default attributes, and how to retrieve the annotation's values at runtime using Spring's utilities, showcasing the flexibility and power of Spring's annotation framework.

## Creating Custom Annotations in Spring with Bean Post Processor

Custom annotations in Spring can be used in conjunction with a Bean Post Processor to perform actions during the bean initialization phase. In this section, we'll create a custom annotation _@DatabaseConfig_ that retrieves configuration values from a database when a bean is initialized. This annotation will demonstrate how to use a Bean Post Processor to inject dynamic data into your Spring beans.

### Overview of _@DatabaseConfig_

The _@DatabaseConfig_ annotation is designed to be placed on fields in your Spring beans. It takes a _key_ parameter, which is used to fetch corresponding values from a database at the bean initialization phase. This approach is useful for applications that require dynamic configuration based on database-stored values.

### Step-by-Step Guide to Creating the _@DatabaseConfig_ Annotation

#### Step 1: Define the Annotation

To incorporate Spring's aliasing mechanism in the @DatabaseConfig annotation, where key and value are aliases for each other, and to use Spring's annotation utilities for retrieving the annotation parameter value, the updated code for the annotation definition is as follows:

Updated Annotation Definition with Aliasing

First, you'll need to define the _@DatabaseConfig_ annotation:

```java
import org.springframework.core.annotation.AliasFor;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface DatabaseConfig {

    @AliasFor("value")
    String key() default "";

    @AliasFor("key")
    String value() default "";
}
```

This annotation uses _@Retention(RetentionPolicy.RUNTIME)_ to ensure it is available at runtime, and _@Target(ElementType.FIELD)_ to indicate it can be used on fields.

In this definition, the @AliasFor annotation is used to indicate that key and value are aliases of each other. This means that setting either key or value in the annotation will implicitly set the other to the same value.

#### Step 2: Implement a Bean Post Processor

When retrieving the value in the BeanPostProcessor, use Spring's annotation utilities to respect the aliasing:

Create a _BeanPostProcessor_ to process beans with fields annotated with _@DatabaseConfig_:

```java
import org.springframework.core.annotation.AnnotationUtils;

// ... other imports ...

@Component
public class DatabaseConfigBeanPostProcessor implements BeanPostProcessor {

    @Autowired
    private DatabaseConfigService configService;

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        Field[] fields = bean.getClass().getDeclaredFields();
        for (Field field : fields) {
            DatabaseConfig config = AnnotationUtils.getAnnotation(field, DatabaseConfig.class);
            if (config != null) {
                String key = config.key(); // key and value are aliases, so either can be used here
                String value = configService.getValue(key);
                field.setAccessible(true);
                try {
                    field.set(bean, value);
                } catch (IllegalAccessException e) {
                    throw new BeansException("Could not set database config for field: " + field.getName(), e) {};
                }
            }
        }
        return bean;
    }
}
```

In this implementation, the _postProcessBeforeInitialization_ method checks for fields annotated with _@DatabaseConfig_ and sets their values based on the retrieved data from the database.

#### Step 3: Create the Database Configuration Service

The _DatabaseConfigService_ is responsible for fetching the configuration values from the database:

```java
@Service
public class DatabaseConfigService {

    // Method to retrieve the configuration value based on the key
    public String getValue(String key) {
        // Implement the logic to fetch value from the database
        // For example, fetching from a configuration table
        return "fetched_value";
    }
}
```

#### Step 4: Apply the Custom Annotation

Finally, apply the _@DatabaseConfig_ annotation to a field in one of your beans:

```java
@Component
public class SecurityService {

    // Also Valid:
    //   @DatabaseConfig(key = "config.user-service.url")
    //   @DatabaseConfig(value = "config.user-service.url")
    @DatabaseConfig("config.user-service.url")
    private String userServiceURL;

    // Other fields and methods
}
```

With the _@DatabaseConfig_ annotation and a corresponding Bean Post Processor in place, Spring will automatically inject the database-stored configuration values into the annotated fields during the bean initialization phase. This approach demonstrates a powerful way to handle dynamic configurations in a Spring application, ensuring that the application can adapt to changing requirements with minimal code changes. This methodology exemplifies the flexibility and robustness that custom annotations can bring to a Spring application.

## Custom Validation Annotations: Enhancing Data Integrity

Custom validation annotations are a pivotal feature in Spring, offering developers the ability to define specific validation logic that aligns with their application's unique requirements. These annotations enhance data integrity by enabling a more granular and tailored approach to validating data inputs.

### Why Custom Validation Annotations?

While Spring comes with a suite of standard validation annotations (like _@NotNull_, _@Size_, etc.), there are scenarios where these might not suffice. For instance, you may need to validate a complex business rule or check against values stored in a database. Custom validation annotations step in here, allowing you to encapsulate such specific validation logic in an annotation, thus making your code cleaner, reusable, and easier to maintain.

### Creating a Custom Validation Annotation in Spring

#### Step 1: Define the Annotation

Start by defining the custom annotation. For this example, let's create an _@EmailDomain_ annotation to ensure that an email address belongs to a specific domain:

```java
@Documented
@Constraint(validatedBy = EmailDomainValidator.class)
@Target({ ElementType.METHOD, ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface EmailDomain {

    String domain() default "example.com";
    
    String message() default "Email must be from the specified domain";
    
    Class<?>[] groups() default {};
    
    Class<? extends Payload>[] payload() default {};
}
```

Here, _@Constraint_ specifies the class that contains the validation logic. The _domain_ element lets you specify the required domain, and _message_ provides a default error message.

#### Step 2: Create the Validator Class

Next, implement the validation logic in a validator class:

```java
public class EmailDomainValidator implements ConstraintValidator<EmailDomain, String> {

    private String domain;

    @Override
    public void initialize(EmailDomain constraintAnnotation) {
        this.domain = constraintAnnotation.domain();
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) {
            return false;
        }
        return value.endsWith("@" + domain);
    }
}
```

In this class, the _isValid_ method contains the logic to check if the email ends with the specified domain.

#### Step 3: Applying the Custom Annotation

Finally, apply the custom annotation to your model:

```java
public class User {

    @EmailDomain(domain = "mycompany.com")
    private String email;

    // Other fields, constructors, getters, and setters
}
```

In this example, the _@EmailDomain_ annotation ensures that the _email_ field of the _User_ class must be an email address from the "mycompany.com" domain.

Custom validation annotations in Spring offer a powerful way to enforce specific validation rules that are beyond the capabilities of standard annotations. By integrating these annotations, developers can ensure data integrity while maintaining the cleanliness and readability of their codebase. This approach not only enhances the robustness of the application but also contributes to its scalability and maintainability.

## Practical Applications of Custom Annotations

Custom annotations in Spring are not just theoretical constructs; they have numerous practical applications that can enhance functionality and reduce boilerplate code in real-world scenarios. By leveraging these annotations, developers can address specific needs while maintaining a clean and efficient codebase.

### Real-World Scenarios for Custom Annotations

1. **Security and Access Control**: Custom annotations can be used to manage security aspects. For instance, an _@AdminOnly_ annotation can enforce access control, allowing certain operations only when the user has admin privileges.
2. **Logging and Monitoring**: Annotations like _@LogMethodCall_ could automatically log method calls and parameters, which is invaluable for debugging and monitoring purposes.
3. **Transaction Management**: Beyond the standard _@Transactional_ annotation, custom annotations can define specific transactional behaviors for complex business logic, ensuring that certain groups of operations are executed within the same transactional context.
4. **Feature Toggles**: Implementing feature toggles with annotations like _@FeatureToggle("featureName")_ can help in managing the rollout of new features or experimental functionalities.
5. **Custom Business Rules Validation**: Beyond standard field validations, custom annotations can enforce complex business rules. For example, a _@ValidOrder_ annotation could ensure that an order object adheres to specific business logic before processing.
6. **Caching Mechanisms**: Annotations like _@CacheResult_ can be customized to handle caching in a more tailored manner, such as incorporating complex cache key generation logic.
7. **API Versioning**: Managing different versions of an API endpoint can be streamlined using custom annotations, allowing developers to easily route requests to the correct version of a service method.
8. **Configuration Value Retrieval**: Utilize custom annotations for retrieving decrypted configuration values, like credentials, in real-time from services such as AWS Secrets Manager. For instance, an annotation like _@SecretValue("aws/secret/key")_ can be applied to a field to seamlessly inject a decrypted value from AWS Secrets Manager during the bean's initialization phase. This method not only secures sensitive information but also simplifies the retrieval process, maintaining consistency throughout the application. Additionally, it allows AWS Secrets Manager to freely rotate keys as per security protocols without impacting the application, thereby enhancing security and compliance measures.

### Enhancing Functionality and Reducing Boilerplate Code

Custom annotations are instrumental in enhancing the functionality of a Spring application:

- **Centralizing Common Logic**: By encapsulating common patterns and logic in annotations, you centralize this logic and reduce the chances of errors or inconsistencies.
- **Improving Code Readability**: Custom annotations make your code more expressive and easier to understand. For example, _@Throttle_ might be more descriptive than a block of code handling throttling logic.
- **Facilitating Code Reusability**: Once defined, custom annotations can be reused across different parts of the application, promoting DRY (Don't Repeat Yourself) principles.
- **Streamlining Configuration**: They can simplify configuration-related tasks, such as specifying bean properties or configuring aspects.
- **Enhancing Maintainability**: With business logic and other concerns neatly encapsulated in annotations, maintaining and updating the code becomes more straightforward.

Custom annotations in Spring are a powerful tool that can significantly enhance the functionality and maintainability of applications. By providing a means to encapsulate and reuse common patterns and logic, they pave the way for more efficient, clean, and manageable codebases, tailored to the specific needs of real-world scenarios.


## Advanced Tips and Best Practices

When it comes to developing custom annotations in Spring, there are several advanced tips and best practices that can ensure your annotations are not only effective but also efficient and maintainable. These guidelines help in maximizing the benefits of custom annotations while avoiding common pitfalls.

### Tips for Writing Efficient and Effective Custom Annotations

1. **Clearly Define the Purpose**: Each custom annotation should have a well-defined purpose. Avoid creating overly generic annotations that try to do too much, which can lead to confusing and hard-to-maintain code.
2. **Keep It Simple**: The logic within custom annotations should be as simple and focused as possible. Complex logic can be broken down into multiple annotations or handled elsewhere in the application.
3. **Use Descriptive Names**: The name of the annotation should clearly indicate its functionality. For instance, _@ValidateEmailDomain_ is more descriptive than _@EmailCheck_.
4. **Ensure Compatibility**: Make sure your custom annotations are compatible with other annotations and do not unintentionally override or interfere with the framework's built-in functionality.
5. **Optimize for Performance**: Be mindful of the performance implications of your annotations. Avoid heavy computations or database calls within annotation processing, as these can significantly impact the application's performance.
6. **Document Thoroughly**: Provide comprehensive documentation for your custom annotations, explaining their purpose, how to use them, and any parameters they accept. This documentation is vital for both current and future developers.

### Best Practices to Follow While Creating and Using Custom Annotations

1. **Consistent Usage**: Apply your custom annotations consistently throughout your application. Inconsistent usage can lead to bugs and makes the code harder to understand.
2. **Testing**: Thoroughly test your custom annotations to ensure they behave as expected in different scenarios. Unit tests are crucial for verifying their functionality.
3. **Avoid Duplication**: Before creating a new annotation, check if there's already an existing annotation that serves the same purpose, either in Spring or in your codebase.
4. **Use Meta-Annotations**: Leverage meta-annotations to combine several annotations into one, thereby reducing redundancy and making the annotations easier to manage.
5. **Balance Between Custom and Built-In Annotations**: While custom annotations are powerful, also consider the benefits of using built-in annotations provided by Spring. Striking the right balance is key.
6. **Version Control and Backward Compatibility**: If you update a custom annotation, ensure backward compatibility, or provide a clear migration path. Versioning your annotations can be a practical approach.
7. **Integration with the Spring Ecosystem**: Ensure that your custom annotations integrate seamlessly with other parts of the Spring ecosystem, like Spring Security, Spring Data, etc.

While custom annotations in Spring offer great power and flexibility, they should be used judiciously and with a clear understanding of their impact on the application. By adhering to these advanced tips and best practices, you can create custom annotations that not only enhance your application's functionality but also contribute to its overall quality and maintainability.
