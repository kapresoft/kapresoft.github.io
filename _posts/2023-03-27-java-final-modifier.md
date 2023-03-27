---
title: Java Final Modifier
canonical_url: https://www.kapresoft.com/java/2023/03/27/java-final-modifier.html
category: java
image: /assets/images/kapresoft1-210x.png
description: "Learn how the final keyword modifier in Java creates immutable variables, methods, and classes, preserving their initial value and behavior."
---

## Overview

In Java, the _final_ keyword (also known as a modifier) is used to mark a variable, method, or class as immutable, meaning its value or behavior cannot be modified once it has been initialized.<!--excerpt--> The _final_ modifier can be applied to class fields, local variables, method parameters, methods, and classes.

<!--excerpt-->

## Class Fields

```java
public class MyClass {
    // final class field
    public static final int MY_CONSTANT = 42;
}
```

In this example, the MY_CONSTANT field is declared as both _static_ and _final_. This means that it is a class-level field, and its value cannot be changed once it is initialized. If a field is declared as _final_, it cannot be reassigned after it is initialized in the constructor.

## Local Variables or Method Parameters

When applied to local variables or method parameters, the _final_ modifier indicates that the variable or parameter's value cannot be changed after it has been initialized. This can help to prevent bugs and improve code readability by making it clear which variables are meant to be constant. Using the _final_ keyword on variables declared within a method or method parameters in Java can have benefits in terms of improving code clarity, readability, and maintainability.

Here are some potential benefits:

1. Clarifying intent: By marking a variable as _final_, you are explicitly indicating that the value of the variable should not change. This can help other developers who read your code understand your intent more clearly.

1. Avoiding accidental reassignment: If you accidentally try to reassign a _final_ variable within the method, you will get a compile-time error. This can help catch potential bugs and make your code more robust.

1. Improving thread safety: If a _final_ variable is used within a multithreaded application, it will be guaranteed to be read-only once it is initialized. This can help prevent race conditions and other thread-safety issues.

1. Enforcing immutability: If you are working with immutable objects, marking variables as _final_ can help enforce immutability and prevent accidental changes to the state of the object.

1. Enabling inlining: In some cases, marking a variable as _final_ can help the Java compiler optimize your code by allowing it to inline the variable's value instead of reading it from memory repeatedly.

It's worth noting that using the _final_ keyword on variables within a method should not be overused. While it can be helpful in some cases, using it excessively can make your code harder to read and understand. As with any programming construct, it's important to use _final_ judiciously and only when it provides real benefits.

### Example: Local Variable

```java
public void printMessage() {
   final String message = "Hello, World!"; // Declare a final local variable
   System.out.println(message); // Output the message
   // message = "Goodbye, World!"; // This line would result in a compilation error
}
```

In this example, the _final_ modifier is used to declare a local variable message within the printMessage method. The final modifier ensures that the value of message cannot be changed after it is initialized to the string "Hello, World!". If we tried to reassign message to a different value, such as "Goodbye, World!", we would get a compilation error. By using the _final_ modifier, we are indicating that message is a constant variable that should not be changed.
### Example: Method Parameter

```java
public void printMessage(final String message) { // Declare a final method parameter
        System.out.println(message); // Output the message
        // message = "Goodbye, World!"; // This line would result in a compilation error
        }
```
In this example, the _final_ modifier is used to declare a method parameter message for the printMessage method. Like the previous example, the _final_ modifier ensures that the value of message cannot be changed within the method. If we tried to reassign message to a different value, we would get a compilation error. By using the _final_ modifier, we are indicating that message is a constant parameter that should not be changed within the method.


## Methods

When the _final_ modifier is applied to a method in Java, it signifies that the method's implementation cannot be changed by any of its subclasses. This can be particularly useful in situations where you want to ensure that a specific method always operates in the same way, regardless of the particular subclass that is invoking it.

By preventing subclasses from altering the method's implementation, you can rely on the method's behavior to remain consistent and predictable throughout the entire inheritance hierarchy. This can be important when you're working on a large and complex project with many different classes and subclasses, as it can help reduce the risk of unexpected behavior arising from changes made to a subclass's implementation of a method.

Additionally, using the _final_ modifier in this way can help enforce good coding practices and design principles, such as encapsulation and abstraction. By preventing subclasses from changing a method's behavior, you can help ensure that your code is more modular and maintainable, and that changes made in one part of the codebase do not have unexpected consequences in other areas.

### Example

```java
public class Vehicle {
    private int speed;
    
    public final void start() {
        speed = 0;
        System.out.println("Vehicle has started.");
    }
    
    public void accelerate(int amount) {
        speed += amount;
        System.out.println("Vehicle is now traveling at " + speed + " mph.");
    }
}

public class Car extends Vehicle {
    public void start() {
        System.out.println("Car has started.");
        super.start();
    }
}

public class Main {
    public static void main(String[] args) {
        Vehicle vehicle = new Vehicle();
        vehicle.start();
        vehicle.accelerate(20);
        
        Car car = new Car();
        car.start();
        car.accelerate(20);
    }
}
```

In this example, we have a Vehicle class with a start method that is marked as _final_. This means that subclasses of Vehicle (like Car) cannot override the implementation of the start method.

When we create a Vehicle object and call its start method, we see the message "Vehicle has started." printed to the console. When we create a Car object and call its start method, we see the message "Car has started." printed to the console, followed by "Vehicle has started." This is because the start method in Car calls the start method in Vehicle using the super keyword.

If we had not marked the start method in Vehicle as _final_, the start method in Car would have overridden it and we would have seen the message "Car has started." printed twice.

By marking the start method as _final_, we ensure that it always behaves in the same way, regardless of the subclass that is calling it. This can be useful in situations where you want to enforce a particular behavior throughout your codebase.

## Classes

When applied to classes, the _final_ modifier indicates that the class cannot be subclassed. This can be useful in situations where you want to ensure that a particular class's behavior cannot be modified by other classes.

### Example

```java
public final class MyOperation {
    public static final double PI = 3.14159;
    
    public static int add(int a, int b) {
        return a + b;
    }
    
    public static int subtract(int a, int b) {
        return a - b;
    }
    
    // Other math methods...
}

public class MyAdvancedOperation extends MyOperation {
    // This will cause a compilation error because MyOperation is _final_
}
```

In this example, we have a MyOperation class that is marked as _final_. This means that other classes cannot subclass MyOperation and modify its behavior.

We've also defined a few static methods and a static constant (PI) in MyOperation. These can be used throughout our codebase without fear of them being overridden or modified by other classes.

If we try to create a subclass of MyOperation (like MyAdvancedOperation), we'll get a compilation error because MyOperation is marked as _final_. This ensures that the behavior of Operation cannot be modified by other classes, which can be useful in situations where you want to ensure the integrity of a particular class's behavior throughout your codebase.

Note that marking a class as _final_ does not prevent you from creating instances of that class. It simply prevents other classes from subclassing it.

### Similarity with Sealed Classes

The sealed keyword in Java (starting from Java 17) and _final_ keyword are similar in that they both restrict the ways in which a class can be used or modified.

However, there are some important differences:

1. _final_ classes cannot be subclassed at all, while sealed classes allow only a limited set of subclasses. When a class is marked as _final_, no other class can subclass it. When a class is marked as sealed, other classes can still subclass it, but only a predefined set of subclasses are allowed. The set of allowed subclasses is defined using the permits keyword in the sealed class declaration.

1. _final_ classes guarantee that no other class can modify their behavior, while sealed classes only guarantee that certain subclasses will behave in a particular way. When a class is marked as _final_, it cannot be subclassed or modified in any way. When a class is marked as sealed, other classes can still subclass it and potentially modify its behavior. However, the sealed keyword guarantees that only a limited set of subclasses will behave in a particular way, which can help prevent unintended modifications to the sealed class's behavior.

Here's an example to illustrate the difference:

```java
public sealed class Vehicle permits Car, Truck {
    // ...
}

public final class Car extends Vehicle {
    // ...
}

public final class Truck extends Vehicle {
    // ...
}

public final class Bike {
    // This will cause a compilation error because Bike is not in the list of permitted subclasses for Vehicle
}
```

In this example, we have a Vehicle class that is marked as sealed. This means that only a predefined set of subclasses (Car and Truck) are allowed to subclass it.

We've also defined Car and Truck classes that subclass Vehicle. These subclasses are guaranteed to behave in a particular way, as specified by the Vehicle class. However, no other classes can subclass Vehicle or modify its behavior.

If we try to create a subclass of Vehicle that is not in the list of permitted subclasses (like Bike), we'll get a compilation error because Bike is not allowed to subclass Vehicle.

Overall, the sealed keyword provides more flexibility than the _final_ keyword, while still allowing you to restrict the ways in which a class can be used or modified.

## General Benefits

Firstly, There can be benefits during runtime when using the _final_ keyword with a class field in Java. Using _final_ on class fields can make the code more maintainable and less prone to bugs, as it helps to enforce immutability and prevent accidental modification of the field's value. By guaranteeing that the field's value is not going to change, you can avoid unexpected behavior caused by unintentional modifications.

Secondly, the use of _final_ on class fields can also improve performance in certain cases. Since the value of a _final_ field is known at compile-time, the Java compiler can perform certain optimizations that it might not otherwise be able to do. For example, the compiler can inline the value of the field directly into the code, eliminating the need to access the field at runtime. This can lead to faster execution times and lower memory usage.

Finally, using _final_ on class fields can also improve code readability by making it clear that a particular variable is meant to be a constant or immutable value. This can make the code easier to understand and maintain over time.

## General Caveats

There are a few caveats to consider when using the _final_ keyword in java.

1. Initialization requirements: When using the _final_ keyword on a class field, you must ensure that the field is initialized before the object is used. This can be done either by initializing the field when it is declared, or by initializing it in the class constructor. If the field is not initialized before it is used, you will get a compilation error.

1. Immutability of the object: When you use the _final_ keyword on a class field, you are making the reference to the object immutable, but not the object itself. This means that you can still change the state of the object, but you cannot assign a new object to the reference. If the object itself needs to be immutable, you will need to use other mechanisms to ensure that the state of the object cannot be changed.

1. Performance considerations: In some cases, using the _final_ keyword on a class field can have a positive impact on performance. This is because the JVM can optimize the access to _final_ fields, since it knows that the value of the field will never change. However, in other cases, using _final_ can actually have a negative impact on performance, since it can prevent certain optimizations that the JVM would otherwise make.

1. Inheritance: When a class is extended, the _final_ keyword on a field will prevent the field from being overridden in the subclass. This can be either desirable or undesirable, depending on the situation.

1. Serialization: If a _final_ field is not marked as transient, it will be serialized along with the object. This can cause issues if the serialized object is deserialized into a different version of the class, since the field may no longer exist or may have a different value.

Overall, the _final_ keyword can be a powerful tool for ensuring immutability and thread safety in your Java code, but it must be used carefully and thoughtfully to avoid unexpected behavior or performance issues.

## The 'final' Conclusion

In this session, we discussed the _final_ keyword in Java and how it can be used to restrict the ways in which classes, methods, and variables can be used or modified.

When the _final_ modifier is applied to local variables or method parameters, it means that the value of the variable or parameter cannot be changed once it has been initialized. This can help prevent bugs and make it easier to understand which variables are supposed to be constant.

When applied to class fields, the _final_ modifier ensures that the field can only be assigned a value once, typically during object construction. This can help prevent accidental modifications to the field's value.

When applied to methods, the _final_ modifier indicates that the method's implementation cannot be overridden by subclasses. This can be useful in situations where you want to ensure that a particular method always behaves the same way, regardless of the subclass that is calling it.

When applied to classes, the _final_ modifier indicates that the class cannot be subclassed. This can be useful in situations where you want to ensure that a particular class's behavior cannot be modified by other classes.

We also discussed the new sealed keyword in Java 17, which provides more flexibility than the _final_ keyword, while still allowing you to restrict the ways in which a class can be used or modified. Sealed classes allow only a limited set of subclasses, which can help prevent unintended modifications to the sealed class's behavior.

Overall, the _final_ keyword and sealed keyword provide powerful ways to restrict the ways in which your code can be used or modified, helping you to write more reliable, maintainable code.
