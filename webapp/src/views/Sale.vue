<template>
  <div>
      <h1 class="my-5 text-center orange--text">Produtos para venda</h1>
      <v-container>
         <v-row>
            <v-col 
               cols="12"
               md="6"
               lg="4"               
               v-for="product in productsForSale" 
               :key="product[0]"
            >
              <v-card
                  class="mx-auto"
                  max-width="344"
               >
                  <v-card-text>
                     <span class="text-h5 text--primary">{{product[1]}}</span>
                     
                     <span v-if="product[5] == 1" class="ml-8 pa-2 red white--text">
                        low
                     </span>
                     <span v-else class="ml-8 pa-2 green white--text">
                        OK
                     </span>
                     
                     <span>Quantidade:{{ product[2]}}</span>
                     <div class="text--primary">R$: {{product[3]}}</div>
                  </v-card-text>
                  <v-card-actions>
                     <v-btn
                     text
                     color="orange"
                  >
                     vender
                     </v-btn>
                  </v-card-actions>
               </v-card>
            </v-col>
         </v-row>
      </v-container>
      <v-btn
         v-show="!hidden"
         color="orange"
         dark
         absolute
         bottom
         right
         fab
         fixed
         class="mb-16 mr-16"
      >
         <v-icon>mdi-plus</v-icon>
      </v-btn>

  </div>
</template>

<script>
   /* import axios from 'axios' */

   export default {
      name: 'sale',
      data(){
         return{
            /* productsForSale: null, */
         productsForSale: [
            [1, 'agua mineral marcax 20L', 19, '7.00', 1, 0],
            [10, 'Alicade de unha', 5, '7.80', 3, 0],
            [5, 'arroz tia joelma 1kg', 26, '6.20', 2, 0],
            [20, 'Bombom de chocolate sonho de funk', 38, '1.00', 2, 0],
            [8, 'café desunião', 14, '5.06', 1, 0],
            [3, 'cerveja skola beet', 41, '3.28', 1, 0],
            [13, 'coca cola zero', 15, '7.80', 1, 1],
            [6, 'cortador de unha', 12, '8.88', 3, 0],
            [12, 'farinha', 5, '7.80', 3, 0],
            [7, 'feijão galopero 500g', 17, '4.99', 2, 0],
            [14, 'Heine quem', 36, '7.90', 1, 0],
            [2, 'macarrao legal 250g', 14, '3.50', 2, 0],
            [4, 'papel higienio 6 rolos', 15, '4.50', 4, 0],
            [40, 'repelente', 9, '4.75', 1, 0],
            [16, 'suco de biribá', 5, '7.90', 1, 1],
            [15, 'suco de pera', 5, '7.90', 1, 0],
            [33, 'tes0', 3, '2.00', 4, 1],
            [29, 'teste10', 3, '2.00', 4, 0],
            [30, 'teste110', 3, '2.00', 4, 1],
            [22, 'teste3', 3, '2.00', 4, 0],
            [23, 'teste4', 3, '2.00', 4, 0],
            [24, 'teste5', 3, '2.00', 4, 0],
            [25, 'teste6', 3, '2.00', 4, 0],
            [26, 'teste7', 3, '2.00', 4, 0],
            [27, 'teste8', 3, '2.00', 4, 0],
            [28, 'teste9', 3, '2.00', 4, 0]
         ],
            hidden: false
         }
      },
      /* async mounted(){
         const result = await axios.get('http://127.0.0.1:5000/sales/products')
         console.log(result.data)
         this.productsForSale = result.data
      } */
   }
</script>
