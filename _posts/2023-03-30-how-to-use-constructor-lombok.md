---
title: "Lombok • How to Use Constructor"
canonical_url: https://www.kapresoft.com/java/2023/03/30/how-to-use-constructor-lombok.html
category: java
related: lombok
description: "How to use constructor with Lombok"
---

## Overview

To use the constructor with Lombok, you can annotate your class with _@AllArgsConstructor_ or _@RequiredArgsConstructor_. _@AllArgsConstructor_ generates a constructor that takes in all the fields in the class as arguments, while _@RequiredArgsConstructor_ generates a constructor that takes in only the final or _@NonNull_ fields as arguments.<!--excerpt-->

### @AllArgsConstructor

```java
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Person {
    private String name;
    private int age;
}
```

In the above example, Lombok will generate a constructor with two arguments, one for name and one for age.

#### Here is the equivalent de-Lombok (generated) code

```java
public class Person {
    private String name;
    private int age;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}
```

You can then create an instance of Person using this constructor like this:

```java
Person person = new Person("John", 30);
```
Lombok will handle the creation of the constructor for you, saving you from having to write the boilerplate code yourself.

### @RequiredArgsConstructor

The _@RequiredArgsConstructor_ is a Lombok annotation that generates a constructor with parameters for all final fields and/or fields annotated with _@NonNull_ in a class.

Here's an example:

```java
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class Car {
    @NonNull private final String make;
    @NonNull private final String model;
    private int year;
}
```

#### Here is the equivalent de-Lombok (generated) code

```java
public class Car {
    private final String make;
    private final String model;
    private int year;

    public Car(final String make, final String model) {
        if (make == null) {
            throw new NullPointerException("make");
        }
        if (model == null) {
            throw new NullPointerException("model");
        }
        this.make = make;
        this.model = model;
    }

    public String getMake() {
        return this.make;
    }

    public String getModel() {
        return this.model;
    }

    public int getYear() {
        return this.year;
    }

    public void setYear(final int year) {
        this.year = year;
    }
}
```

As you can see, the Lombok annotations @Getter, @NonNull, and @RequiredArgsConstructor have been replaced by the constructor and explicit getter and setter methods.

In the constructor, Lombok's @NonNull annotation has been replaced by explicit null checks, as well as an exception thrown when null values are passed to the constructor.

In the above example, Lombok will generate a constructor that takes in two arguments, make and model, which are both marked as final and @NonNull. The year field is not included in the constructor, as it is not marked as final or @NonNull.

You can then create an instance of Car using this constructor like this:

```java
Car car = new Car("Toyota", "Camry");
```
Lombok will handle the creation of the constructor for you, saving you from having to write the boilerplate code yourself.

Note that if all the fields in a class are marked as final or @NonNull, @RequiredArgsConstructor will generate a constructor with no arguments.

## In Conclusion

In conclusion, Lombok provides convenient annotations such as @AllArgsConstructor and @RequiredArgsConstructor that generate constructors for your classes. With @AllArgsConstructor, you can quickly create a constructor that takes in all the fields in the class as arguments, while @RequiredArgsConstructor generates a constructor that takes in only the final or @NonNull fields as arguments. Lombok handles the creation of the constructor, saving you from having to write the boilerplate code yourself. By using Lombok annotations, you can reduce the amount of code you need to write, making your code cleaner and more concise.

