---
title: "Lombok • @Value Annotation Best Practices"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/26/lombok-value-annotation-best-practices.html
category: java
related: lombok
description: "Master the best practices for utilizing Lombok's @Value annotation to enhance clean coding and testability in Java applications."
---

## Overview

When it comes to _clean coding_ and _enhanced testability_ in Java applications, _Project Lombok_ is a game-changer. Its _@Value annotation_ not only simplifies your code but also enhances its readability, maintainability, and testability.<!--excerpt--> In this article, we'll delve into the best practices for utilizing the _@Value annotation_ in your Java projects, providing detailed examples and insights to help you master this powerful feature.

<a id='jney4GYpRmJk-4I8RjyYuw' class='gie-single' href='http://www.gettyimages.com/detail/1127196619' target='_blank' style='color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;'>Embed from Getty Images</a><script>window.gie=window.gie||function(c){(gie.q=gie.q||[]).push(c)};gie(function(){gie.widgets.load({id:'jney4GYpRmJk-4I8RjyYuw',sig:'0MbUreSQAYy19_lKYKNERaD8IiZFbXu4La2RbakN8lU=',w:'550px',h:'200px',items:'1127196619',caption: true ,tld:'com',is360: false })});</script><script src='//embed-cdn.gettyimages.com/widgets.js' charset='utf-8' async></script>

## The Significance of @Value Annotation in Java Applications

The _@Value_ annotation in _Java Applications_ serves as a crucial tool in significantly reducing boilerplate code. As a class-level annotation, its primary role is to automatically transform all fields in a class to final, subsequently generating _getter methods_ for each field and promoting a clean, immutable design pattern. In addition to these functionalities, _@Value_ furnishes the class with essential _equals and hashCode methods_, as well as an _all-args constructor_, thereby establishing a strong foundation for any robust Java application.

It is pivotal to underscore the fact that _@Value_ **is strictly a class-level annotation** and is not designed to be utilized at the field level. Consequently, annotating a class with _@Value_ implies that all fields within said class are implicitly treated as final, with the corresponding _getter methods_ being automatically generated. For scenarios where mutable fields are required within a _@Value_ annotated class, developers are afforded the flexibility to selectively employ the _@Setter_ annotation on specific non-final fields. This strategic approach effectively balances the dichotomy between immutability and mutability in accordance with the application's unique requirements.

The _@Value_ annotation is integral to the Java development ecosystem as it proficiently facilitates the generation of final fields replete with _getter methods_, alongside _equals and hashCode methods_, and an indispensable _all-args constructor_.

When the _@Value_ annotation from Lombok is leveraged, it significantly champions the cause of immutability by intrinsically transforming annotated fields to final. This attribute is foundational in cementing the immutability of a class.

In the realm of Java, immutability is synonymous with the restriction placed on altering an object's state post-instantiation. This restriction is paramount for a host of practical applications, ranging from bolstering thread safety and augmenting code readability to streamlining the testing process.

Consider the following example:
```java
@Value
public class Product {
  String name;
  double price;
}
```

In this illustrative example, Lombok diligently generates all requisite _getter methods_, an _all-args constructor_, as well as _equals and hashCode methods_ for the Product class. This automation not only purifies the code but also significantly enhances its testability by mitigating the volume of code that necessitates maintenance and testing.

It's pertinent to note that the _@Value_ annotation is fundamentally a stereotype, encapsulating a suite of annotations, as illustrated below:

```java
@Getter 
@FieldDefaults(makeFinal=true, level=AccessLevel.PRIVATE) 
@AllArgsConstructor 
@ToString 
@EqualsAndHashCode
public class Product {
    String name;
    double price;
}
```

Here's the equivalent source code for the _Product_ class after running _delombok_, which removes the Lombok annotations and generates the boilerplate code that Lombok would create during compilation:

```java
public final class Product {
    private final String name;
    private final double price;

    public Product(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return this.name;
    }

    public double getPrice() {
        return this.price;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof Product)) {
            return false;
        }
        final Product other = (Product) o;
        if (!other.canEqual((Object) this)) {
            return false;
        }
        final Object this$name = this.getName();
        final Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) {
            return false;
        }
        if (Double.compare(this.getPrice(), other.getPrice()) != 0) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final long $price = Double.doubleToLongBits(this.getPrice());
        result = result * PRIME + (int) ($price >>> 32 ^ $price);
        return result;
    }

    protected boolean canEqual(Object other) {
        return other instanceof Product;
    }

    @Override
    public String toString() {
        return "Product(name=" + this.getName() + ", price=" + this.getPrice() + ")";
    }
}
```

The provided Java code is a representation of the _Product_ class after utilizing the _delombok_ tool, which effectively eradicates Lombok annotations and manifests the implicit boilerplate code Lombok generates during the compilation phase. This delombok version of _Product_ includes explicitly defined final fields _name_ and _price_, a parameterized constructor, getter methods for each field, and the necessary _equals_, _hashCode_, and _toString_ methods that collectively facilitate the object's proper functioning and interaction within Java's ecosystem.

## How to Implement @Value Annotation in Your Project

To use the _@Value annotation_ in your _Java applications_, you first need to add _Lombok_ as a dependency to your project. If you are using _Maven_, add the following to your _pom.xml_ file:

```xml
<dependencies>
  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.30</version> <!-- use the latest version -->
    <scope>provided</scope>
  </dependency>
</dependencies>
```

After adding the dependency, you can now use the _@Value annotation_ in your classes.

## Best Practices for Using @Value Annotation

Here are some best practices you should follow when using the _@Value annotation_ in your _Java applications_:

### Use @Value for Immutable Classes

The _@Value annotation_ is the perfect tool for creating immutable classes in Java, ensuring that once an object of the class is instantiated, its state remains constant and unalterable. 

One of the greatest advantages of using the _@Value annotation_ in Lombok is that it inherently treats all fields as final, eliminating the need for developers to explicitly declare them as such. This not only streamlines the coding process but also ensures that immutability is maintained, as fields cannot be modified once the object has been created. 

By leveraging the _@Value annotation_, developers can easily adhere to best practices for immutable class design in Java, resulting in cleaner, more maintainable, and robust code.

Example:
```java
@Value
public class Customer {
  String name;
  int age;
}
```

In this example, the _Customer_ class is immutable as all fields are final, and the _@Value annotation_ will generate the necessary methods.

### Avoid Using @Value with @Data

Both _@Value_ and _@Data_ are _Lombok-specific annotations_ that generate _getter and setter methods_, among other things. However, _@Data_ generates _setter methods_ that can modify the state of the object, which contradicts the purpose of _@Value_ for creating immutable objects. Therefore, avoid using _@Value_ with _@Data_.

### Test Generated Methods

Even though _@Value_ generates _getter methods_, _equals and hashCode methods_, and an _all-args constructor_, it is crucial to thoroughly test these methods to verify that they are functioning as intended.

Consider a scenario in which you have a _Cart_ class that contains a list of _Product_ objects:

```java
@Value
public class Cart {
    List<Product> products;
}
```

Each _Product_ is defined as follows:

```java
@Value
public class Product {
    String name;
    double price;
}
```

Testing the _equals_ and _hashCode_ methods is of paramount importance, especially when dealing with collections that rely on these methods, such as _HashSet_. In this example, adding a _Product_ to a _HashSet_ should not allow duplicates. This is where the _equals_ and _hashCode_ methods come into play, as they are used to determine whether two objects are the same.

Here is an example of how you can test the _equals_ and _hashCode_ methods for the _Product_ class:

```java
@Test
public void testEqualsAndHashCode() {
    Product product1 = new Product("Apple", 1.0);
    Product product2 = new Product("Apple", 1.0);
    Product product3 = new Product("Banana", 2.0);

    assertEquals(product1, product2);
    assertNotEquals(product1, product3);

    Set<Product> products = new HashSet<>();
    products.add(product1);
    products.add(product2); // Should not add to set since product1 equals product2
    products.add(product3);

    assertEquals(2, products.size()); // Should be 2 since product1 and product2 are the same
}
```

This test case verifies that the _equals_ method is working correctly by asserting that _product1_ equals _product2_ but not _product3_. Additionally, it tests the _hashCode_ method by adding the products to a _HashSet_ and asserting the correct size of the set. If the _equals_ and _hashCode_ methods are not functioning properly, the test will fail, thus highlighting any potential issues that need addressing.

### Omit Lombok Synthesized Files from Code Coverage Metrics

In scenarios where Lombok is employed, it becomes imperative to omit the files synthesized by Lombok from your code coverage metrics, given that these files do not form a part of your application's core business logic. With Maven, a configuration can be established within your code coverage plugin to specifically exclude files generated by Lombok. A pertinent example in this regard would be the integration of the JaCoCo Maven plugin, as illustrated below:

```xml
<plugins>
  <!-- other plugins -->
  <plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.10</version> <!-- use the latest version -->
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
        <exclude>**/Product.class</exclude> <!-- exclude the Lombok generated class -->
      </excludes>
    </configuration>
  </plugin>
</plugins>
```

## In Conclusion

The _@Value_ annotation in _Project Lombok_ stands as a testament to the potential for refined quality within your _Java Applications_. This feature is instrumental in propelling your code towards a paradigm of clarity and heightened testability. By diligently adhering to the best practices delineated in this comprehensive guide, you are poised to unlock the immense potential harbored by this powerful annotation. The end result is a metamorphosis of your _Java_ code, transforming it into a more efficient, intelligible, and effortlessly maintainable entity, thereby significantly amplifying the overall effectiveness and robustness of your software development endeavors.
