# football_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Football Shop App
## A7-07/11/2025

### What is a widget tree and how do parent-child relationships work?

A **widget tree** is the hierarchical structure of all widgets in a Flutter app.  
Each widget is a **node** in the tree, and widgets can contain other widgets (children).  
The **parent widget** defines the layout and behavior of its **child widgets**.  
For example, a `Column` (parent) may contain multiple `Text` and `Icon` widgets (children).


### List of widgets used in this project and their functions

| Widget | Function |
|---------|-----------|
| `MaterialApp` | Root widget that defines app-wide settings such as theme and navigation. |
| `Scaffold` | Provides the basic visual layout structure (AppBar, Body, etc.). |
| `AppBar` | Displays the title bar at the top of the screen. |
| `Column` | Arranges widgets vertically. |
| `Row` | Arranges widgets horizontally. |
| `Card` | Displays information inside a material-style card with elevation. |
| `Container` | Used for layout, padding, and size control. |
| `GridView.count` | Displays buttons in a grid layout. |
| `Icon` | Shows a graphical icon. |
| `Text` | Displays text content. |
| `Material` & `InkWell` | Create clickable material-style buttons with ripple effects. |
| `SnackBar` | Shows a temporary message at the bottom of the screen. |


### What is the function of the `MaterialApp` widget?

`MaterialApp` serves as the **root widget** of a Flutter app using Material Design.  
It provides key features such as:
- App-wide **theme** and **color schemes**
- **Navigation** and routing
- Default **text direction**, **locale**, and **debug banner** control

It’s usually used as the root because it wraps your app in Material Design behavior.


### Difference between `StatelessWidget` and `StatefulWidget`

| Widget Type | Description | Example Use |
|--------------|--------------|-------------|
| `StatelessWidget` | Does not change once built (no internal state). | Static screens like info pages or buttons that don’t store data. |
| `StatefulWidget` | Can change dynamically because it maintains internal state. | Forms, counters, or lists that update in real time. |

Use **StatelessWidget** when UI does not change, and **StatefulWidget** when the widget needs to react to user input or data updates.


### What is `BuildContext` and why is it important?

`BuildContext` is an object that gives access to the location of a widget in the widget tree.  
It is used to:
- Access **theme**, **media queries**, or **ancestors** (like `ScaffoldMessenger`).
- Build widgets correctly in their hierarchical context.

Example:
```dart
ScaffoldMessenger.of(context).showSnackBar(...);
```
###  Explain the concept of a “hot reload” in Flutter and how it differs from a “hot restart”.


**Hot Reload** allows to quickly update the running app with the latest code changes without restarting it. It preserves the app’s current state (like scroll position or variable values), making it ideal for rapid UI development.

**Hot Restart**, on the other hand, completely restarts the app, rebuilding the widget tree from scratch and resetting the app state.

## A8-12/11/2025

### Explain the difference between Navigator.push() and Navigator.pushReplacement() in Flutter. In what context of your application is each best used?

`Navigator.push()` adds a new page on top of the navigation stack while keeping the previous page underneath. This allows users to go back to the previous screen using the system back button or `Navigator.pop()`.  
In my application, `Navigator.push()` is best used when navigating to the **Add Product Form**, because users should be able to return to the homepage after completing or canceling the form.

`Navigator.pushReplacement()` removes the current page from the stack and replaces it with a new one, preventing users from going back. This is more suitable for flows like login → homepage, where returning to the login page is unnecessary.  
If the Football Shop had an authentication screen, `Navigator.pushReplacement()` would be appropriate when the user logs in successfully.

### How do you use hierarchy widget like Scaffold, AppBar, dan Drawer to build a consistent page structure in the your application?
Flutter’s widget hierarchy helps ensure consistent UI design.  
`Scaffold` provides the basic layout structure for each page, including areas for the app bar, drawer, and main content.  
`AppBar` gives every page a consistent header with title and color theme, improving recognizability and branding.  
`Drawer` offers a global navigation menu that appears identically across all pages, so users can always access the same navigation options.

In Crampons Etoiles application, each page (home, form, product list) uses a `Scaffold` with the same `AppBar` color and the same `LeftDrawer()`, creating a cohesive and predictable interface across the whole app.


### In the context of user interface design, what do you think is the advantages of using layout widget like Padding, SingleChildScrollView, and ListView when displaying form elements? Provide usage examples from your application.


- **`Padding`** improves readability and visual structure by giving space around form elements.  
  *Example:*  
  ```dart
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
        hintText: "Item Price",
        labelText: "Price",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
        ),
        ),
    ),
    ),

- **`SingleChildScrollView`** prevents overflow errors and allows the whole form to scroll, especially when the on-screen keyboard is open.

  *Example:*  
  ```dart
    child: SingleChildScrollView(
        child: Column();
    ),

- **`ListView`** is useful when presenting long, scrollable lists or dynamic form fields. It automatically manages scrolling, making it ideal for product lists or longer forms.

  *Example:*  
  ```dart
        ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Home'),
        // Redirect to MyHomePage
        onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(),
            ));
        },
    )

### How do you set the color theme so that your Football Shop have a visual identity that is consistent with the shop brand.

To set the brand identity of Crampons Etoiles, I use Flutter’s ThemeData to define a global color theme in the main.dart file that reflects the shop’s visual style. For example, I use a gold/yellow as the primary color reinforces .
