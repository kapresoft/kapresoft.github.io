---
title: "Transform Your Data: Advanced List Conversion Techniques in Spring"
title_style: title2w
section_style: article1
category: java
related: spring
canonical_url: https://www.kapresoft.com/java/2024/01/02/spring-conversion-service-converting-lists.html
description: "Master Spring ConversionService for object list conversions with this concise guide, enhancing your Java development skills."
---

## Overview

The <a href="https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/core/convert/ConversionService.html" target="_blank" alt="ConversionService">_ConversionService_</a> of the <a href="/java/2021/11/03/spring-boot-serialize-immutable-objects.html" target="_blank" alt="Spring Framework">Spring Framework</a> plays a crucial role in simplifying data conversion tasks, particularly for converting lists from one type to another. This article zeroes in on understanding and leveraging the _Spring Conversion Service_ specifically for list conversions, an essential skill for effective and accurate coding in Spring applications.<!--excerpt--> We will delve into its functionality and offer practical advice for its implementation in various scenarios, thus enhancing your proficiency in handling list data transformations within Spring.

## Converting a List of String to a List of Integer

The conversion of data types is a common task, particularly when dealing with diverse data inputs and outputs. The code snippet provided is an excellent example of using Spring's conversion capabilities to transform a list of strings into a list of integers. Here, we utilize the <a href="https://github.com/spring-projects/spring-framework/blob/main/spring-core/src/main/java/org/springframework/core/convert/support/StringToNumberConverterFactory.java" target="_blank" alt="_StringToNumberConverterFactory_">_StringToNumberConverterFactory_</a>, a built-in feature of Spring, to achieve this. This concept can be extended to other list-type collections like Set or LinkedList, demonstrating the versatility of Spring's conversion capabilities in handling various data structures.

To demonstrate this capability, the _ConversionServiceTest_ is provided below. It showcases the practical use of Spring's _ConversionService_ for a Collection-to-Collection type conversion, highlighting key components and their roles in the process. Let's delve into the details:

```java
@SpringBootTest
class ConversionServiceTest {

    @Autowired
    ConversionService conversionService;

    @Test
    void shouldConvert_ListStrings_to_Numbers() {
        List<String> stringList = List.of("1", "2", "3", "4");
        TypeDescriptor sourceType = TypeDescriptor.forObject(stringList);
        TypeDescriptor targetType = TypeDescriptor.collection(List.class, TypeDescriptor.valueOf(Integer.class));
        List<Integer> convertedNumbers = (List<Integer>) conversionService.convert(stringList, sourceType, targetType);

        assertThat(convertedNumbers).isNotNull()
                .containsExactly(1, 2, 3, 4);
    }

    @Test
    void shouldConvert_SetOfStrings_to_Numbers() {
        List<String> stringList = List.of("1", "2", "3", "4");
        TypeDescriptor sourceType = TypeDescriptor.forObject(stringList);
        TypeDescriptor targetType = TypeDescriptor.collection(Set.class, TypeDescriptor.valueOf(Integer.class));
        // A LinkedHashSet
        Set<Integer> convertedNumbers = (Set<Integer>) conversionService.convert(stringList, sourceType, targetType);

        assertThat(convertedNumbers).isNotNull()
                .containsExactly(1, 2, 3, 4);
    }

}
```

<div class="link">
   <small>Also available on <a href="https://github.com/kapresoft/kapresoft-examples/blob/22de5e71bce82f2727c54467f14fe53562608dbe/conversion-service/src/test/java/com/kapresoft/articles/conversionservice/ConversionServiceTest.java" target="_blank" alt="Github">Github:ConversionServiceTest.java</a>
   </small>
</div>

In this code:

##### 1. Autowired ConversionService

_ConversionService_ is an interface in Spring Framework that defines a contract for type conversion. Here, it's autowired, meaning Spring will automatically provide an implementation at runtime on a web-based application. In a standalone Spring application, the _ConversionService_ bean is typically defined using _ConversionServiceFactoryBean_ within the application's Spring configuration. This setup initializes the default Spring Converters, integrating them seamlessly into the application context.

Example:

```java
@Configuration
public class ConversionServiceExampleConfig {

  @Bean
  ConversionServiceFactoryBean conversionService() {
      ConversionServiceFactoryBean factory = new ConversionServiceFactoryBean();
      factory.afterPropertiesSet();
      return factory;
  }

}
```

##### 2. Test Method - shouldConvert_Strings_to_Numbers()

This method is designed to test the conversion of a list of strings into a list of integers.

- **List of Strings**: It begins by defining a list of strings, _List.of("1", "2", "3", "4")_, representing the source data.

- **Type Descriptors**: Next, _TypeDescriptor_ objects are created for both source and target types. _TypeDescriptor.forObject(stringList)_ describes the source type, a list of strings, and _TypeDescriptor.collection(List.class, TypeDescriptor.valueOf(Integer.class))_ describes the target type, a list of integers.

- **Conversion**: The actual conversion is performed by the _conversionService.convert(..)_ method, which takes the source object (_stringList_), and the source and target _TypeDescriptor_'s as parameters. This method returns the converted list, cast to _List\<Integer\>_.

- **Assertion**: Finally, the test asserts (using AssertJ assertions) that the converted list is not null and contains the exact integers (1, 2, 3, 4) corresponding to the original strings.

### Role of StringToNumberConverterFactory

The <a href="https://gist.github.com/kapresoft/7c1a8157b03d413c597ab27335585555" target="_blank" alt="_StringToNumberConverterFactory_">_StringToNumberConverterFactory_</a> in Spring is an integral part of this conversion process. It provides a factory for the converters that can convert from a String to various number types like Integer, Double, Long, etc. In this context, it automatically handles the conversion of each string in the list to its corresponding integer value.

Source: <a href="https://github.com/spring-projects/spring-framework/blob/main/spring-core/src/main/java/org/springframework/core/convert/support/StringToNumberConverterFactory.java" target="_blank" alt="spring-core/../StringToNumberConverterFactory.java">spring-core/../StringToNumberConverterFactory.java</a>
<script src="https://gist.github.com/kapresoft/7c1a8157b03d413c597ab27335585555.js"></script>

### Key Takeaways

- This code demonstrates a clean, type-safe way to convert complex data structures using Spring's conversion service.
- It leverages Spring's built-in converter factory to handle common conversion scenarios, reducing the need for custom converter implementations.
- The use of _TypeDescriptor_ allows for precise control over the source and target types, enhancing the robustness of the conversion process.
- This approach is particularly useful in Spring applications where such dynamic type conversions are frequently needed, for instance, in data processing or when dealing with input from various sources.

## Writing Your Own Converters

You can extend the capability further by writing your own converter by implementing the org.springframework.core.convert.converter.Converter interface. 

In this example imagine that the code is querying an AWS S3 path that contains a collection of data files (txt, json, yaml, etc.) that will be automatically converted to _MyBusinessObject_.

```java
public class S3ObjectSummaryConverterToMyBusinessObjectConverter implements Converter<S3ObjectSummary, MyBusinessObject> {

   public MyBusinessObject convert(S3ObjectSummary source) {
       // pull down data from AWS S3
       // convert to MyBusinessObject
      return myBusinessObject;
   }
    
}
```

Here's an example usecase where you can automatically convert <a href="https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/model/S3ObjectSummary.html" target="_blank" alt="S3ObjectSummary">S3ObjectSummary</a> from AWS. This method demonstrates the automatic conversion of S3ObjectSummary objects from AWS S3 into custom MyBusinessObject instances.  The ConversionService is utilized internally to facilitate this transformation.

```java
List<MyBusinessObject> getS3BucketContents(String bucketName, String prefix) {
    // Implementation details here
}
```
### In Conclusion

Throughout this article, we have explored the versatile and powerful features of Spring's Conversion Service, particularly focusing on converting lists of strings to integers and the customization of converters for specific use cases like AWS S3ObjectSummary objects. By understanding how to implement and utilize Spring's built-in converters and how to craft your own, you can significantly streamline data processing in your applications. The practical examples provided serve as a foundation for integrating these conversion techniques into real-world scenarios, enhancing the efficiency and robustness of your Spring applications. Remember, the ability to effectively handle data conversion is a vital skill in modern software development, and Spring's Conversion Service is a robust tool in your arsenal for achieving this.
