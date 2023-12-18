---
title: "Factory Design Pattern Best Practices"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/23/factory-design-pattern-best-practices.html
category: java
related: java
description: "Learn about the best practices for implementing the Factory Pattern in Java, including design principles and examples to create flexible and maintainable code."
---

## Overview

The Factory Pattern is a creational design pattern that provides an interface for creating objects in a superclass but allows subclasses to alter the type of objects that will be created. By following best practices in the implementation of the Factory Pattern, developers can achieve loose coupling, improved maintainability, and enhanced flexibility in their code.<!--excerpt-->

## Understanding the Factory Method Pattern
The Factory Method Pattern is a cornerstone of the Factory Pattern, and it involves defining an interface for creating an object, but leaving the choice of its type to the subclasses, creation being deferred at the time of instantiation. This pattern is essential for promoting abstraction and reducing dependencies between classes.

### Example of Factory Method Pattern in Java

```java
abstract class Animal {
    // Factory Method
    abstract Animal createAnimal();
}

class Dog extends Animal {
    @Override
    Animal createAnimal() {
        return new Dog();
    }
}

class Cat extends Animal {
    @Override
    Animal createAnimal() {
        return new Cat();
    }
}
```

In this example, _Animal_ is an abstract class that defines a factory method _createAnimal_. The subclasses _Dog_ and _Cat_ provide the implementation for this method, creating instances of _Dog_ and _Cat_, respectively.

## Exploring the Concrete Factory
The Concrete Factory is a key component in the Factory Pattern. It is responsible for creating and returning instances of concrete products, which are objects that implement a specific product interface. The Concrete Factory relies on concrete products to carry out the required functionalities.

### Example of Concrete Factory in Java

```java
interface Product {
    void display();
}

class ConcreteProductA implements Product {
    @Override
    public void display() {
        System.out.println("ConcreteProductA");
    }
}

class ConcreteProductB implements Product {
    @Override
    public void display() {
        System.out.println("ConcreteProductB");
    }
}

class ConcreteFactory {
    public Product createProduct(String type) {
        if (type.equalsIgnoreCase("A")) {
            return new ConcreteProductA();
        } else if (type.equalsIgnoreCase("B")) {
            return new ConcreteProductB();
        }
        return null;
    }
}
```

In this example, _Product_ is an interface that defines the method _display_. _ConcreteProductA_ and _ConcreteProductB_ are classes that implement this interface, providing their own version of the _display_ method. _ConcreteFactory_ is a class that contains a method _createProduct_, which returns instances of _ConcreteProductA_ or _ConcreteProductB_ based on the input parameter.

## Best Practices for Implementing Factory Pattern

### Use Consistent Naming Conventions

When creating factory methods or classes, it is crucial to follow a consistent naming convention that clearly indicates the purpose of the method or class.

Using consistent naming conventions is essential for readability and maintainability of code. Here's an example that illustrates the importance of this best practice:

### Inconsistent Naming Convention

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeMaker {
    public Shape getShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
}
```

In this example, the _ShapeMaker_ class could be named more consistently to indicate that it is a factory class, for instance, _ShapeFactory_.

### Consistent Naming Convention

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
}
```

In this improved example, the _ShapeMaker_ class is renamed to _ShapeFactory_ and the _getShape_ method is renamed to _createShape_ to clearly indicate that it is a factory class responsible for creating _Shape_ instances. This makes the code more understandable and maintainable.

### Apply Loose Coupling

One of the significant advantages of the Factory Pattern is that it promotes loose coupling between classes. Developers should strive to minimize dependencies between different parts of the code.

Loose coupling is a design principle aimed at reducing the inter-dependencies between different parts of a system to increase robustness and maintainability. Here is an example to illustrate the application of loose coupling in the Factory Pattern:

### Tightly Coupled Code

In the following example, the client code is tightly coupled with the concrete implementations of the _Shape_ interface.

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class Client {
    public static void main(String[] args) {
        Circle circle = new Circle();
        circle.draw();
        
        Square square = new Square();
        square.draw();
    }
}
```

Here, the _Client_ class is directly creating instances of _Circle_ and _Square_, which makes it tightly coupled with these concrete implementations.

### Loosely Coupled Code with Factory Pattern

Now, let's apply the Factory Pattern to achieve loose coupling:

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
}

class Client {
    public static void main(String[] args) {
        ShapeFactory shapeFactory = new ShapeFactory();
        
        Shape circle = shapeFactory.createShape("circle");
        circle.draw();
        
        Shape square = shapeFactory.createShape("square");
        square.draw();
    }
}
```

In this improved example, the _Client_ class is not directly dependent on the concrete implementations of _Shape_ (_Circle_ and _Square_). Instead, it relies on the _ShapeFactory_ to create instances of _Shape_. This decouples the client code from the concrete implementations, making the system more flexible and maintainable.

### Adhere to the Single Responsibility Principle

Each factory method or class should have a single responsibility, and it should not be overloaded with multiple tasks.

The Single Responsibility Principle (SRP) is one of the five SOLID principles of object-oriented design and programming. It states that a class should have only one reason to change. Here's an example to illustrate the adherence to the Single Responsibility Principle in a Factory Pattern:

### Violating Single Responsibility Principle

In the following example, the _ShapeFactory_ class has multiple responsibilities, making it overloaded with tasks.

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
    
    public void drawShape(Shape shape) {
        shape.draw();
    }
}
```

Here, the _ShapeFactory_ class is responsible for creating shapes and also drawing them. This violates the Single Responsibility Principle.

### Adhering to Single Responsibility Principle

Now, let's refactor the code to adhere to the Single Responsibility Principle:

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
}

class ShapeDrawer {
    public void drawShape(Shape shape) {
        shape.draw();
    }
}
```

In this improved example, we have separated the responsibility of drawing shapes from the _ShapeFactory_ class and created a new class _ShapeDrawer_ specifically for that purpose. Now, the _ShapeFactory_ class has a single responsibility of creating shapes, and the _ShapeDrawer_ class has a single responsibility of drawing shapes. This makes the system more maintainable and flexible.

### Leverage Abstraction

Utilize abstraction to create a clear separation between the client code and the object creation process. This enhances flexibility and allows for easier maintenance.

Leveraging abstraction in the Factory Pattern helps to create a clear separation between the client code and the object creation process, providing greater flexibility and ease of maintenance. Here's an example to illustrate this concept:

### Without Abstraction

```java
class Circle {
    void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square {
    void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    Object createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
}

class Client {
    public static void main(String[] args) {
        ShapeFactory shapeFactory = new ShapeFactory();
        
        Circle circle = (Circle) shapeFactory.createShape("circle");
        circle.draw();
        
        Square square = (Square) shapeFactory.createShape("square");
        square.draw();
    }
}
```

In this example, the _ShapeFactory_ class returns _Object_ type, and the client code needs to cast the result to the correct type. This is not ideal because it introduces potential runtime errors and reduces flexibility.

### With Abstraction

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        return null;
    }
}

class Client {
    public static void main(String[] args) {
        ShapeFactory shapeFactory = new ShapeFactory();
        
        Shape circle = shapeFactory.createShape("circle");
        circle.draw();
        
        Shape square = shapeFactory.createShape("square");
        square.draw();
    }
}
```

In this improved example, we've introduced the _Shape_ interface, and both _Circle_ and _Square_ implement this interface. The _ShapeFactory_ class now returns instances of the _Shape_ interface, eliminating the need for casting in the client code. This provides a clear separation between the client code and the object creation process, enhancing flexibility and ease of maintenance.

### Optimize for Extensibility

Design the factory pattern in a way that makes it easy to add new subclasses or concrete products in the future without significant changes to the existing code.

One of the key advantages of the Factory Pattern is its ability to facilitate extensibility. By designing the Factory Pattern in a way that minimizes the impact on existing code when adding new subclasses or concrete products, we can achieve greater flexibility and ease of maintenance. Here's an example to illustrate how to optimize for extensibility:

### Before Optimization for Extensibility

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        throw new IllegalArgumentException("Unknown shape type: " + shapeType);
    }
}
```

In this example, if we want to add a new shape, we would have to modify the _ShapeFactory_ class to include a new conditional branch for the new shape. This is not ideal as it violates the Open/Closed Principle, which states that a class should be open for extension but closed for modification.

### After Optimization for Extensibility

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

interface ShapeFactory {
    Shape createShape();
}

class CircleFactory implements ShapeFactory {
    @Override
    public Shape createShape() {
        return new Circle();
    }
}

class SquareFactory implements ShapeFactory {
    @Override
    public Shape createShape() {
        return new Square();
    }
}
```

In this improved example, we have created an _ShapeFactory_ interface with a _createShape_ method. For each shape, we have a separate factory class (_CircleFactory_ and _SquareFactory_) that implements the _ShapeFactory_ interface. **This design makes it easy to add new shapes in the future without modifying the existing code.** To add a new shape, we simply create a new factory class for the new shape and have it implement the _ShapeFactory_ interface. This achieves greater extensibility while adhering to the Open/Closed Principle.

Another example is extending the ShapeFactory, so we can leverage Spring's ability to inject a collection of beans to dynamically build our _ShapeFactory_. This provides a very flexible and extensible way to manage our shapes, as adding a new shape is as simple as adding a new bean. Here's how we can define our _ShapeFactory_ with Spring Framework:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ShapeConfig {

    @Bean
    public Shape circleShape() {
        return new Circle();
    }

    @Bean
    public Shape squareShape() {
        return new Square();
    }

    @Bean
    public ShapeFactory shapeFactory(Map<String, Shape> availableShapes) {
        return new ShapeFactory() {
            @Override
            public Shape createShape(String shapeType) {
                if (availableShapes.containsKey(shapeType)) {
                    return availableShapes.get(shapeType);
                }
                throw new IllegalArgumentException("Unknown shape type: " + shapeType);
            }
        };
    }
}
```

In this example, _circleShape_ and _squareShape_ are defined as beans that return instances of _Circle_ and _Square_, respectively. The _shapeFactory_ bean takes a _Map_ of _String_ to _Shape_ as a parameter, which Spring will automatically populate with all beans of type _Shape_, using their bean names as keys.

The _createShape_ method of _ShapeFactory_ then simply looks up the shape type in the map and returns the corresponding _Shape_ instance. This approach allows us to add new shapes in the future simply by adding new beans, without having to modify the _shapeFactory_ bean definition.

### Ensure Consistency in Object Creation

The factory pattern should provide a consistent way of creating objects, ensuring that all instances are created following the defined rules and guidelines.

Ensuring consistency in object creation is crucial to maintaining the integrity and reliability of the application. Here's an example to illustrate the importance of consistency in object creation using the Factory Pattern:

### Inconsistent Object Creation

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType, boolean fill) {
        Shape shape = null;
        if (shapeType.equalsIgnoreCase("circle")) {
            shape = new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            shape = new Square();
        }
        // Inconsistent object creation
        if (fill) {
            // Some additional steps to fill the shape
            System.out.println("Filling the shape");
        }
        return shape;
    }
}
```

In this example, the _ShapeFactory_ class has a _createShape_ method that takes an additional parameter _fill_ to determine whether the shape should be filled. However, this approach is inconsistent because the filling process is handled within the factory method, which should primarily be responsible for object creation.

### Consistent Object Creation

```java
interface Shape {
    void draw();
    void fill();
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Circle");
    }
    
    @Override
    public void fill() {
        System.out.println("Filling Circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing Square");
    }
    
    @Override
    public void fill() {
        System.out.println("Filling Square");
    }
}

class ShapeFactory {
    public Shape createShape(String shapeType) {
        if (shapeType.equalsIgnoreCase("circle")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("square")) {
            return new Square();
        }
        throw new IllegalArgumentException("Unknown shape type: " + shapeType);
    }
}
```

In this improved example, we have defined a _fill_ method in the _Shape_ interface, and each concrete shape class (_Circle_ and _Square_) implements this method. The _ShapeFactory_ class is now only responsible for creating objects, ensuring a consistent way of object creation. The decision to fill the shape or not is left to the client code, which can call the _fill_ method on the created object if needed. This approach ensures consistency in object creation and adheres to the Single Responsibility Principle.

### In Conclusion

In this comprehensive guide, we've delved deep into the intricacies of the Factory Pattern, one of the fundamental creational design patterns that plays a pivotal role in software development. By adhering to best practices such as consistent naming conventions, applying loose coupling, and optimizing for extensibility, developers can harness the full potential of the Factory Pattern to create flexible and maintainable code.

Key takeaways from this article include the importance of adhering to the Single Responsibility Principle, leveraging abstraction to create a clear separation between client code and object creation, and ensuring consistency in object creation. Each of these best practices contributes to a robust implementation of the Factory Pattern that stands the test of time and evolves with the ever-changing landscape of software development.

Furthermore, we've explored how the integration of modern frameworks like Spring can significantly enhance the Factory Pattern, providing powerful tools and features that simplify the configuration and management of factory classes. The examples provided illustrate the seamless transition from a traditional implementation of the Factory Pattern to a Spring-powered configuration that takes advantage of Java-based configuration and dependency injection.

In conclusion, the Factory Pattern is a versatile and essential tool in a developer's arsenal. By following the best practices and insights provided in this article, developers can create code that is not only functional and efficient but also clean, maintainable, and ready to adapt to future changes. The Factory Pattern, when properly implemented, lays a solid foundation for building scalable and flexible software applications that stand the test of time.
