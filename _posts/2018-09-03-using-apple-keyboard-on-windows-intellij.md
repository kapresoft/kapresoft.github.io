---
layout: kapresoft
title: Using the Apple Keyboard in Windows IntelliJ IDEA or Android Studio
canonical_url: https://www.kapresoft.com/java/2018/09/03/using-apple-keyboard-on-windows-intellij.html
image: /assets/images/kapresoft1-210x.png
category: java
---

# Overview

I was once with an agile company that had pairing stations throughout the work area. Some pairing stations were 
Windows-based and some where Mac-based.  The one particular thing that I did not appreciate was that the key bindings in
IntelliJ IDEA or Android Studio were different whether you were working on a Mac or on a Windows.

<!--excerpt-->

If you are a type of software developer or a cross operating system user where keyboard consistency (the physical key distance, 
locations, feel, and keybindings) is very important, this documentation will be very helpful for you.

Whether you choose to use a mac keyboard or a windows keyboard as your primary keyboard, the goal of this technical 
documentation is to make your keyboard consistent and operating system independent.

This article will demonstrate the usage of a mac keyboard on windows for IntelliJ IDEA or Android Studio by adding 
mac key bindings using AutoHotKey. 

# Table of Contents

1. Prerequisite
2. AutoHotKey Symbols
3. IntelliJ IDEA or Android Studio
4. Alternative
5. AutoHotKey Source File

# Prerequisite

- [AutoHotkey by Chris Mallet](https://autohotkey.com/) installed in Windows&trade;
- Knowledge on how to run or compile a script
- Knowledge on how to run a compiled/executable ahk during startup
- IntelliJ IDEA or Android Studio Installed on Windows

# AutoHotKey Symbols

- See <a target="_blank" href="https://autohotkey.com/docs/Tutorial.htm#s21">AutoHotKey - a. Keys and their mysterious symbols</a> for more details.

| Symbol | Description |
| ------ | :---------- |
| # | Win Key (Windows Logo Key or Command Key in Apple Keyboards) |
| ! | Alt Key |
| ^ | Control Key |
| + | Shift Key |
| & | An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey. |

# IntelliJ IDEA or Android Studio

## Common Keyboard Shortcuts

### Find Action

```
; Find Action (⌘+Shift+A) -> (Ctrl+Shift+A)
#+a::
{
    Send ^+a
    Return
}
```

<!-- ########################################## -->

## Editing

### Duplicate Line

```
; Duplicate Line (⌘+D) -> (Ctrl+D)
#d::
{
    Send ^d
    Return
}
```

### Delete Line

```
; Delete Line (⌘+Backspace) -> (Ctrl+Y)
#backspace::
{
    Send ^y
    Return
}
```

### Quick Documentation

```
; Quick Documentation (F1) -> (Ctrl+Q)
F1::
{
    Send ^q
    Return
}
```

### Find

```
; Find (⌘+F) -> (Ctrl+F)
#f::
{
    Send ^f
    Return
}    
```

### Find in Path

```
; Find in Path (⌘+Shift-F) -> (Ctrl+Shift+F)
#+f::
{
    Send ^+f
    Return
}
```

### Replace

```
; Replace (⌘+R) -> (Ctrl+R)
#r::
{
    Send ^r
    Return
}
```

### Replace in Path

```
; Replace in Path (⌘+Shift+R) -> (Ctrl+Shift+R)
#+r::
{
    Send ^+r
    Return
}
```

### Move Statement Up

```
; Move Statement Up (⌘+Shift+Up) -> (Ctrl+Shift+Up)
#+up::
{
    Send !+{Up}
    Return
}
```

### Move Statement Down

```
; Move Statement Down (⌘+Shift+Down) -> (Ctrl+Shift+Down)
#+down::
{
    Send !+{Down}
    Return
}
```

### Extend Selection

```
; Extend Selection (⌘+Up) -> (Ctrl+W)
!up::
{
    Send ^w
    Return
}
```

### Shrink Selection

```
; Shrink Selection (⌘+Down) -> (Ctrl-Shift+W)
!down::
{
    Send ^+w
    Return
}
```

### New (Context-Sensitive)

```
; New (⌘+N) -> (Alt+Insert)
#n::
{
    Send !{Insert}
    Return
}
```

### Complete Current Statement

```
; Complete Current Statement (⌘+Shift+Enter) -> (Ctrl+Shift+Enter)
#+enter::
{
    Send ^+{Enter}
    Return
}
```

### Toggle Case

```
; Toggle Case (⌘+Shift+U) -> (Ctrl+Shift+U)
#+u::
{
    Send ^+u
    Return
}     
```

<!-- ########################################## -->

## Navigation

### Jump to Navigation Bar
```
; Jump to Navigation Bar (⌘+Up) -> (Alt+Home)
#up::
{
    Send !{Home}
    Return
}
```

### Navigate to Declaration

```
; Navigate to Declaration (⌘+LeftClick) -> (Ctrl+LeftClick)
#LButton::
{
    KeyWait, LButton, D
    Send ^{LButton}
    Return
}

; Navigate to Declaration (⌘+B) -> (Ctrl+B)
#b::
{
    Send ^b
    Return
}
```

### Navigate to next word block

In Windows, Alt+Left navigates to the next tab.  We want to remap this to navigate to the next word block.

```
; Navigate to next text block
!Left::
{
    Send ^{Left}
    Return
}
```

### Go to Line Number

Since WindowsKey+L locks the workstation, the best way to solve this issue is to add a Shift key, i.e. (⌘+Shift+L). 

```
; Go to Line Number (⌘+Shift+L) -> (Ctrl+G)
#+L::
{
    Send ^g
    Return
}
```

### Hide All Windows

```
; Hide All Windows (⌘+Shift+F12) -> (Ctrl+Shift+F12)
#+F12::
{
    Send ^+{F12}
    Return
}
```

### Select Next Tab

```
; Select Next Tab (⌘+Shift+]) -> (Alt-Right)
#+]::
{
    Send !{Right}
    Return
}
```

### Select Previous Tab

```
; Select Previous Tab (⌘+Shift+[) -> (Alt-Left)
#+[::
{
    Send !{Left}
    Return
}
```

### Project View

```
#1::
{
    Send !1
    Return
}
```

### Favorites View

```
#2::
{
    Send !2
    Return
}
```

### Run view

```
#4::
{
    Send !4
    Return
}
```

### Debug View

```
#5::
{
    Send !5
    Return
}
```

### Log Cat (on Android Studio)

```
#6::
{
    Send !6
    Return
}
```

### Structure View

```
#7::
{
    Send !7
    Return
}
```

### Version Control View

```
#9::
{
    Send !9
    Return
}
```

<!-- ########################################## -->

## Windows and Tabs

### Close Current Tab
```
; Close Current Tab (⌘+W) -> (Ctrl+F4)
#w::
{
    Send ^{F4}
    Return
}
```

# Alternative

Use this alternative and map Windows Key to Meta key in IntelliJ IDEA or Android Studio.

- Use Ctrl+` to switch to the **Mac OS X 10.5+** Keymap
- Set a custom property in IntelliJ IDEA or Android Studio via Help->Edit Custom Properties menu

Caveats

- Windows hijacks a lot of the IntelliJ keybinding, i.e. Meta+L, Meta+W, Meta+b, Meta+Shift+{Up or Down Arrow}

The only solution I could find is to re-map the conflicting windows key shortcut and still use AutoHotKey to remap.
This solution seems silly but it's the only way to get around the windows mapping.

For Example:  Close current tab

Original Mapping:  Meta+W
Conflict:  Windows Ink Workspace
Solution: 
- Add new keymap:  Ctrl+W
- Add new AutoHotKey keymap mapping ⌘+W -> Ctrl+W

## Enable Meta key

Enable Meta Key by navigating to Help->Edit Custom Properties

```
keymap.windows.as.meta=true
```

# AutoHotKey Source File

The AutoHotKey can be downloaded here: <a target="_blank" href="https://gist.github.com/kapresoft/bee88e2e673fb0c4e4efc96238486715">mac-intellij-android-studio.ahk</a>.

<script src="https://gist.github.com/kapresoft/bee88e2e673fb0c4e4efc96238486715.js"></script>


 