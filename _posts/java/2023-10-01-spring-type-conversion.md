---
title: "Spring Type Conversion"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/01/spring-type-conversion.html
category: java
related: spring
description: "Guide on Spring Type Conversion, diving into core concepts, use-cases, and practical implementations using the Spring Framework."
---

## Overview

Spring provides a robust type conversion system through its _core.convert_ package, offering a versatile mechanism for converting data types within your applications. This system leverages an SPI (Service Provider Interface) for implementing type conversion logic and a user-friendly API for executing these conversions during runtime.<!--excerpt--> This article will explore the Spring type conversion system in-depth, covering the SPI, various converter implementations, and best practices for utilizing this feature effectively.

## Converter SPI
At the heart of Spring's type conversion system is the Converter SPI (Service Provider Interface), which is both simple and strongly typed. The _Converter<S, T>_ interface defines a single method:

```java
public interface Converter<S, T> {
    T convert(S source);
}
```

To create your custom converter, you need to implement this interface, specifying the source (_S_) and target (_T_) types you intend to convert between. When implementing a converter, ensure that the _convert_ method can handle any non-null source value and throw an _IllegalArgumentException_ if the conversion fails. Thread safety should also be a consideration for your implementation.

## Built-in Converters
Spring offers a set of pre-implemented converters in the _core.convert.support_ package to handle common conversion scenarios. For example, consider the _StringToInteger_ converter:

```java
final class StringToInteger implements Converter<String, Integer> {
    public Integer convert(String source) {
        return Integer.valueOf(source);
    }
}
```

These built-in converters cover conversions between strings and numbers and other frequently used types, saving you the effort of writing converters for common cases.

## Using ConverterFactory
When you need to centralize conversion logic for an entire class hierarchy or perform complex conversions, you can implement the _ConverterFactory_ interface. Here's how it works:

```java
public interface ConverterFactory<S, R> {
    <T extends R> Converter<S, T> getConverter(Class<T> targetType);
}
```

In this interface, _S_ represents the source type, and _R_ is the base type for the target classes. You implement the _getConverter_ method, which returns a _Converter<S, T>_ for the desired target type _T_.

As an example, consider the _StringToEnumConverterFactory_, which converts strings to enum values:

```java
final class StringToEnumConverterFactory implements ConverterFactory<String, Enum> {
    public <T extends Enum> Converter<String, T> getConverter(Class<T> targetType) {
        return new StringToEnumConverter(targetType);
    }

    private final class StringToEnumConverter<T extends Enum> implements Converter<String, T> {
        private Class<T> enumType;

        public StringToEnumConverter(Class<T> enumType) {
            this.enumType = enumType;
        }

        public T convert(String source) {
            return (T) Enum.valueOf(this.enumType, source.trim());
        }
    }
}
```

This converter factory allows you to handle conversions from strings to enum types effectively.

## Using GenericConverter
For even more sophisticated conversion scenarios, Spring offers the _GenericConverter_ interface. This interface is less strongly typed than _Converter_ and supports converting between multiple source and target types. Additionally, it provides context for conversion, enabling you to make decisions based on field annotations or generic information in the field signature.

```java
public interface GenericConverter {
    Set<ConvertiblePair> getConvertibleTypes();
    Object convert(Object source, TypeDescriptor sourceType, TypeDescriptor targetType);
}
```

To implement a _GenericConverter_, you specify the supported source→target type pairs using the _getConvertibleTypes_ method and provide your conversion logic in the _convert_ method. The _TypeDescriptor_ objects give you access to source and target fields, allowing you to make context-aware conversion decisions.

## Conditional Conversion
In some cases, you may want a converter to run only when specific conditions are met. Spring provides the _ConditionalGenericConverter_ interface, which combines _GenericConverter_ and _ConditionalConverter_. This allows you to define custom matching criteria for when a converter should be applied:

```java
public interface ConditionalConverter {
    boolean matches(TypeDescriptor sourceType, TypeDescriptor targetType);
}

public interface ConditionalGenericConverter extends GenericConverter, ConditionalConverter {
}
```

A typical use case for conditional conversion is running a converter only when a particular annotation is present on the target field or when a specific method is defined in the target class.

## ConversionService API
Spring's _ConversionService_ defines a unified API for executing type conversions at runtime. It provides methods for checking if a conversion is possible and for performing the conversion itself. The _ConversionService_ can be used behind a facade interface for convenient type conversion:

```java
public interface ConversionService {
    boolean canConvert(Class<?> sourceType, Class<?> targetType);
    <T> T convert(Object source, Class<T> targetType);
    boolean canConvert(TypeDescriptor sourceType, TypeDescriptor targetType);
    Object convert(Object source, TypeDescriptor sourceType, TypeDescriptor targetType);
}
```

Most _ConversionService_ implementations also implement _ConverterRegistry_, which allows you to register custom converters. These converters are then used by the _ConversionService_ to carry out type conversion operations.

## Configuring a ConversionService
To use a _ConversionService_ in your Spring application, you typically configure it during application startup and share it across multiple threads. You can register a default _ConversionService_ with Spring using the following bean definition:

```xml
<bean id="conversionService" class="org.springframework.context.support.ConversionServiceFactoryBean"/>
```

A default _ConversionService_ can handle conversions between strings, numbers, enums, collections, maps, and other common types. To add your custom converters or override default ones, set the _converters_ property in the bean definition.

```xml
<bean id="conversionService" class="org.springframework.context.support.ConversionServiceFactoryBean">
    <property name="converters">
        <set>
            <bean class="example.MyCustomConverter"/>
        </set>
    </property>
</bean>
```

This configuration allows you to extend the conversion capabilities to suit your application's specific needs.

## Using a ConversionService Programmatically
To utilize a _ConversionService_ programmatically, you can inject a reference to it into your beans and invoke it directly. Here's an example:

```java
@Service
public class MyService {
    private final ConversionService conversionService;

    public MyService(ConversionService conversionService) {
        this.conversionService = conversionService;
    }

    public void doIt() {
        // Perform type conversion using the conversionService
        // ...
    }
}
```

You can use the _convert_ method, specifying the target type, for most use cases. However, for more complex type conversions, such as converting a list of integers to a list of strings, you may need to use _TypeDescriptor_ to specify the source and target types explicitly.

## Conclusion
Spring's type conversion system is a powerful and flexible feature that simplifies data type conversions within your applications. By understanding the Converter SPI, built-in converters, _ConverterFactory_, _GenericConverter_, and conditional conversion, you can effectively handle a wide range of conversion scenarios. Additionally, configuring a _ConversionService_ and using it programmatically allows you to seamlessly integrate type conversions into your Spring applications. Whether you're working with strings, numbers, enums, collections, or custom types, Spring's type conversion system provides the tools you need to manage data types efficiently.
