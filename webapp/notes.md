http://127.0.0.1:5000/

# colors

red--text
red

text--darken-4
darken-4

# text size and weight

display-1
display-2
display-3
display-4

font-weight-medium
font-weight-bold

# buttons

color:
pink white--text

color [prop]:

```h
color="pink"
```

depressed [prop]:
removes the shadow and the prop **color** controla o background

flat [prop]:
removes the shadow and makes the background transparents
quando um botão está com a prop **flat**, a prop **color** controla o foreground

# margin and padding

mx-8
py-2

# align and justify (column)

align = verticaly
justify = horizontaly

# old flex grid system

<!--
still the same
<v-container>
   this is a row
   <v-layout row wrap justify justify-bla>

      this is a col
      <v-flex xs  md6 >
         <v-btn>click me</v-btn>
      </v-flex>

      this is a col
      <v-flex xs  md6 >
         <v-btn>click me</v-btn>
      </v-flex>
   </v-layout>
</v-container>
   -->

prepend-icon="mdi-lightbulb"

<v-col cols="12">
   <v-text-field
      label="Password*"
      type="password"
      required
   ></v-text-field>
</v-col>

# vue conditions

v-if=""
v-else-if=""
v-else=""
v-show=""


<!-- sales data -->
{
  id: saleProduct[0],
  productName: saleProduct[1],
  stock: saleProduct[2],
  price: saleProduct[3],
  categoryId: saleProduct[4],
  isLowStock: saleProduct[5]