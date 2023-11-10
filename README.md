# adkhrulevaPW2

**1. Question: What issues prevent us from using storyboards in real projects?**

The real project does not use Storyboards because:
- In a real project, it may be necessary to place a large number of elements on the view. If we use Storyboards, then placing them all can be problematic - strong overlaps are possible.
- A real project involves a large number of views, which will lead to the fact that we will need to place many different screens nearby. Visually it can be confusing. Moreover, there is a possibility of accidentally deleting some screens or elements, or connections (you may not even notice this and break the project).

**2. Question: What does the code on lines 25 and 29 do?**

`25. titleView.translatesAutoresizingMaskIntoConstraints = false`

The autoresizing mask constraints fully specify the View’s size and position. Setting `translatesAutoresizingMaskIntoConstraints` property to `false` allows us to apply our own set of constraints to the `titleView`.

`29. view.addSubview(titleView)`

The `addSubview()` method establishes a strong reference to the `titleView` and sets its next responder to the `view`, which is its new superview. `titleView` is now a child of `view`. ALso this code places the `titleView` in the view hierarchy, making it visible on the screen.

**3. Question: What is a safe area layout guide?**

Safe area layout guide is an area of the view that will remain unobscured. Using `safeAreaLayoutGuide` allows us to avoid clipping and overlapping our objects due to rounded corners, navigation bars, tab bars and toolbars.

**4. Question: What is `[weak self]` on line 23 and why it is important?**

`Weak` reference does not increase the number of references to an object and does not hold an object in memory. The `weak` reference is important because memory is limited and the `value` in this code changes very quickly (even a small movement of the slider results in a large number of `value` changes). We can't afford to store every new `value` in memory. Moreover, we don't need to remember all the values.

**5. Question: What does `clipsToBounds` mean?**

`clipsToBounds` is a boolean value that indicates whether the view, and its subviews, confine their drawing areas to the bounds of the view. Setting this value to `true` causes subviews to be clipped to the bounds of the view. If set to `false`, subviews whose frames extend beyond the visible bounds of the view aren’t clipped.

**6. Question: What is the `valueChanged` type? What is `Void` and what is `Double`?**

- valueChanged — optional closure (a special type of function without the function name)
- Void — return type
- Double — parameter type
