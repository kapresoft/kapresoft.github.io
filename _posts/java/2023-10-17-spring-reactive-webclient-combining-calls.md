---
title: "Spring Reactive • Best Practice for Combining Calls with WebClient"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/17/spring-reactive-webclient-combining-calls.html
category: java
related: spring
description: "Combining Reactive Calls with Spring WebClient"
---

## Overview

Modern applications require a high level of responsiveness and resilience, and the reactive programming paradigm fits the bill. In the Spring ecosystem, _WebClient_ is a non-blocking, reactive web client used to make asynchronous calls.<!--excerpt-->

In this article, we'll walk you through hjow to use _WebClient_ to fetch product information from a _ProductService_ and fetch category information from a _CategoryService_.

## Use Case

There are times that the source of the data that an application needs to retrieve is in several sources. Imagine an e-commerce platform where product details are stored in one microservice, while the associated categories reside in another. For an end user, the ideal experience would be a seamless integration where they view the product alongside its categories. 

The asynchronous nature of Spring's _WebClient_ caters perfectly to this scenario. Instead of waiting for one service to respond before calling the next, _WebClient_ can initiate both calls almost concurrently. The results are then merged and presented to the user in a fraction of the time it might take with a more traditional blocking approach. This not only provides a more efficient and responsive user experience but also ensures that the system scales effectively under high loads, making the most of available resources and catering to the demands of modern web applications.

## Setting up a Project with Reactive Web

For demonstration purposes, a developer can bootstrap a new Spring Boot project via [Spring Initializr](https://start.spring.io/). It's essential that they include "Reactive Web" as a dependency.  Exploring the example on the starter web app, will render the following dependencies for a maven example:

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-webflux</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>io.projectreactor</groupId>
        <artifactId>reactor-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```


## Configuring WebClient Bean

First, you need to configure the _WebClient_ bean in your main application or configuration class.

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {

    @Bean
    public WebClient.Builder webClientBuilder() {
        return WebClient.builder();
    }
}
```

## Making Reactive Calls

### Fetching Product Information

We'll begin by creating a service that fetches product information using _WebClient_.

```java
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class ProductService {

    private final WebClient webClient;

    public ProductService(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl("https://productservice.example.com").build();
    }

    public Mono<Product> getProductById(String id) {
        return webClient.get()
                        .uri("/products/{id}", id)
                        .retrieve()
                        .bodyToMono(Product.class);
    }
}
```

Here, _Product_ is a data class containing product details, which you'll need to define based on the response structure of the ProductService.

### Fetching Category Information

Similarly, create another service to fetch category information.

```java
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Flux;

@Service
public class CategoryService {

    private final WebClient webClient;

    public CategoryService(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl("https://categoryservice.example.com").build();
    }

    public Flux<Category> getCategoriesByProductId(String productId) {
        return webClient.get()
                        .uri("/categories/product/{id}", productId)
                        .retrieve()
                        .bodyToFlux(Category.class);
    }
}
```

Here, _Category_ is another data class representing the category details.

## Combining the Calls: Product & Category Information

Often, you may need to combine data from multiple services from different sources. Let's assume you want to get a product and its categories together.

```java
@Service
public class CombinedService {

    private final ProductService productService;
    private final CategoryService categoryService;

    public CombinedService(ProductService productService, CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    public Mono<ProductDetails> getProductDetails(String productId) {
        Mono<Product> productMono = productService.getProductById(productId);
        Flux<Category> categoryFlux = categoryService.getCategoriesByProductId(productId);

        return productMono.zipWith(categoryFlux.collectList(),
                                   (product, categories) -> new ProductDetails(product, categories));
    }
}
```

Here, _ProductDetails_ is a data class that combines _Product_ and a list of _Category_.

If the services do not use the _Mono\<T\>_ or _Flux\<T\>_ return type interfaces then another way to write the above service using a _Mono.zip(..)_ method instead of _Mono.zipWidth(..)_. Here's the example:

```java
@Service
public class CombinedService {

    private final ProductService productService;
    private final CategoryService categoryService;

    public CombinedService(ProductService productService, CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    public Mono<ProductDetails> getProductWithPrimaryCategory(String productId) {
        return Mono.zip(
                productService.getProductById(productId),
                categoryService.getPrimaryCategoryForProduct(productId)
            )
            .map(tuple -> {
                Product product = tuple.getT1();
                Category primaryCategory = tuple.getT2();
                return new ProductDetails(product, primaryCategory);
            });
    }
}

```
Here, ProductDetails could be a simple DTO (Data Transfer Object) combining both Product and its Category. The Mono.zip method takes multiple Mono instances and produces a new Mono that emits a tuple of results when all of the provided Mono instances have completed. In this case, it's a tuple of Product and Category.

The developer can then transform this tuple into the desired combined object (in our case, ProductDetails) by mapping over the resulting Mono.

## Conclusion

With Spring's _WebClient_, making reactive web calls becomes a breeze. You can efficiently fetch, combine, and process data from multiple services in a non-blocking manner, resulting in highly responsive applications.

Remember to handle exceptions and timeouts when working with WebClient in production to ensure resilience.

## References

[1] Spring Documentation Team, "Spring Framework WebClient," Spring, 2022. [Online]. Available: [https://docs.spring.io/spring-framework/reference/web/webflux-webclient.html](https://docs.spring.io/spring-framework/reference/web/webflux-webclient.html)
