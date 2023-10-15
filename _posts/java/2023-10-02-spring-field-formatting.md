---
title: "Spring Field Formatting"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/02/spring-field-formatting.html
category: java
related: spring
description: "Guide on Spring Field Formatting, exploring its core components, practical implementations, and significance in the Spring Framework."
---

## Overview

Spring Field Formatting is a pivotal component of the Spring Framework, allowing seamless data conversion and rendering across various contexts, particularly in client environments. This guide provides an in-depth look into the mechanics, interfaces, and practical implementations of Spring Field Formatting, elucidating its significance in modern web and desktop applications.<!--excerpt-->

## Overview of the ConversionService API

The Spring Framework's _core.convert_ is a robust type conversion system that provides the _ConversionService_ API. This system aids in binding bean property values, and it's crucial for both the Spring Expression Language (SpEL) and DataBinder when binding field values.

For instance, in environments like web or desktop applications, typical type conversion requirements involve converting between Strings and other data types for various processes such as client postbacks and view rendering. Furthermore, these strings often necessitate localization.

While the core.convert _Converter_ SPI is versatile, it doesn't directly cater to the formatting requirements of these environments. Enter the _Formatter_ SPI, which Spring offers to specifically address these formatting challenges.

## Introduction to the Formatter SPI

The _Formatter_ SPI offers a structured way to implement field formatting logic. It's an interface derived from two foundational interfaces: _Printer_ and _Parser_.

```java
package org.springframework.format;

public interface Formatter<T> extends Printer<T>, Parser<T> {}
```

### Printer

_Printer\<T\>_ is responsible for printing the field value, based on the locale.

```java
public interface Printer<T> {
String print(T fieldValue, Locale locale);
}
```

### Parser

_Parser\<T\>_, on the other hand, parses a client's value given the locale.

```java
import java.text.ParseException;

public interface Parser<T> {
  T parse(String clientValue, Locale locale) throws ParseException;
}
```

When implementing your own Formatter, it's paramount to ensure thread-safety. It's also worth noting that the format subpackages come with numerous pre-implemented Formatter classes for convenience.

## Annotation-Driven Formatting

Spring allows field formatting to be configured either by field type or through annotations. When you need to bind an annotation to a Formatter, the _AnnotationFormatterFactory_ interface comes into play.

```java
package org.springframework.format;

public interface AnnotationFormatterFactory<A extends Annotation> {
    Set<Class<?>> getFieldTypes();
    Printer<?> getPrinter(A annotation, Class<?> fieldType);
    Parser<?> getParser(A annotation, Class<?> fieldType);
}
```

This interface provides a robust way to tie annotations with formatters, thereby enhancing customization and flexibility in field formatting. For instance, the _@NumberFormat_ annotation can be bound to a specific formatter to define a number's style or pattern.

Annotation-driven Formatting is a mechanism in Spring that allows developers to specify how a particular field should be formatted or parsed by simply annotating it. This eliminates the need for manual formatting and parsing in the application code. Here are some examples that demonstrate this concept:

### 1. Date Formatting using _@DateTimeFormat_

Suppose you have a model class with a _Date_ field, and you want to ensure that this field is always formatted as "yyyy-MM-dd" when rendered in a view:

```java
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

public class Event {

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date eventDate;

    // getters and setters
}
```

With the above annotation, the _eventDate_ will automatically be formatted as "yyyy-MM-dd" when presented in views.

### 2. Number Formatting using _@NumberFormat_

Suppose you have a field representing a monetary amount and you want to ensure it's formatted as currency:

```java
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

public class Product {

    @NumberFormat(style = Style.CURRENCY)
    private BigDecimal price;

    // getters and setters
}
```

The _price_ will automatically be formatted in the currency style, such as "$100.00".

### 3. Custom Annotation Formatting

Let's imagine you have a custom annotation that requires a specific formatter. You would first create the annotation:

```java
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface CustomFormat {
    String value() default "";
}
```

Then, you would create a custom formatter and an _AnnotationFormatterFactory_ for this annotation:

```java
import org.springframework.format.AnnotationFormatterFactory;
import org.springframework.format.Parser;
import org.springframework.format.Printer;

public class CustomFormatAnnotationFormatterFactory implements AnnotationFormatterFactory<CustomFormat> {

    @Override
    public Set<Class<?>> getFieldTypes() {
        return Collections.singleton(String.class);
    }

    @Override
    public Printer<?> getPrinter(CustomFormat annotation, Class<?> fieldType) {
        return new CustomPrinter(annotation.value());
    }

    @Override
    public Parser<?> getParser(CustomFormat annotation, Class<?> fieldType) {
        return new CustomParser(annotation.value());
    }
}
```

In your model, you can then use this annotation:

```java
public class UserDetails {

    @CustomFormat("custom-pattern")
    private String customField;

    // getters and setters
}
```

These are just a few examples of how "Annotation-driven Formatting" can be applied in Spring applications. The main advantage is that the formatting logic is decoupled from the application logic, ensuring cleaner and more maintainable code.

## The FormatterRegistry SPI

The _FormatterRegistry_ SPI (Service Provider Interface) plays a central role in registering formatters and converters.

```java
package org.springframework.format;

public interface FormatterRegistry extends ConverterRegistry {
    void addPrinter(Printer<?> printer);
    void addParser(Parser<?> parser);
    //... other methods
}
```

This registry facilitates centralized configuration of formatting rules, promoting consistency and reduced redundancy. For instance, by using a shared FormatterRegistry, date fields formatting can be standardized across the application.

The _FormatterRegistry_ SPI in Spring provides an API to register custom formatters and converters. This allows developers to define how specific types should be converted and formatted in the Spring application.

Here's a look at some examples:

### 1. Registering a Custom Formatter

Let's say you have a custom formatter for converting strings to uppercase:

```java
public class UppercaseFormatter implements Formatter<String> {
    
    @Override
    public String print(String object, Locale locale) {
        return object;
    }
    
    @Override
    public String parse(String text, Locale locale) throws ParseException {
        return text.toUpperCase();
    }
}
```

To register this formatter, you would use the _FormatterRegistry_:

```java
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addFormatter(new UppercaseFormatter());
    }
}
```

### 2. Registering a Converter

Imagine you have a converter that transforms a string into a custom _Profile_ object:

```java
public class StringToProfileConverter implements Converter<String, Profile> {
    
    @Override
    public Profile convert(String source) {
        // Split the source based on comma and create a profile object
        String[] parts = source.split(",");
        return new Profile(parts[0], parts[1]);
    }
}

public class Profile {
    private String name;
    private String email;
    
    // Constructor, getters, setters
}
```

Registering this converter would look like this:

```java
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new StringToProfileConverter());
    }
}
```

### 3. Using _FormatterRegistrar_

If you have multiple formatters and converters and want to register them collectively, you can use the _FormatterRegistrar_:

```java
public class MyFormatterRegistrar implements FormatterRegistrar {

    @Override
    public void registerFormatters(FormatterRegistry registry) {
        registry.addFormatter(new UppercaseFormatter());
        registry.addConverter(new StringToProfileConverter());
        // ... other formatters and converters
    }
}

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addFormatters(FormatterRegistry registry) {
        MyFormatterRegistrar registrar = new MyFormatterRegistrar();
        registrar.registerFormatters(registry);
    }
}
```

These examples demonstrate how to work with the _FormatterRegistry_ SPI to manage formatters and converters within a Spring application. Using this approach ensures type safety and clean data transformation throughout the application.

## In Conclusion

The Spring Framework's field formatting capabilities, rooted in the _ConversionService_ API and the _Formatter_ SPI, empower developers to efficiently convert and format data across various contexts. This guide has illuminated the intricacies of Spring Field Formatting, underscoring its relevance in modern application development.
