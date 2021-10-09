<template>
  <div>
    <h1>Home page</h1>
    <p>
      Produtos aparecem aqui
    </p>

    <v-btn 
      color="primary"
      @click="addNewProduct()"
    > 
      <span>Add Product</span> 
      <v-icon right> mdi-plus </v-icon>
    </v-btn>
  </div>

  
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Home',
    data(){
      return{
        products: null
      }
    },
    /* async mounted(){
      const result = await axios.get('http://127.0.0.1:5000/products')
      console.log(result.data)
    }, */
    methods: {
      addNewProduct(){
        console.log("hello world");
      }
    }
  }
</script>
