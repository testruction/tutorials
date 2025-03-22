## Object properties _(Exercise 16 of 20)_

You can access and manipulate object properties –– the keys and values that an object contains –– using a method very similar to arrays.

Here's an example using square brackets:

```javascript
const example = {  
  pizza: 'yummy'  
}
   
console.log(example['pizza'])  
```

The above code will print the string 'yummy' to the terminal.

Alternately, you can use dot notation to get identical results:

```javascript
example.pizza
     
example['pizza']  
```

The two lines of code above will both return `yummy`.

## The challenge

Create a file named `object-properties.js`.

In that file, define a variable named `food` like this:

```javascript
const food = {  
  types: 'only pizza'  
}  
```{{copy}}

Use `console.log()`{{}} to print the types property of the food object to the terminal.

Check to see if your program is correct by running this command:

```bash
javascripting verify object-properties.js
```{{exec}}