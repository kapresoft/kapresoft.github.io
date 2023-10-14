---
title: "Spring Validator • Resolving Error Codes"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/01/spring-validator-resolving-error-codes.html
category: java
related: spring
description: "Spring Framework Resolving error codes to user-friendly messages with YAML MessageSource. Master data consistency in web apps."
---

## Overview

Data validation is paramount for web applications, ensuring user input aligns with application expectations. Within the Spring ecosystem, validation and error message translation are critical components, enhancing user experience.<!--excerpt--> In this comprehensive guide, we'll explore Spring's validation mechanisms and understand how to resolve validation errors to meaningful messages using a YAML MessageSource.

## An Overview of Spring Validation

Spring Validation is an intrinsic part of the Spring framework, designed for verifying data correctness before its processing.

### **Spring Validator**
At the heart of Spring's validation process is the _Spring Validator_, which offers the ability to define custom validation rules. By implementing the _Validator Interface_, developers can institute specific rules tailored to their application needs.

### **Bean Validation**
_Bean Validation_ within Spring interfaces with the standard validation API. It facilitates the use of annotations, like _@NotNull_ or _@Size_, enabling developers to establish validation parameters within their models or DTO classes.

## Custom Validators in Spring

While Spring offers a suite of standard validators, it also allows developers to curate custom validators, addressing unique business rules that standard annotations cannot capture.

### **Building Custom Validators**
To act as a custom validator, a class should implement the _Validator interface_. This requires:

- _support_ method: To identify which class the validator supports.
- _validate_ method: For executing the custom validation logic.

After being set up, these validators can seamlessly integrate into the Spring ecosystem.

## Translating Validation Errors for Users

Validation errors, though precise, are technically verbose. Translating these to comprehensible messages is crucial for a better user experience.

### **MessageCodesResolver**
Spring manages its message resolution via _MessageCodesResolver_. It identifies which error codes correlate with a validation error. By default, Spring employs _DefaultMessageCodesResolver_. For a validation error, this resolver logs multiple codes. For example, for an 'age' field error with the code 'invalid.age', the resolver logs codes like 'invalid.age.field' and 'invalid.age.type', providing a detailed error context.

### **Employing YAML MessageSource for Error Messages**
For a more organized and readable configuration, Spring allows the use of YAML files as a _MessageSource_. By using a YAML file, developers can define user-friendly messages corresponding to the error codes registered by _MessageCodesResolver_.

## A Real-World YAML Example

Imagine an _Order_ entity in a web application with properties such as _Order Date_ and _Order Price_. Let's craft a custom validation rule ensuring the _Order Price_ isn't negative.

```java
public class OrderValidator implements Validator {
    
    @Override
    public boolean supports(Class<?> clazz) {
        return Order.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Order order = (Order) target;
        if(order.getPrice().compareTo(BigDecimal.ZERO) < 0) {
            errors.rejectValue("price", "order.price.negative");
        }
    }
}
```

Here, a negative order price registers the error code _order.price.negative_. This error code can then be resolved via a YAML-based _MessageSource_.

To configure a YAML _MessageSource_:

```yaml
order:
  price:
    negative: The order price cannot be negative.
```

Spring's configuration to use the above YAML:

```java
@Bean
public MessageSource messageSource() {
    YamlMessageSource ms = new YamlMessageSource();
    ms.setBasename("classpath:messages");
    ms.setDefaultEncoding("UTF-8");
    return ms;
}
```

In the setup, _messages.yaml_ holds our translations. When the error code _order.price.negative_ is triggered, the corresponding message, "The order price cannot be negative," is displayed to the user.

## Concluding Thoughts

Spring Validation is a potent tool, ensuring data consistency within web applications. By effectively translating technical error codes to user-centric messages, especially via structured YAML files, Spring amplifies the user experience and robustness of applications.
