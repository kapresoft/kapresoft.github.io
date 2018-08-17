---
layout: default
title: Getting Started With Java
category: java
image: /assets/images/mvn_project_structure.png
redirect_from: 
    - /p/getting-started-with-java.html
    - /p/get-started-with-java.html
---

## Overview

The following page will illustrate how to get started with the Java Programming
Language.&nbsp;&nbsp;In addition, this document provides an overview of how to install
java and the environment variables you will need to set.&nbsp;&nbsp;A hands-on approach
illustrates how to compile and run your first Hello World java code.

<!--excerpt-->

## Table of Contents
1. Downloading and Installing a Java Development Kit (JDK)
  - Oracle Java Development Kit
  - Open Java Development Kit

2. Environment variables
3. Compiling and Running Your Java Application

{% if site.show_google_ads %}
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-5036910301295841"
     data-ad-slot="9747456101"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
{% endif %}

<hr/>

## 1.&nbsp;&nbsp;Downloading and Installing a Java Development Kit

A Java Development Kit or JDK may be downloaded from the Oracle Java Website or the Open JDK.

- <a target="_blank" href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">Oracle Java Standard Edition</a>
- <a target="_blank" href="http://openjdk.java.net/install/index.html">Open JDK Install</a>

After installing the JDK, you may verify by executing the following command in your console:

```commandline
$ java -version
   java version "1.8.0_161"
   Java(TM) SE Runtime Environment (build 1.8.0_161-b12)
   Java HotSpot(TM) 64-Bit Server VM (build 25.161-b12, mixed mode)
```

<!-- ############################################################ -->

## 2.&nbsp;&nbsp;Environment Variables

After the installation of the JDK the JAVA_HOME is a system environment variable will need to be set.

### Mac OS

To setup environment variables in Mac OS, open a console and execute the following command.
Note that in this example, 1.8 is the version of the installed JDK.

```commandline
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
```

### Linux/Unix Systems

In Linux or Unix systems the environment variable should be set to the JDK installation path as shown below.

```commandline
export JAVA_HOME=/usr/local/jdk1.8
```

Verify that the environment variable is set.

```commandline
echo $JAVA_HOME
   /Library/Java/JavaVirtualMachines/jdk1.8.0_161.jdk/Contents/Home
```

### Windows
Setup the environment variable in a windows system by following the series of steps below.

- Right-click on the My Computer or This PC. and select the <b>Properties</b> from the menu item. The Control Panel window will open up.
- From the Control Panel Window select the <b>Advanced system settings</b>. The <b>System Properties</b> dialog will appear.
- From the <b>System Properties</b> dialog click the <b>Environment Variables</b> button. The Environment Variables window will appear.
- From the <b>Environment Variables</b> window, add JAVA_HOME as a variable and the value should be the path of your java home diretory, i.e. C:\java\jdk1.8

Verify that the environment variable is set by opening a DOS Command console and execute the following.

```commandline
C:\> echo %JAVA_HOME%
   C:\java\jdk1.8
```

The second part of a JDK Windows installation is to add the JDK java to the system path.

- From the <b>Environment Variables</b> window in the previous step, search for the <b>path</b> variable in the <b>System Variables</b> section and click the Edit button.
- Add %JAVA_HOME%\bin to the beginning of the semi-colon (;) separated list of paths. In Windows 10, just add a new path entry instead with the value %JAVA_HOME%\bin.

Verify that the java is in the system path by executing the following in the DOS command console.

```commandline
C:\> java -version
   java version "1.8.0_161"
   Java(TM) SE Runtime Environment (build 1.8.0_161-b12)
   Java HotSpot(TM) 64-Bit Server VM (build 25.161-b12, mixed mode)
```

<!-- ############################################################ -->

## 3.&nbsp;&nbsp;Compiling and Running Your Java Application

The very first program we will write is the Hello World program.
This Java code will print out to the console the words "Hello World!"

Create a new file with the name HelloWorld.java with the following content:

```java
public class HelloWorld {

    public static void main(String... args) {
        System.out.println("Hello World!");
    }

}
```

Click this link to view the file <a target="_blank" href="https://gist.github.com/nfet/43754fb003232e82588ca20d50e1887e">HelloWorld.java.</a>

Compile the code:

```commandline
$ javac HelloWorld.java
```

Run the code:

```commandline
$ java HelloWorld

Output:
Hello World!
```