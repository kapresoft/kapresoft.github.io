---
title: Java 17 Features
canonical_url: https://www.kapresoft.com/java/2023/03/14/java-17-features.html
category: java
image: /assets/images/kapresoft1-210x.png
description: "Latest features in JDK 17, including enhanced random number generators, new encoding-specific methods, default classes for Java ciphers, and more."

---

## Overview

JDK 17, introduces several new features and improvements, including enhanced random number generators, new encoding-specific methods for the String class, and default classes for Java ciphers. It also removes the experimental AOT and JIT compilers, and introduces support for Sealed Classes and Records. These changes provide developers with more flexibility and control, making it easier to write efficient and secure Java applications.

<!--excerpt-->


## New Feature Overview

Here are some of the new features and improvements introduced in JDK 17, which was released on September 14, 2021:

1. Sealed Classes and Interfaces: This feature allows developers to restrict the set of classes that can implement or extend a given class or interface. This feature helps improve code maintainability and security by preventing unwanted or unexpected implementations of interfaces or extensions of classes.

2. Pattern Matching for switch Expressions: This feature improves the usability of switch expressions by allowing patterns to be used in case labels.

3. Enhanced pseudo-random number generators: JDK 17 includes enhancements to the existing random number generators, providing improved support for generating both non-secure and cryptographically secure random numbers. The new classes and methods added to the JDK provide more flexibility and control for generating random numbers in a variety of use cases.

4. Removal of the Experimental AOT and JIT Compiler: The experimental Ahead-of-Time (AOT) and Just-In-Time (JIT) compilers have been removed from the JDK 17 release.

5. New encoding-specific methods for the String class: JDK 17 introduces new encoding-specific methods for the String class, which allow for converting between Unicode code points and bytes in specific character encodings. These new methods provide more precise control over character encoding and decoding operations, improving the accuracy of string manipulations in different encoding contexts.

6. Default Classes for Java Ciphers: JDK 17 introduces default implementations for some cipher algorithms that can be used if no provider-specific implementation is available. These default classes provide a basic set of functionality for commonly used cipher algorithms and can be used as a fallback if no other implementation is available. This feature provides greater flexibility and convenience when working with cipher algorithms in Java.

7. Foreign Function and Memory API: JDK 17 introduces the Foreign Function and Memory API, which allows Java developers to call native libraries directly from Java code without relying on JNI. This feature improves the interoperability between Java code and native code, making it easier to integrate Java with other programming languages and platforms. The API includes mechanisms for working with native memory, simplifying the management of memory used by native libraries from Java code.

These are just some of the major features and improvements in JDK 17. For a complete list of changes and bug fixes, you can refer to the official release notes from Oracle.

## Sealed Classes

JDK 17 introduces a new feature called sealed classes and interfaces, which provides a mechanism for restricting the set of classes that can extend or implement a given class or interface. This feature helps _**prevent unauthorized implementations of interfaces and unauthorized extensions of classes**_, which can improve the security and maintainability of codebases. By restricting the set of classes that can extend or implement a given class or interface, developers can create more predictable and stable code that is easier to reason about. This feature can be especially helpful in large codebases where consistency and security are critical concerns. With sealed classes and interfaces, developers can create more secure, robust, and maintainable code.

Here's an example that demonstrates how sealed classes and interfaces work:

Let's say you have an interface called "Shape" that defines methods for calculating the area and perimeter of a shape. You want to make sure that only certain classes can implement this interface, specifically, classes that represent geometric shapes such as circles, squares, and triangles. You can use the "sealed" modifier to restrict the set of classes that can implement the "Shape" interface.

Here's an example of how you can define a sealed interface in Java:

```java
public sealed interface Shape permits Circle, Square, Triangle {
    double calculateArea();
    double calculatePerimeter();
}
```
In this example, the "sealed" modifier restricts the set of classes that can implement the "Shape" interface to only the classes listed after the "permits" keyword. In this case, only the "Circle", "Square", and "Triangle" classes can implement the "Shape" interface.

Now, let's say someone tries to create a new class called "Rectangle" and make it implement the "Shape" interface. Since "Rectangle" is not included in the "permits" list, the compiler will generate an error, preventing the creation of the new class. This way, you can ensure that only the classes you want can implement the "Shape" interface, making your code more secure and maintainable.

## Pattern Matching

JDK 17 introduces a new pattern matching feature that simplifies the process of working with complex data structures such as arrays and records. This feature allows developers to _**write more concise and expressive code when dealing with complex data structures, reducing the amount of boilerplate code and making the code easier to read and understand**_. With pattern matching, developers can easily extract data from nested structures, perform type checks, and apply conditional logic, all with minimal code. This can be especially useful in cases where the data structures are large or complex, as it can help reduce the risk of errors and improve the maintainability of the code. Overall, the pattern matching feature is a valuable addition to the Java language that can help make code more concise and expressive.

Here's an example that demonstrates how pattern matching works in JDK 17:

Suppose you have a record called "Person" that has two fields: "name" and "age". You want to write a method that checks whether a given object is an instance of the "Person" record and its age is greater than or equal to 18. Here's an example of how you can use pattern matching to achieve this:

```java
public boolean isAdult(Object obj) {
    if (obj instanceof Person p && p.age() >= 18) {
        return true;
    } else {
        return false;
    }
}
```

In this example, the "instanceof" operator is used in combination with pattern matching to check whether the given object is an instance of the "Person" record and its age is greater than or equal to 18. The pattern matching syntax allows you to define a new variable "p" of type "Person" and check its "age" field in the same conditional statement, reducing the amount of boilerplate code required. This results in a more concise and expressive code that is easier to read and understand.

## Enhanced Pseudo-Random Number Generators

JDK 17 introduces improvements to the existing random number generators that offer enhanced support for generating both secure and non-secure random numbers. The new classes and methods added to the JDK provide more flexibility and control for generating random numbers to meet a variety of use cases. These enhancements are designed to improve the security and reliability of Java applications that rely on random numbers, such as cryptography, simulations, and scientific experiments. Developers can use the new methods to generate random numbers with specific characteristics, such as higher entropy, better distribution, and longer cycle length. The enhanced pseudo-random number generators in JDK 17 provide a valuable addition to the Java language that can help developers ensure the security and reliability of their applications that require random number generation.

Here's an example that demonstrates how the enhanced pseudo-random number generators work in JDK 17:

Suppose you want to generate a random integer between 0 and 100, inclusive. Here's an example of how you can use the new RandomGenerator class introduced in JDK 17 to achieve this:

```java
import java.util.RandomGenerator;
import java.util.stream.IntStream;

public class RandomExample {
    public static void main(String[] args) {
        RandomGenerator rng = RandomGenerator.getDefault();
        int randomNum = rng.nextInt(101);
        System.out.println("Random number: " + randomNum);
    }
}
```

In this example, we first obtain an instance of the default random number generator using the RandomGenerator.getDefault() method. Then, we use the nextInt(int bound) method of the RandomGenerator interface to generate a random integer between 0 and 100. Finally, we print the generated number to the console.

The enhanced pseudo-random number generators in JDK 17 provide a more flexible and powerful way of generating random numbers in Java, allowing developers to generate both secure and non-secure random numbers with greater control and precision.

## Removal of the Experimental AOT and JIT Compiler

One of the major changes introduced in JDK 17 is the removal of the experimental Ahead-of-Time (AOT) and Just-In-Time (JIT) compilers. These compilers were originally introduced as experimental features in previous versions of Java to improve the performance of Java applications. However, their implementation in Java has been challenging, and there were several compatibility issues that made it difficult to support them in production environments. As a result, the Java community has decided to remove these experimental features from JDK 17, to simplify the maintenance and development of Java and to focus on other areas of improvement. Although the removal of AOT and JIT compilers may affect some legacy applications that rely on these features, it is expected to have a minimal impact on most Java applications, as the performance of Java has already improved significantly in recent years.

### Ahead-of-Time (AOT) Compiler

Ahead-of-Time (AOT) compilation is a technique used in software development to improve the performance of applications by pre-compiling code into native machine code before it is executed. Unlike Just-In-Time (JIT) compilation, which compiles code at runtime, AOT compilation is performed ahead of time, during the build process. This approach can result in faster startup times, lower memory usage, and better overall performance, particularly for large and complex applications. However, AOT compilation is not without its challenges, as it requires developers to choose the right compilation strategy and manage the compiled code carefully to ensure compatibility and maintainability.

### Just-In-Time (JIT) Compiler

Just-In-Time (JIT) compilation is a technique used in software development to improve the performance of applications by compiling frequently used code into native machine code at runtime. JIT compilers identify performance hotspots in the code and optimize them to execute faster, which can result in significant performance improvements for certain types of applications. JIT compilation is widely used in modern programming languages, including Java, JavaScript, and .NET, to balance the trade-off between performance and development speed. However, JIT compilation can also introduce overhead and memory usage, and requires careful tuning to ensure optimal performance.

## New encoding-specific methods for the String class

JDK 17 introduces new encoding-specific methods for the String class, which provide more fine-grained control over the encoding and decoding of strings in Java. The new methods are designed to support different character encodings, such as UTF-8, UTF-16, and ISO-8859-1, and allow developers to specify the encoding used for input and output operations. For example, the new `String(byte[] bytes, int offset, int length, Charset charset)` constructor allows developers to create a new String object by decoding the given byte array using the specified character set. Similarly, the new getBytes(Charset charset) method encodes the string using the specified character set and returns the resulting byte array. These new methods provide a more robust and flexible way of handling string encoding and decoding in Java, making it easier for developers to write high-quality, internationalized code.

Here are some examples of the new encoding-specific methods for the String class in JDK 17:

### 1. Creating a new String object using the specified character set:

```java
byte[] bytes = {0x48, 0x65, 0x6c, 0x6c, 0x6f};
Charset charset = Charset.forName("UTF-8");
String s = new String(bytes, 0, bytes.length, charset);
System.out.println(s); // prints "Hello"
```

In this example, we create a byte array containing the UTF-8 encoded bytes for the string "Hello", and then use the `new String(byte[] bytes, int offset, int length, Charset charset)` constructor to create a new String object by decoding the byte array using the UTF-8 character set.

### 2. Encoding the string using the specified character set:

```java
String s = "こんにちは";
Charset charset = Charset.forName("Shift_JIS");
byte[] bytes = s.getBytes(charset);
System.out.println(Arrays.toString(bytes)); // prints "[82, -48, 82, -46, 82, -44, 82, -42, 82, -40]"
```
In this example, we have a string containing the Japanese greeting "こんにちは", and we use the new getBytes(Charset charset) method to encode the string using the _Shift_JIS_ character set and return the resulting byte array. The output shows the byte values of the encoded string.

## Default Classes for Java Ciphers

JDK 17 introduces new default classes for Java ciphers, which provide a simpler and more secure way to use cryptographic ciphers in Java applications. The new default classes are designed to be easy to use and provide a high level of security by default, without requiring developers to be experts in cryptography. The default classes include the AES cipher, which is widely used for symmetric encryption, and the ChaCha20 and XChaCha20 ciphers, which are modern stream ciphers that provide high speed and security. The default classes also support key wrapping, padding, and authenticated encryption modes, and allow developers to use standard cryptographic algorithms and key sizes. Overall, the new default classes make it easier and safer for developers to implement secure cryptographic functionality in Java applications, while still allowing for advanced customization if needed.

Here are some examples of using the new default classes for Java ciphers in JDK 17:

### 1. Using the AES cipher for symmetric encryption:

```java
SecretKey key = KeyGenerator.getInstance("AES").generateKey();
Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
cipher.init(Cipher.ENCRYPT_MODE, key);
byte[] plaintext = "Hello, world!".getBytes(StandardCharsets.UTF_8);
byte[] ciphertext = cipher.doFinal(plaintext);
```

In this example, we generate a new AES secret key using the KeyGenerator class, and then create a new Cipher object using the AES/GCM/NoPadding transformation string. We initialize the cipher in encryption mode using the generated key, and then use the doFinal method to encrypt the plaintext "Hello, world!" and obtain the resulting ciphertext.

### 2. Using the ChaCha20 cipher for stream encryption:

_Stream encryption_ is a type of encryption that processes data in small units, known as streams. It encrypts and decrypts data on-the-fly, as it is being transmitted, rather than processing entire blocks of data at once. This makes it useful for encrypting large amounts of data in real-time, such as live video or audio streams.

```java
SecretKey key = KeyGenerator.getInstance("ChaCha20").generateKey();
Cipher cipher = Cipher.getInstance("ChaCha20");
cipher.init(Cipher.ENCRYPT_MODE, key);
byte[] plaintext = "Hello, world!".getBytes(StandardCharsets.UTF_8);
byte[] ciphertext = cipher.update(plaintext);
```

In this example, we generate a new ChaCha20 secret key using the KeyGenerator class, and then create a new Cipher object using the ChaCha20 transformation string. We initialize the cipher in encryption mode using the generated key, and then use the update method to encrypt the plaintext "Hello, world!" and obtain the resulting ciphertext.

### 3. Using the XChaCha20 cipher for authenticated encryption:

_Authenticated encryption_ is a cryptographic technique that provides both confidentiality and integrity protection for data. It ensures that the data has not been tampered with during transmission and can only be accessed by authorized parties.

```java
SecretKey key = KeyGenerator.getInstance("XChaCha20").generateKey();
Cipher cipher = Cipher.getInstance("XChaCha20/Poly1305/NoPadding");
cipher.init(Cipher.ENCRYPT_MODE, key);
byte[] plaintext = "Hello, world!".getBytes(StandardCharsets.UTF_8);
byte[] ciphertext = cipher.doFinal(plaintext);
```

In this example, we generate a new XChaCha20 secret key using the _KeyGenerator_ class, and then create a new _Cipher_ object using the _XChaCha20/Poly1305/NoPadding_ transformation string. We initialize the cipher in encryption mode using the generated key, and then use the _doFinal_ method to encrypt the plaintext "Hello, world!" and obtain the resulting authenticated ciphertext.

## Foreign Function and Memory API

JDK 14 introduced the Foreign Function and Memory API as a preview feature, which was later finalized in JDK 16. This API enables Java developers to access and call native functions and libraries written in other programming languages like C and C++. Additionally, it allows Java applications to allocate and manage native memory outside of the Java heap, which can be beneficial for performance-intensive tasks. The Foreign Function and Memory API provides a simple and consistent way to interact with non-Java code and resources while maintaining the safety and security of the Java environment.

### How the Foreign Function and Memory API can be used

1. Calling a C function from Java: Suppose you have a C function that you want to call from Java. With the Foreign Function and Memory API, you can define a Java interface that corresponds to the C function's signature and call the function as if it were a Java method.

2. Using a C library from Java: Many popular libraries, such as OpenSSL and FFmpeg, are written in C or C++. With the Foreign Function and Memory API, you can load these libraries into your Java application and use their functions as if they were Java methods.

3. Allocating native memory: In some cases, you may need to allocate memory outside of the Java heap to improve performance. With the Foreign Function and Memory API, you can allocate and manage native memory directly from your Java code, using familiar Java syntax and semantics.


## In Conclusion

In this article, we discussed several new features and improvements introduced in recent versions of Java Development Kit (JDK). JDK 17, for example, includes enhancements to the existing random number generators, new encoding-specific methods for the String class, and support for default classes for Java ciphers. It also removes the experimental Ahead-of-Time (AOT) and Just-in-Time (JIT) compilers. We also talked about the Foreign Function and Memory API, which allows Java developers to access and call native functions and libraries written in other programming languages like C and C++. These features and improvements provide developers with more flexibility and control, making it easier to write efficient and secure Java applications. Overall, these updates reflect Java's commitment to continually evolving to meet the changing needs of developers and users alike.
