---
title: "Java • Try With Resources Practical Example"
title_style: title2w
section_style: article1
category: java
related: java
canonical_url: https://www.kapresoft.com/java/2023/12/21/java-try-with-resources-practical-example.html
description: "Explore Java's try-with-resources with practical examples, demonstrating its efficiency in resource management and error handling."
---

## Overview

Java's introduction of the _try-with-resources_ statement revolutionized resource management, simplifying code and enhancing reliability. This feature, integral to Java's exception handling mechanism, automatically manages resources like files and sockets, ensuring they are closed properly after operations, thus preventing resource leaks. Our discussion will delve into a practical example to understand how _try-with-resources_ works and its benefits over traditional resource management techniques. 

<a id='gp5TDKEASthvPy8kX29CMQ' class='gie-single' href='http://www.gettyimages.com/detail/1439167368' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'gp5TDKEASthvPy8kX29CMQ',sig:'jws-b3SEQl5xJxaYkjU0TJ1WH4PuSl26qNEMNJD9-jQ=',w:'600px',h:'250px',items:'1439167368',caption: false ,tld:'com',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>

Furthermore, we will cover how to write your own _try-with-resources_ resource object by implementing the _AutoCloseable_ interface. This aspect is particularly crucial for developers looking to create custom resources that benefit from the automatic resource management offered by this powerful Java feature.<!--excerpt-->

## An Example Using FileReader

The evolution of Java's resource management can be vividly observed through the handling of file operations, specifically when using _FileReader_. This section will compare traditional methods with the modern, streamlined approach offered by _try-with-resources_. We'll explore how the old way of handling _FileReader_ often led to verbose and complex code, prone to errors and resource leaks. Then, we'll demonstrate how the introduction of _try-with-resources_ has transformed this process, making it more efficient, less error-prone, and significantly more readable. This comparison not only highlights the practical benefits of the newer syntax but also reflects Java's ongoing commitment to improving developer experience and code reliability.

### Without Try-With-Resources Syntax

Initially, managing resources in Java, particularly closing them, was a manual process. Developers needed to explicitly close resources in the _finally_ block, leading to verbose and error-prone code. Let's look at a typical example where resources are manually managed without _try-with-resources_.

```java
FileReader fileReader = null;
try {
    fileReader = new FileReader("app-config.yml");
    // Read and process the file
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if (Optional.ofNullable(fileReader).isPresent()) {
        try {
            fileReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### Using the Try-With-Resources Syntax

With the _try-with-resources_ statement, introduced in Java 7, the code becomes more concise and safe. The resources that implement the _AutoCloseable_ interface are automatically closed at the end of the statement, reducing the risk of resource leaks.

```java
try (FileReader fileReader = new FileReader("app-config.yml")) {
    // Read and process the file
} catch (IOException e) {
    e.printStackTrace();
}
```

## Writing your own AutoCloseable Resource

Creating custom resources in Java often involves managing their lifecycle, especially the cleanup process. This is crucial in preventing resource leaks and ensuring efficient application performance. We will explore how to handle a custom resource both before and after implementing the _AutoCloseable_ interface.

### Before AutoCloseable Implementation

Consider a custom resource, _CustomResource_, which requires explicit cleanup. Without _AutoCloseable_, you need to ensure that you manually close the resource, usually in a _finally_ block to handle exceptions properly.

**Custom Resource:**

```java
class CustomResource {
    public void open() {
        System.out.println("Resource opened.");
        // Initialization code
    }

    public void operate() {
        System.out.println("Operation performed.");
        // Operation code
    }

    public void close() {
        System.out.println("Resource closed.");
        // Cleanup code
    }
}
```

**Example Usage:**

```java
CustomResource resource = null;
try {
    resource = new CustomResource();
    resource.open();
    resource.operate();
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (resource != null) {
        resource.close();
    }
}
```

In this example, _CustomResource_ must be manually closed in the _finally_ block to ensure it is properly cleaned up, regardless of whether an exception occurs.

### After Implementing AutoCloseable

Refactoring _CustomResource_ to implement _AutoCloseable_ simplifies resource management significantly. By implementing this interface, _CustomResource_ can be used within a _try-with-resources_ statement, ensuring automatic closure.

**Refactored Custom Resource:**

```java
class CustomResource implements AutoCloseable {
    public void open() {
        System.out.println("Resource opened.");
        // Initialization code
    }

    public void operate() {
        System.out.println("Operation performed.");
        // Operation code
    }

    @Override
    public void close() {
        System.out.println("Resource closed.");
        // Cleanup code
    }
}
```

**Updated Example Usage:**

```java
try (CustomResource resource = new CustomResource()) {
    resource.open();
    resource.operate();
} catch (Exception e) {
    e.printStackTrace();
}
```

With _AutoCloseable_, _CustomResource_ is automatically closed at the end of the try block. This ensures a cleaner and safer way to handle resources, reducing the risk of resource leaks and simplifying error handling.


## In Conclusion

The _try-with-resources_ feature in Java, available since Java 7, represents a significant advancement in how resources are managed. It eliminates the need for explicit closure of resources, handling it automatically and safely. This feature checks for _null_ values, ensuring that only non-null resources are closed, and addresses the common issue of proper resource management in exception handling. The _try()_ block in Java, with this feature, ensures that resources are closed automatically, making code more robust and less prone to errors. This improvement in Java's resource management underscores the language's ongoing evolution, making it more efficient and user-friendly for developers.
