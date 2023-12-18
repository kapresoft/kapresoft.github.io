---
title: "Lombok • @Data Annotation Best Practices"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/26/lombok-data-annotation-best-practices.html
category: java
related: lombok
description: "Master the art of clean Java coding using the Lombok @Data annotation for efficient software development."
---

## Overview

When it comes to clean and efficient Java coding, the power of Project Lombok cannot be overstated. Specifically, the @Data annotation provided by Lombok stands out as a valuable tool for Java developers.<!--excerpt--> In this article, we will delve into the intricacies of using the @Data annotation in Lombok, highlighting its benefits and how it can elevate your Java applications.

<a id='XdcLGoboT5VbAsnEraFiPQ' class='gie-single' href='http://www.gettyimages.com/detail/1451456915' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'XdcLGoboT5VbAsnEraFiPQ',sig:'SeRF6BXicAXqgFGJOVs5DtZ3hFQeIby8oiohLy7FrzE=',w:'550px',h:'200px',items:'1451456915',caption: true ,tld:'com',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>

## The Essence of @Data Annotation in Lombok

The @Data annotation is a part of Project Lombok, a Java library that aims to reduce boilerplate code and simplify your Java projects. When you annotate a class with @Data, Lombok automatically generates all the necessary getter and setter methods, as well as the equals, hashCode, and toString methods. This not only makes your code more readable but also significantly reduces the time spent on writing repetitive code.

## Benefits of Using @Data Annotation in Java Applications

Java applications often require extensive boilerplate code, which can be cumbersome and time-consuming. By using the @Data annotation, developers can streamline the process, resulting in cleaner and more maintainable code. Additionally, the @Data annotation ensures that your code adheres to the principles of encapsulation, as it generates private fields with public getter and setter methods.

### Cleaner Code with Less Effort

The @Data annotation eliminates the need for manually writing getter and setter methods, as well as equals and hashCode methods. This results in cleaner and more concise code, allowing developers to focus on the core functionality of their applications. Furthermore, by reducing the amount of boilerplate code, the risk of introducing errors is minimized.

### Enhancing Code Maintainability

Maintaining Java applications can be a daunting task, especially when dealing with large codebases. The @Data annotation simplifies this process by generating the necessary methods automatically. This means that any changes to the fields of a class will be automatically reflected in the generated methods, ensuring that your code remains consistent and easier to maintain.

## Integrating @Data Annotation in Your Java Project

Integrating the @Data annotation in your Java project is a straightforward process. If you are using Maven, you can add the Lombok dependency to your project's pom.xml file:

```xml
<dependencies>
  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.30</version> <!-- Use the latest version -->
    <scope>provided</scope>
  </dependency>
</dependencies>
```

Once the dependency is added, you can annotate your Java classes with @Data:

```java
import lombok.Data;

@Data
public class User {
  private String name;
  private int age;
}
```

When you use Lombok's _@Data_ annotation, the generated Java code will include:

1. Getter methods for all fields
2. Setter methods for all fields
3. An equals method that compares all fields
4. A hashCode method that uses all fields
5. A toString method that includes all fields

The resulting code would look something like this:

```java
public class User {
  private String name;
  private int age;

  public User(String name, int age) {
    this.name = name;
    this.age = age;
  }

  public String getName() {
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getAge() {
    return this.age;
  }

  public void setAge(int age) {
    this.age = age;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;

    User user = (User) o;

    if (age != user.age) return false;
    return name != null ? name.equals(user.name) : user.name == null;
  }

  @Override
  public int hashCode() {
    int result = name != null ? name.hashCode() : 0;
    result = 31 * result + age;
    return result;
  }

  @Override
  public String toString() {
    return "User{" +
           "name='" + name + '\'' +
           ", age=" + age +
           '}';
  }
}
```

With Lombok's _@Data_ annotation, you won't need to manually write out all of these methods; they will be automatically generated for you, resulting in cleaner and more maintainable code.

## Best Practices for Using @Data Annotation in Lombok

While the @Data annotation is a powerful tool, it is important to use it judiciously. Here are some best practices to keep in mind:

### Use @Data for DTOs and Entities

The @Data annotation is most suitable for data transfer objects (DTOs) and entities in Java applications.

Let's consider an example of a simple e-commerce application that has a _Product_ entity and a _ProductDTO_ data transfer object. Here's how you can use Lombok's _@Data_ annotation for both the entity and the DTO:

#### Example for Entities

Entities are classes that represent the data in your application's database. For a _Product_ entity, you can use the _@Data_ annotation to automatically generate getter and setter methods, as well as the _equals_, _hashCode_, and _toString_ methods.

```java
import lombok.Data;

@Data
@Entity
public class Product {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String name;

  private BigDecimal price;

  // other fields and business logic
}
```

By using the _@Data_ annotation, you can keep your entity class concise and focused on the business logic, without the clutter of boilerplate code.

#### Example for Data Transfer Objects (DTOs)

DTOs are objects that carry data between processes, and they are often used to send data from the server to the client in a web application. Here's an example of how you can use the _@Data_ annotation for a _ProductDTO_:

```java
import lombok.Data;

@Data
public class ProductDTO {

  private String name;

  private BigDecimal price;

  // other fields
}
```

The _@Data_ annotation automatically generates the necessary getter and setter methods, making the _ProductDTO_ class concise and easy to work with. This is particularly useful when you have multiple DTO classes in your application, as it helps to reduce the amount of boilerplate code you need to write.

### Avoid Using @Data for Classes with Business Logic

Classes that contain business logic should not be annotated with @Data, as this can lead to unintended side effects.

Here is an example that demonstrates why it is recommended to avoid using _@Data_ for classes containing business logic:

Imagine you have an _Order_ class that represents an order in an e-commerce application. This class contains some business logic to calculate the total price of the order based on the individual item prices and quantities.

```java
import lombok.Data;

@Data
public class Order {

  private List<Item> items;

  public BigDecimal getTotalPrice() {
    BigDecimal totalPrice = BigDecimal.ZERO;
    for (Item item : items) {
      totalPrice = totalPrice.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
    }
    return totalPrice;
  }
}
```

In this example, using the _@Data_ annotation will generate getter and setter methods for all fields, as well as the _equals_, _hashCode_, and _toString_ methods. However, this can lead to unintended side effects, such as:

1. **Exposing Internal State**: The generated setter for the _items_ field exposes the internal state of the _Order_ class, which could be modified by external classes.

2. **Inconsistency in Business Logic**: If the business logic in the _getTotalPrice_ method depends on the state of the _items_ field, external modifications to this field can lead to inconsistency in the calculated total price.

3. **Unnecessary Methods**: The generated _equals_, _hashCode_, and _toString_ methods may not be suitable for the specific requirements of the _Order_ class, leading to potential issues in how instances of this class are compared or represented as strings.

To avoid these issues, it is recommended to avoid using the _@Data_ annotation for classes containing business logic and instead use specific Lombok annotations such as _@Getter_ or _@Setter_ as needed, while manually implementing any required business logic methods.

### Customize as Needed

Sometimes an object may need to be customized to meet specific requirements. In such cases, Lombok provides specific annotations that allow you to tailor the generated methods according to your needs. Annotations such as _@Getter_, _@Setter_, and _@EqualsAndHashCode_ give you the flexibility to customize the behavior of the generated methods.

For instance, consider the following example of a _Customer_ class that requires custom equality based on an identity field:

```java
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Customer {

  @EqualsAndHashCode.Include
  private Long id;

  private String name;

  private String email;

  // other fields and business logic
}
```

In this example, the _Customer_ class has three fields: _id_, _name_, and _email_. However, we want the _equals_ and _hashCode_ methods to only consider the _id_ field, as it is the identity field for a _Customer_ object. To achieve this, we use the _@EqualsAndHashCode_ annotation with the _onlyExplicitlyIncluded_ attribute set to _true_. This tells Lombok to only include fields that are explicitly marked with the _@EqualsAndHashCode.Include_ annotation in the generated _equals_ and _hashCode_ methods. As a result, **only the _id_ field will be considered when comparing _Customer_ objects or calculating their hash codes, while the _name_ and _email_ fields will be ignored.**

Additionally, we use the _@Getter_ and _@Setter_ annotations to generate getter and setter methods for all fields, providing a clean and concise way to access and modify the fields of the _Customer_ class.

### Exclude Lombok Generated Files from Code Coverage
When using Lombok, it's important to exclude generated files from your code coverage metrics, as they are not part of your application's business logic. In Maven, you can configure your code coverage plugin to exclude Lombok generated files. Here's an example using the JaCoCo Maven plugin:

```xml
<plugins>
  <!-- other plugins -->
  <plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.11</version> <!-- use the latest version -->
    <executions>
      <execution>
        <goals>
          <goal>prepare-agent</goal>
        </goals>
      </execution>
      <execution>
        <id>report</id>
        <phase>prepare-package</phase>
        <goals>
          <goal>report</goal>
        </goals>
      </execution>
    </executions>
    <configuration>
      <excludes>
        <exclude>**/User.class</exclude> <!-- exclude the Lombok generated class -->
      </excludes>
    </configuration>
  </plugin>
</plugins>
```

By following these best practices, you can ensure that you are maximizing the benefits of the @Data annotation while minimizing any potential pitfalls.

## In Conclusion

In this comprehensive guide, we have explored the power and utility of the Lombok _@Data_ annotation, a versatile tool that significantly simplifies Java development by reducing boilerplate code. We have delved into the best practices for using the _@Data_ annotation in Java applications, emphasizing its suitability for DTOs and entities, and cautioning against its use in classes with business logic.

Additionally, we have highlighted the importance of customizing generated methods as per your specific needs, showcasing examples of how to leverage other Lombok annotations like _@Getter_, _@Setter_, and _@EqualsAndHashCode_ to tailor the behavior of your objects. Furthermore, we have underscored the necessity of excluding Lombok-generated files from code coverage metrics to maintain accurate and meaningful results.

In conclusion, Project Lombok, and more specifically, the _@Data_ annotation, are invaluable tools in the toolkit of any Java developer aiming for clean, efficient, and maintainable code. When employed judiciously, in accordance with the best practices and customizations discussed in this guide, Lombok can greatly enhance your productivity, allowing you to focus more on the business logic and less on the mundane, repetitive aspects of coding.
