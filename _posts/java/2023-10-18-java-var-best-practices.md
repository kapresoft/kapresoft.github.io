---
title: "Java var Best Practices"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/18/java-var-best-practices.html
category: java
related: java
description: "Unravel the debate surrounding the 'var' keyword in Java. Understand its use, implications on type inference, and best practices. A comprehensive guide to modern Java coding."
---

## Overview

Java, with each release and update, continually evolves to simplify the developer's journey while preserving its core tenets of readability and robustness. One of the notable introductions in Java 10 was the _var_ keyword. As with most new features, it sparked debates and questions regarding its efficacy and best practices.<!--excerpt-->

## The Essence of the _var_ Keyword in Java

The _var_ keyword in Java is primarily a tool for type inference, allowing the Java compiler to infer the type of the variable from its initializer. This means that instead of explicitly declaring the type, we let the compiler decide based on the context.

For example:

```java
var name = "John Doe";  // inferred as String
var age = 25;  // inferred as int
```

At compile time, the above code translates to:

```java
String name = "John Doe";
int age = 25;
```

However, this feature is not a sign of Java becoming a dynamic language like JavaScript. It's a convenience, not a transition.

## Benefits of Using _var_

### 1. **Enhanced Readability**

Often, the argument for using the _var_ keyword centers around the readability of the code. When used judiciously, it can make the code more legible and user-friendly. Especially in scenarios where the right-hand side of the declaration clearly reveals the type, adding explicit types might be redundant.

### 2. **Simplification of Generic Types**

In modern Java coding, there are situations where generic types can get overly verbose. With _var_, you can simplify the declaration without sacrificing clarity:

```java
Map<String, List<String>> map = new HashMap<>();
```
With _var_, this becomes:
```java
var map = new HashMap<String, List<String>>();
```

### 3. **Encourages Use of Interface Instead of Implementation**

When you employ _var_, it subtly nudges developers to program for an interface rather than for a specific implementation. This adheres to one of the popular design patterns and promotes better software maintenance.

## Misconceptions and Guidelines

### **It's Not a Transition to a Dynamic Language**

Although languages like JavaScript, Scala, and TypeScript offer type inference, Java remains staunchly static. _var_ does not change this. As evident in the context provided, _var_ does not infer types at runtime but rather at compile time. Therefore, Java maintains its status as a static language, and concerns about it becoming akin to JS or ECMAScript are misplaced.

### **Where You Can't Use _var_**

While _var_ is undeniably convenient, there are cases where its usage is inappropriate or even prohibited. For instance, you cannot initialize a _var_ with _null_ because the compiler wouldn't have enough context to determine its type.

```java
// This will cause a compile-time error.
var something = null;
```

Moreover, when considering software maintenance, overuse or misuse of _var_ can lead to less understandable code, complicating debugging, code refactoring, and bug fixing.

## Best Practices

### Favor Clarity Over Brevity

If using _var_ makes the code less understandable, prefer explicit typing.

Here's an example illustrating the concept that "Clarity is Key" when using the _var_ keyword in Java:

```java
public class ClarityExample {
    public static void main(String[] args) {
        // Without var, the type is explicit
        String greeting = "Hello, Java!";

        // With var, the type is still clear
        var message = "Hello, Java!";

        System.out.println(greeting);
        System.out.println(message);
    }
}
```

In this example, we have two variables: _greeting_ and _message_, both initialized with the same string, "Hello, Java!". The first variable, _greeting_, is declared explicitly with its type (_String_). The second variable, _message_, uses the _var_ keyword.

Despite using _var_, the type of _message_ remains clear because the assignment _"Hello, Java!"_ makes it evident that _message_ is of type _String_. This demonstrates that in cases where the type is obvious from the initialization value, using _var_ can make the code more concise without sacrificing clarity.

### Keeping Java's Static Typing Intact

One significant point in favor of var is that it helps maintain Java's status as a statically typed language. In some scenarios, like when dealing with null, var is not allowed. While this may seem restrictive, it's actually a good thing. Allowing var in such cases would undermine Java's commitment to strong typing. Fortunately, this restriction is the exception rather than the rule, and in most everyday coding situations, you'll find that var can be used quite liberally.

Here's an illustrative example to support the point mentioned:

#### Example: var and Null Initialization

In dynamically typed languages, it's possible to have a variable without a specific type until runtime. However, Java's static typing prevents such ambiguity. With the introduction of _var_, this fundamental principle remains intact.

#### Incorrect Use of _var_

```java
// This will throw a compile-time error
var unknownType = null;
```

In the example above, attempting to initialize a _var_ variable with _null_ is prohibited. The Java compiler cannot infer a type solely from _null_, which would defy the concept of static typing.

#### Correct Use of _var_

```java
var personName = "John Doe";
var dateOfBirth = LocalDate.of(1990, 1, 15);
```

In these instances, the compiler can easily infer the types (_String_ and _LocalDate_, respectively) based on the assigned values, ensuring that static typing remains consistent throughout the codebase.

The bottom line is, while _var_ brings a level of flexibility and conciseness to Java, it doesn't compromise the language's core principle of being statically typed.

### Descriptive Variable Names

Descriptive variable names are essential, especially when using the _var_ keyword, as they provide context and clarity to what the variable represents. Adhering to this practice aligns with the principles of "clean code", which emphasizes that code should be easy to understand, modify, and maintain by anyone reading it, not just its original author. By choosing descriptive names, developers contribute to a codebase that's more sustainable and collaborative.

#### Non-descriptive Variable Names with _var_

```java
var a = "John Doe";
var b = LocalDate.of(1990, 1, 15);
var c = new ArrayList<String>();
```

In the above example, variable names _a_, _b_, and _c_ do not provide any context or meaning. A developer reading this code would have to spend extra effort figuring out the purpose of each variable.

#### Descriptive Variable Names with _var_

```java
var personName = "John Doe";
var dateOfBirth = LocalDate.of(1990, 1, 15);
var listOfTasks = new ArrayList<String>();
```

Here, each variable name (_personName_, _dateOfBirth_, and _listOfTasks_) explicitly describes its purpose or the kind of data it holds, making the code more readable and self-explanatory.

### Context is Key

The context in which you use var is crucial. Clear and meaningful variable names, along with well-designed code, can make all the difference. For instance, if you have a method like _.getPerson()_, using _var_ to declare a variable assigned from this method call doesn't hinder understanding; it enhances it. The reader can reasonably infer that the variable is of type _Person_.

Let's delve into a practical example to elucidate the point:

#### Example: Using _var_ with Clear Context

In a class dealing with person management, let's assume there is a method _getPerson()_ that retrieves a _Person_ object from a database or a service:

```java
public Person getPerson(int id) {
    // Logic to fetch the person from a database or service using the id
    ...
}
```

When calling this method and storing the result in a variable, using _var_ becomes quite intuitive:

```java
var retrievedPerson = getPerson(12345);
```

In this context, even though we're using _var_, it's evident that _retrievedPerson_ is of type _Person_. The method's name, _getPerson()_, provides a clear context. Thus, there's no ambiguity or loss of clarity for a developer reading the code.

However, if the method name was ambiguous like _getData(12345)_, using _var_ might not be as clear since the context wouldn't readily indicate the type of the returned data. This is why well-named methods and variables are pivotal when leveraging the _var_ keyword in Java.

### Avoid Initializing with Complex Expressions

Initializing _var_ with complex expressions can lead to reduced readability, as the inferred type might not be immediately evident.

#### Complex Initialization with _var_

```java
var result = someList.stream()
        .filter(obj -> obj.isActive())
        .mapToInt(ObjClass::getValue)
        .sum();
```

In the above example, a developer unfamiliar with the code might wonder:

1. What type is _someList_?
2. What does the filtered list contain?
3. What is the final type of _result_?

While a seasoned developer can infer that _result_ is an _int_ due to the _mapToInt_ and _sum_ methods, for someone less familiar with Java streams, this might not be immediately clear.

#### More Clear Initialization

A clearer approach would be to break down the expression:

```java
var activeObjects = someList.stream()
        .filter(obj -> obj.isActive())
        .collect(Collectors.toList());
var summedValue = activeObjects.stream()
        .mapToInt(ObjClass::getValue)
        .sum();
```

Here, the expressions are simplified, and each variable has a clear and specific purpose, making the code more understandable.

### Always Refer to the Guidelines

Adhering to the recommended coding rules and standards ensures that you use _var_ efficiently without sacrificing readability.

## In Conclusion

The introduction of the _var_ keyword is a testament to Java's adaptability and its endeavor to simplify and refine coding without compromising on its foundational principles. While it offers a streamlined approach, developers should use it judiciously, always prioritizing code clarity and maintainability. As with all tools, it's not about whether it's inherently good or evil—it's about how you use it.
