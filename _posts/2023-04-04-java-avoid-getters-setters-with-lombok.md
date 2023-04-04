---
title: "Java • Avoid Getters & Setters Methods With Lombok"
title_style: title3
canonical_url: https://www.kapresoft.com/java/2023/04/04/java-avoid-getters-setters-with-lombok.html
category: java
image: /assets/images/kapresoft1-210x.png
description: "Avoid Eliminate and reduce repetitive java boilerplate methods with Lombok's @Getter and @Setter annotations."
---

## Overview

This article provides an overview of how to avoid the repetitive code associated with writing getter and setter methods in Java classes using Lombok. By using Lombok's annotations, such as @Getter and @Setter, developers can generate these methods automatically, thereby reducing the amount of boilerplate code required in their classes.<!--excerpt--> The article highlights the benefits of using Lombok to simplify code and improve readability, and provides a step-by-step guide on how to integrate Lombok into a Java project. Overall, the article presents a useful tool for developers looking to streamline their code and improve their productivity.

## What issue are we trying to solve?

The use of getters and setters to encapsulate the data and methods of an object is a fundamental design pattern in object-oriented programming.

The use of getters and setters in object-oriented programming is a common implementation of the encapsulation principle, which is a fundamental design pattern in object-oriented programming. _Encapsulation_ is often implemented using the _Accessor_ and _Mutator_ design pattern, where getters and setters are used to control access to an object's properties.

The use of _Accessor_ and _Mutator_ design pattern has several advantages. It promotes good design practices such as information hiding, abstraction, and decoupling of implementation details from the user of the class. It also enables the implementation of the principle of least privilege, which restricts access to sensitive data or operations to only authorized code, and helps maintain the integrity of an object's internal state.

### Getters and Setters Are Long and Repetitive

Getters and setters can be an effective tool for encapsulating an object's internal state and controlling access to it, as long as they are used judiciously and with good design principles in mind. However, overuse of getters and setters can make the code more verbose and less readable. For example, if a class has many properties that require getters and setters, the class definition can become long and repetitive, which can make it harder to understand and modify the code.

An example in Java of a simple data access object (DAO) class that uses getters and setters to encapsulate the data of a user:

**Code Example #1.**  UserDao with Getters and Setters

```java
public class UserDAO {
    private String username;
    private String password;
    
    // Getters
    public String getUsername() {
        return username;
    }
    public String getPassword() {
        return password;
    }
    
    // Setters
    public void setUsername(String username) {
        this.username = username;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}
```

In this example, the _UserDAO_ class has two private instance variables username and password. The class provides public getter and setter methods for these variables to control access to them.

The getter methods _getUsername()_ and _getPassword()_ return the values of the username and password variables, respectively. The setter methods _setUsername(String username)_ and _setPassword(String password)_ set the values of the username and password variables, respectively.

Using these getter and setter methods, other classes can access and modify the username and password variables of a _UserDAO_ object, while the _UserDAO_ class can maintain control over how these variables are accessed and modified, ensuring that its internal state is consistent and valid.

The example code only has two properties, but envision a Data Access Object with 10+ properties or more, and you'll see the growing pains. The long and repetitive series of getter and setter methods can make your code hard to read and maintain.

## Eliminating Repetitive Code with Lombok

Lombok can solve the issue of verbose and repetitive (boiler plate) code in Java classes by generating getters and setters automatically through its annotations. Instead of manually defining getter and setter methods for each class property, developers can simply annotate the class with @Getter and/or @Setter, and Lombok will generate the necessary methods at compile-time.

### What is Project Lombok?

[Project Lombok](https://projectlombok.org) is a Java library that provides annotations to automate common tasks performed in Java code, such as generating getters and setters, constructors, toString() and equals() methods, and more. It eliminates boilerplate code and simplifies the development process by generating code at compile-time instead of writing it by hand.

With Lombok, The UserDao can then be represented in Code as

As you can see, the getters and setters for the username and password properties are manually defined in **Code Example #1**. The approach in that example can become repetitive and tedious when working with larger classes or when many properties need to be accessed or modified.

By using Lombok's annotations, we can eliminate this repetitive code and make our classes more concise and readable as shown in the example below.

**Code Example #2.**  UserDao using Lombok

```java
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDao {
    private String username;
    private String password;
}
```

### Did we really eliminate the repetitive getter and setter methods?

While Lombok's annotations can help eliminate the repetitive code of getter and setter methods visually, the underlying code still exists, but is generated at compile time by Lombok. The generated code is hidden from the developer's perspective, but it is still present in the compiled bytecode of the program.

### What is an Annotation Processor in Java?

Lombok uses an annotation processor to generate code automatically at compile-time. When you annotate your Java classes with Lombok annotations, such as @Getter, @Setter, @NoArgsConstructor, etc., the Lombok annotation processor generates the corresponding methods or constructors based on the properties of the annotated class.

During the compilation process, the Java compiler sends the Lombok annotations to the Lombok annotation processor, which analyzes them and generates the necessary code for the annotated classes. The generated code is then compiled along with the original source code to produce the final bytecode.

Lombok's annotation processing mechanism helps to reduce the amount of boilerplate code in Java classes, making them more concise and easier to read.

### Enhanced Developer Experience

A user can use tools like Maven or an ide like [IntelliJ](https://www.jetbrains.com/idea/) or [Visual Studio Code](https://code.visualstudio.com/) with the use of plug-ins to _de-Lombok_ a piece of code.  Doing so will render a code similar to **Code Example #1**.

### What if I'm using an IDE? Will the Getters and Setters Show Up?

Plainly without using an Integrated Development Environment (IDE) or Editor plugins, the development environment of choice will not be able to recognize Lombok's Java Annotations by default.  This experience can be enhanced by installing a Lombok plugin.

## In Conclusion

We've discussed the concept of getters and setters in object-oriented programming, their benefits and drawbacks, and how Lombok can help simplify the code associated with them. While getters and setters can provide an effective means of controlling access to an object's internal state, they can also make the code more verbose and harder to read. 

Lombok's annotations provide an efficient way to generate these methods automatically, thereby reducing the amount of repetitive code and making Java classes more concise and readable. By adopting Lombok in their Java projects, developers can streamline their code, improve their productivity, and focus on the core business logic of their applications.
